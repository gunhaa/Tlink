package com.tlink.project.main.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.project.model.dto.Project;
import com.tlink.project.user.model.dto.User;

@Repository
public class MainDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	// 로그인
	public User login(User inputUser) {
		
		return sqlSession.selectOne("userMapper.login", inputUser);
	}

	// 회원가입
	public int signUp(User inputUser) {
		
		return sqlSession.insert("userMapper.signUp", inputUser);
	}

	// 이메일 중복 검사
	public int selectDupEmail(String email) {
		
		return sqlSession.selectOne("userMapper.selectDupEmail", email);
	}


	// 관리자 생성
	public int createAdmin(User inputUser) {
		return sqlSession.insert("userMapper.createAdmin", inputUser);
	}



}
