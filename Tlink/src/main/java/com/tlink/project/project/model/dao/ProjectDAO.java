package com.tlink.project.project.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.tlink.project.project.model.dto.Project;
import com.tlink.project.user.model.dto.User;

@Repository
public class ProjectDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int create(Project project) {
		return sqlSession.insert("projectMapper.create", project);
	}

	// user-project insert
	public int insertUser(Map<String, Object> map) {
		return sqlSession.insert("projectMapper.insertUser", map);
	}

	// 자동 완성
	public List<Project> autocomplete(Map<String, Object> map) {
		return sqlSession.selectList("projectMapper.autocomplete", map);
	}

	public int deleteProject(int projectNo) {
		return sqlSession.delete("projectMapper.deleteProject", projectNo);
	}

	public Project selectProject(int projectNo) {
		return sqlSession.selectOne("projectMapper.selectProject", projectNo);
	}

	public List<User> selectMemberList(int projectNo) {
		return sqlSession.selectList("projectMapper.selectMemberList", projectNo);
	}

	public int deleteMember(Map<String, Object> map) {
		return sqlSession.delete("projectMapper.deleteMember", map);
	}

	// 이메일로 userNo 조회
	public int selectUserNo(String userEmail) {
		return sqlSession.selectOne("projectMapper.selectUserNo", userEmail);
	}

	public int changeManager(Map<String, Object> map) {
		return sqlSession.update("projectMapper.changeManager", map);
	}

	public int insertVideoRoom(int projectNo) {
		return sqlSession.insert("projectMapper.insertVideoRoom", projectNo);
	}



}
