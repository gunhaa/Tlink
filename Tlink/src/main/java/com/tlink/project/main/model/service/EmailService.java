package com.tlink.project.main.model.service;

import java.util.Map;

import com.tlink.project.user.model.dto.User;

public interface EmailService {

	int signUp(String email);
	
	String createAuthKey();

	int checkAuthKey(Map<String, Object> paramMap);

	int selectUser(User inputUser);

	int sendNewPw(String userEmail);

	int invite(String userEmail, int projectNo, int portNo);

}
