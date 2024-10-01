package com.tlink.project.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.context.annotation.SessionScope;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tlink.project.project.model.dto.Project;
import com.tlink.project.project.model.service.ProjectService;
import com.tlink.project.user.model.dto.User;

@Controller
@RequestMapping("/project")
@SessionAttributes("loginUser")
public class ProjectController {
	
	@Autowired
	private ProjectService service;

	@PostMapping("/create")
	public String create(Project project, @SessionAttribute("loginUser") User loginUser,
			RedirectAttributes ra) {
		
		project.setManager(loginUser.getUserNo());
		
		int result = service.create(project);
		
		String message = null;
		if(result > 0) message = project.getProjectTitle() + "이(가) 생성되었습니다.";
		else message = "프로젝트 생성 실패";
		
		
		ra.addFlashAttribute("message", message);
		
		
		return "redirect:/myPage/project";
	}
	
	// 자동완성
	@GetMapping("/autocomplete")
	@ResponseBody
	public List<Project> autocomplete(String query, @SessionAttribute("loginUser") User loginUser){
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("query", query);
		map.put("userNo", loginUser.getUserNo());
		
		return service.autocomplete(map);
	}
	
	// 검색
	@GetMapping("/search")
	@ResponseBody
	public List<Project> search(String query, @SessionAttribute("loginUser") User loginUser){
		
		return null;
	}
	
	// 프로젝트 삭제 페이지
	@GetMapping("/delete")
	public String delete(int projectNo, Model model) {
		
		model.addAttribute("projectNo", projectNo);
		
		return "/project/project-delete";
	}
	
	// 프로젝트 삭제
	@GetMapping("/deleteProject")
	public String deleteProject(int projectNo, RedirectAttributes ra) {
		
		int result = service.deleteProject(projectNo);
		
		ra.addFlashAttribute("message", "프로젝트가 삭제되었습니다.");
		
		return "redirect:/myPage/project";
	}
	
	// 멤버 관리
	@GetMapping("/member")
	public String member(int projectNo, Model model) {
		
		
		
		Project project = service.selectProject(projectNo);
		
		List<User> memberList = service.selectMemeberList(projectNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("project", project);
		map.put("memberList", memberList);
		
		model.addAttribute("map", map);
		
		model.addAttribute("projectNo", projectNo);
		
		return "/project/member";
	}
	
	// 멤버 삭제
	@GetMapping("/deleteMember")
	public String deleteMember(int userNo, int projectNo, RedirectAttributes ra) {
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("userNo", userNo);
		map.put("projectNo", projectNo);
		
		int result = service.deleteMember(map);
		
		ra.addFlashAttribute("message", "삭제되었습니다.");
		
		return "redirect:/project/member?projectNo="+projectNo;
	}
	
	@GetMapping("/accept")
	public String accept(int projectNo, String userEmail, RedirectAttributes ra) {
		
		int result = service.accept(projectNo, userEmail);
		
		String message = null;
		
		if(result > 0) message = "프로젝트에 가입되었습니다. 로그인 후 이용해주세요.";
		else message = "프로젝트 가입 실패";
		
		ra.addFlashAttribute("message", message);
		
		return "redirect:/";
	}
	
	// 프로젝트 탈퇴 페이지
	@GetMapping("/secession")
	public String secession(int projectNo, Model model) {
		
		Project project = service.selectProject(projectNo);
		
		List<User> memberList = service.selectMemeberList(projectNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		
		map.put("project", project);
		map.put("memberList", memberList);
		
		model.addAttribute("map", map);
		
		model.addAttribute("projectNo", projectNo);
		
		return "/project/project-secession";
	}
	
	// 프로젝트 탈퇴
	@PostMapping("/secession")
	public String secession(int projectNo, @RequestParam(required = false) Integer userNo, @SessionAttribute("loginUser") User loginUser) {
		
		int result = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("projectNo", projectNo);
		map.put("manager", userNo);
		map.put("userNo", loginUser.getUserNo());
		
		if(userNo != null) {
			result = service.changeManager(map);
		}
		
		result = service.deleteMember(map);
		
		String message = null;
		String path = "redirect:";
		
		if(result > 0) {
			message = "탈퇴되었습니다.";
			path += "/myPage/project";
		}else {
			message = "탈퇴 실패";
			path += "secession?projectNo="+projectNo;
		}
		
		return path;
	}
	
	
}
