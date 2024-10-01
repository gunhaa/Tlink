package com.tlink.project.myPage.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tlink.project.myPage.model.service.MyPageService;
import com.tlink.project.project.model.dto.Project;
import com.tlink.project.user.model.dto.User;

@Controller
@RequestMapping("/myPage/*")
public class MyPageController {
	
	@Autowired
	private MyPageService service;
	
	
	// 프로젝트 목록 페이지
	@GetMapping("/project")
	public String myPageProject(@SessionAttribute("loginUser") User loginUser, Model model) {
		
		List<Project> projectList = service.selectProjectList(loginUser.getUserNo());
		
		model.addAttribute("projectList", projectList);
		
		
		
		return "/myPage/myPage-project";
	}
	
	// 내 정보 페이지
	@GetMapping("/info")
	public String userInfo() {
		return "/myPage/myPage-info";
	}
	
	// 비밀번호 변경 페이지
	@GetMapping("/changePw")
	public String changePw() {
		return "/myPage/myPage-changePw";
	}
	
	// 회원 탈퇴 페이지
	@GetMapping("/secession")
	public String secession() {
		return "/myPage/myPage-secession";
	}
	
	// 관리자 계정 페이지
	@GetMapping("/systemUser")
	public String systemUser(Model model) {
		
		List<User> adminList = service.selectAdmin();
		
		model.addAttribute("adminList", adminList);
		
		return "/myPage/systemUser";
	}	
	
	
	// 비밀번호 변경
	@PostMapping("/changePw")
	@ResponseBody
	public int changePw(@RequestBody Map<String, String> map, @SessionAttribute("loginUser") User user) {
		
		return service.changePw(map, user.getUserNo());
	}
	
	// 회원 탈퇴
	@PostMapping("/secession")
	public String secession(String inputPw, @SessionAttribute("loginUser") User user,
			RedirectAttributes ra, SessionStatus status) {
		
		int result = service.secession(inputPw, user.getUserNo());
		
		String path = "redirect:";
		String message = "";
		
		if(result > 0) {
			path += "/";
			message = "탈퇴되었습니다.";
			status.setComplete();

		}else {
			path += "secession";
			message = "비밀번호가 일치하지 않습니다.";
		}
		
		ra.addFlashAttribute("message", message);
		return path;
	}
	
	// 프로필 이미지 수정
	@PostMapping("/profileImage")
	@ResponseBody
	public int updateProfile(@RequestParam("profileImage") MultipartFile profileImage
			, @SessionAttribute("loginUser") User loginUser
			, RedirectAttributes ra
			, HttpSession session)throws Exception{
		
		// 웹 접근 경로
		String webPath = "/resources/images/user/";
		
		// 실제로 이미지 파일이 저장되야 하는 서버 컴퓨터 경로
		String filePath = session.getServletContext().getRealPath(webPath);
		
		return service.updateProfile(profileImage, webPath, filePath, loginUser);
	}
	
	// 프로필 이미지 수정(삭제)
	@GetMapping("/profileImage")
	@ResponseBody
	public int deleteProfile(@SessionAttribute("loginUser") User loginUser) {
		
		loginUser.setProfileImg(null);
		
		return service.deleteProfile(loginUser.getUserNo());
	}
	
	// 내 정보 수정
	@PostMapping("/info")
	public String userInfo( @SessionAttribute("loginUser") User loginUser, User inputUser, String[] userAddr, RedirectAttributes ra) {
		
		loginUser.setUserPhone(inputUser.getUserPhone());
		
		// 만약 주소를 입력하지 않은 경우(,,) null로 변경
		 if(inputUser.getUserAddr().equals(",,")) {
			 inputUser.setUserAddr(null);
		 }else {
			 // Stirng.join("구분자", String[])
			 // 배열의 요소를 하나의 문자열로 변경
			 // 단, 요소 사이에 "구분자" 추가
			String addr = String.join("^^^", userAddr);
			loginUser.setUserAddr(addr);
		 }
		
		
		int result = service.updateInfo(loginUser);
		
		String message = null;
		
		if(result > 0) message = "회원 정보가 변경되었습니다.";
		else message = "회원 정보 변경 실패";
		
		ra.addFlashAttribute("message", message);
		
		return "redirect:info";
	}
}
