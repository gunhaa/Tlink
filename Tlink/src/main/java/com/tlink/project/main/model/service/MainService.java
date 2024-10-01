package com.tlink.project.main.model.service;

import com.tlink.project.user.model.dto.User;

public interface MainService {

	// 로그인
	User login(User inputUser);

	// 회원가입
	int signUp(User inputUser);

	// 이메일 중복 검사
	int selectDupEmail(String email);

	int createAdmin(User inputUser);

	int deleteAdmin(int userNo);

}
