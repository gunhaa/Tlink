package com.tlink.project.main.controller;

import java.util.HashMap;
import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tlink.project.main.model.service.EmailService;
import com.tlink.project.user.model.dto.User;

import oracle.jdbc.proxy.annotation.Post;

@Controller
@RequestMapping("/sendEmail")
@SessionAttributes("authKey")
public class EmailController {

	@Autowired
	private EmailService service;
	
    @GetMapping("/signUp")
    @ResponseBody
    public int signUp(String email) {
        return service.signUp(email);
    }
    
    @GetMapping("/checkAuthKey")
    @ResponseBody
    public int checkAuthKey(@RequestParam Map<String, Object> paramMap){

        return service.checkAuthKey(paramMap);
    }
    
    @GetMapping("/findPw")
    @ResponseBody
    public int findPw(User inputUser) {
    	
    	// 입력한 값과 일치하는 회원 조회
    	int result = service.selectUser(inputUser);
    	
    	if(result > 0) {
    		
    		// 회원이 있을 시 난수 발생하여 이메일 전송 후 해당 난수로 비밀번호 변경
    		result = service.sendNewPw(inputUser.getUserEmail());
    		
    	}
    	
    	return result;
    }
    
    @PostMapping("/invite")
    public String invite(String userEmail, int projectNo, RedirectAttributes ra, HttpServletRequest request) {

    	int portNo = request.getServerPort();
    	
    	int result = service.invite(userEmail, projectNo, portNo);
    	
    	String message = null;
    	
    	if(result > 0) message = "초대 메일이 전송되었습니다.";
    	else message = "존재하지 않는 회원입니다.";
    	
    	ra.addFlashAttribute("message", message);
    	
    	return "redirect:/project/member?projectNo="+projectNo;
    }
}
