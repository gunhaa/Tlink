package com.tlink.project.myPage.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.project.model.dto.Project;
import com.tlink.project.user.model.dto.User;

@Repository
public class MyPageDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 현재 비밀번호 가져오기
	public String selectCurrentPw(int userNo) {
		return sqlSession.selectOne("myPageMapper.selectCurrentPw", userNo);
	}
	
	// 비밀번호 변경
	public int changePw(Map<String, String> map) {
		return sqlSession.update("myPageMapper.changePw", map);
	}

	public int secession(int userNo) {
		return sqlSession.update("myPageMapper.secession", userNo);
	}

	public int updateProfile(User loginUser) {
		return sqlSession.update("myPageMapper.updateProfile", loginUser);
	}

	public int deleteProfile(int userNo) {
		return sqlSession.update("myPageMapper.deleteProfile", userNo);
	}

	public int updateinfo(User loginUser) {
		return sqlSession.update("myPageMapper.updateinfo", loginUser);
	}

	public List<User> selectAdmin() {
		return sqlSession.selectList("myPageMapper.selectAdmin");
	}

	// 프로젝트 리스트 조회
	public List<Project> selectProjectList(int userNo) {
		return sqlSession.selectList("userMapper.selectProjectList", userNo);
	}


}
