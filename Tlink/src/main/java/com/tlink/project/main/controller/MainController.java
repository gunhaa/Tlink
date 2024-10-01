package com.tlink.project.main.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tlink.project.main.model.service.MainService;
import com.tlink.project.user.model.dto.User;


@Controller
@SessionAttributes("loginUser")
public class MainController {
	
	@Autowired
	private MainService service;

	// 메인 화면
	@RequestMapping("/")
	public String main() {
		return "/main/main";
	}
	
	// 로그인 화면
	@GetMapping("/login")
	public String login() {
		return "/main/login";
	}
	
	// 회원가입 화면
	@GetMapping("/signup")
	public String signup() {
		return "/myPage/signup";
	}
	
	// 비밀번호 찾기
	@GetMapping("/findPw")
	public String fingPw() {
		return "/myPage/findPw";
	}
	
	// 로그인
	@PostMapping("/login")
	public String login(User inputUser, Model model, RedirectAttributes ra) {
		
		User loginUser = service.login(inputUser);
		
		String path = "redirect:";
		String message = "";
		
		if(loginUser != null) {
			if(loginUser.getRole().equals("U")) {
				path += "/myPage/project";
			}else {
				path += "/notice";
			}
			model.addAttribute("loginUser", loginUser);
			message = loginUser.getUserName() + "님 환영합니다.";
		}else {
			path += "/login";
			message = "아이디 또는 비밀번호가 일치하지 않습니다.";
		}
		
		ra.addFlashAttribute("message", message);
		
		return path;
	}
	
	// 로그아웃
	@GetMapping("/logout")
	public String logout(SessionStatus status, RedirectAttributes ra) {
		
		status.setComplete();
		
		ra.addFlashAttribute("message", "로그아웃 되었습니다.");
		
		return "redirect:/";
	}
	
	// 회원가입 진행
	@PostMapping("/signUp")
	public String signUp(User inputUser, String[] userAddr, RedirectAttributes ra) {
		// ------------------ 매개변수 설명 -----------------------
		

		
		// 만약 주소를 입력하지 않은 경우(,,) null로 변경
		 if(inputUser.getUserAddr().equals(",,")) {
			 inputUser.setUserAddr(null);
		 }else {
			 // Stirng.join("구분자", String[])
			 // 배열의 요소를 하나의 문자열로 변경
			 // 단, 요소 사이에 "구분자" 추가
			String addr = String.join("^^^", userAddr);
			inputUser.setUserAddr(addr);
		 }
		
		// 회원가입 서비스 호출
		int result = service.signUp(inputUser);
		
		// 가입 성공 여부에 따라서 주소 결정
		String path = "redirect:";
		String message = "";
		
		if(result > 0) { // 가입 성공
			// 메인 페이지
			// 000님의 가입을 환영합니다.
			path += "/";
			message = inputUser.getUserName() + "님의 가입을 환영합니다.";
			
		}else { // 가입 실패
			// 회원가입 페이지
			// 회원가입 실패
			// path += "/member/signUp"; // 절대 경로
			path += "signUp"; // 상대 경로
			message = "회원가입 실패";
		}
		
		ra.addFlashAttribute("message", message);
		
		return path;
	}
	
	// 중복 이메일 검사
	// produces 속성은 한글이 깨질 때 사용
	@GetMapping("/selectDupEmail")
	@ResponseBody // HttpMessageConverter를 이용해서
				  // JS에서 인식할 수 있는 형태(text/JSON) 변환 후
				  // 비동기 요청한 곳으로 돌아감
	public int selectDupEmail(String email) {

		return service.selectDupEmail(email);
	}
	
	// 관리자 생성
	@PostMapping("/createAdmin")
	public String createAdmin(User inputUser, RedirectAttributes ra) {
		
		int result = service.createAdmin(inputUser);
		
		String message = "";
		
		if(result > 0) { // 가입 성공
			message = "관리자가 생성되었습니다.";
			
		}else { // 가입 실패
			message = "생성 실패";
		}
		
		ra.addFlashAttribute("message", message);
		
		return "redirect:/myPage/systemUser";
	}
	
	@GetMapping("/deleteAdmin")
	public String deleteAdmin(int userNo, RedirectAttributes ra) {
		
		int result = service.deleteAdmin(userNo);
		
		String message = "";
		
		if(result > 0) { // 가입 성공
			message = "관리자가 삭제 되었습니다.";
			
		}else { // 가입 실패
			message = "삭제 실패";
		}
		
		ra.addFlashAttribute("message", message);
		
		return "redirect:/myPage/systemUser";
	}
	
	
	
	
}
