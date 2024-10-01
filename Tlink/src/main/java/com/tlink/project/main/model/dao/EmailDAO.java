package com.tlink.project.main.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.user.model.dto.User;

@Repository
public class EmailDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public int updateAuthKey(Map<String, String> map) {
		return sqlSession.update("emailMapper.updateAuthKey", map);
	}

	public int insertAuthKey(Map<String, String> map) {
		return sqlSession.insert("emailMapper.insertAuthKey", map);
	}

	public int checkAuthKey(Map<String, Object> paramMap) {
		return sqlSession.selectOne("emailMapper.checkAuthKey", paramMap);
	}

	public int selectUser(User inputUser) {
		return sqlSession.selectOne("emailMapper.selectUser", inputUser);
	}

	public int updateNewPw(Map<String, String> map) {
		return sqlSession.update("emailMapper.updateNewPw", map);
	}

}
