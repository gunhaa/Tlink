package com.tlink.project.main.model.service;

import java.util.HashMap;
import java.util.Map;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tlink.project.main.model.dao.EmailDAO;
import com.tlink.project.main.model.dao.MainDAO;
import com.tlink.project.user.model.dto.User;

@Service
public class EmailServiceImpl implements EmailService {

	@Autowired
	private EmailDAO dao;
	
	@Autowired
	private MainDAO mainDAO;

	@Autowired
	private JavaMailSender mailSender;
	
	@Autowired // bean으로 등록된 객체 중 타입이 일치하는 Bean을 DI private BCryptPasswordEncoder
	private BCryptPasswordEncoder bcrypt;

	private String fromEmail = "mlmb7801@gmail.com";
	private String fromUsername = "Tlink";

	@Override
	public String createAuthKey() {
		String key = "";
		for (int i = 0; i < 6; i++) {

			int sel1 = (int) (Math.random() * 3); // 0:숫자 / 1,2:영어

			if (sel1 == 0) {

				int num = (int) (Math.random() * 10); // 0~9
				key += num;

			} else {

				char ch = (char) (Math.random() * 26 + 65); // A~Z

				int sel2 = (int) (Math.random() * 2); // 0:소문자 / 1:대문자

				if (sel2 == 0) {
					ch = (char) (ch + ('a' - 'A')); // 소문자로 변경
				}

				key += ch;
			}

		}
		return key;
	}

	@Transactional
	@Override
	public int signUp(String email) {

		// 6자리 난수 인증번호 생성
		String authKey = createAuthKey();
		try {

			// 인증메일 보내기
			MimeMessage mail = mailSender.createMimeMessage();

			// 제목
			String subject = "[Tlink] 회원가입 인증코드";

			// 문자 인코딩
			String charset = "UTF-8";

			// 메일 내용
			String mailContent = "<p>Tlink 회원가입 인증코드입니다.</p>" + "<h3 style='color:#643BAB;'>" + authKey
					+ "</h3>";

			// 송신자(보내는 사람) 지정
			mail.setFrom(new InternetAddress(fromEmail, fromUsername));
			mail.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

			// 수신자(받는사람) 지정

			// 이메일 제목 세팅
			mail.setSubject(subject, charset);

			// 내용 세팅
			mail.setText(mailContent, charset, "html"); // "html" 추가 시 HTML 태그가 해석됨

			mailSender.send(mail);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}

		Map<String, String> map = new HashMap<String, String>();
		map.put("authKey", authKey);
		map.put("email", email);

		System.out.println(map);

		int result = dao.updateAuthKey(map);

		if (result == 0) {
			result = dao.insertAuthKey(map);
		}

		return result;
	}

	@Override
	public int checkAuthKey(Map<String, Object> paramMap) {
		return dao.checkAuthKey(paramMap);
	}
	
	// 비밀번호 찾기 일치하는 회원 조회
	@Override
	public int selectUser(User inputUser) {
		return dao.selectUser(inputUser);
	}

	@Override
	public int sendNewPw(String userEmail) {
		// 6자리 난수 인증번호 생성
		String randomKey = createAuthKey();
		
		try {

			// 인증메일 보내기
			MimeMessage mail = mailSender.createMimeMessage();

			// 제목
			String subject = "[Tlink] 임시 비밀번호";

			// 문자 인코딩
			String charset = "UTF-8";

			// 메일 내용
			String mailContent = "<p>Tlink 임시 비밀번호입니다.</p>" + "<h3 style='color:#643BAB;'>" + randomKey
					+ "</h3>";

			// 송신자(보내는 사람) 지정
			mail.setFrom(new InternetAddress(fromEmail, fromUsername));
			mail.addRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));

			// 수신자(받는사람) 지정

			// 이메일 제목 세팅
			mail.setSubject(subject, charset);

			// 내용 세팅
			mail.setText(mailContent, charset, "html"); // "html" 추가 시 HTML 태그가 해석됨

			mailSender.send(mail);
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		
		String newPw = bcrypt.encode(randomKey);

		Map<String, String> map = new HashMap<String, String>();
		map.put("newPw", newPw);
		map.put("email", userEmail);



		return dao.updateNewPw(map); 
	}

	@Override
	public int invite(String userEmail, int projectNo, int portNo) {
		
		int result = mainDAO.selectDupEmail(userEmail);
		
		System.out.println("serviceImpl : "+result);
		
		if(result > 0) {
			
			try {
				
				// 인증메일 보내기
				MimeMessage mail = mailSender.createMimeMessage();
				
				// 제목
				String subject = "[Tlink] 프로젝트 초대";
				
				// 문자 인코딩
				String charset = "UTF-8";
				
				// 메일 내용
				String mailContent = "<h3 style='color:#643BAB;'>안녕하세요!</h3>"
						+ "<p>당신은 새로운 프로젝트에 초대되었습니다.</p>"
						+ "<p><a href='http://localhost:" + portNo + "/project/accept?projectNo="+ projectNo +"&userEmail="+userEmail+"' style='color:#643BAB;'>프로젝트 가입하기</a></p>"
						+ "<p>감사합니다!</p>";
				
				// 송신자(보내는 사람) 지정
				mail.setFrom(new InternetAddress(fromEmail, fromUsername));
				mail.addRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));
				
				// 수신자(받는사람) 지정
				
				// 이메일 제목 세팅
				mail.setSubject(subject, charset);
				
				// 내용 세팅
				mail.setText(mailContent, charset, "html"); // "html" 추가 시 HTML 태그가 해석됨
				
				mailSender.send(mail);
			} catch (Exception e) {
				e.printStackTrace();
				return 0;
			}
			
		}
		
		
		return result;
	}

}
