package com.tlink.project.project.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tlink.project.main.model.dao.MainDAO;
import com.tlink.project.myPage.model.dao.MyPageDAO;
import com.tlink.project.project.model.dao.ProjectDAO;
import com.tlink.project.project.model.dto.Project;
import com.tlink.project.user.model.dto.User;

@Service
public class ProjectServiceImpl implements ProjectService{

	@Autowired
	private ProjectDAO dao;
	
	@Autowired
	private MainDAO mainDAO;

	// 프로젝트 생성
	@Override
	public int create(Project project) {
		
		int result = dao.create(project);
		
		// 생성된 프로젝트 아이디를 반환
		int projectNo = project.getProjectNo();
		
		
		if(result > 0) {
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("userNo", project.getManager());
			map.put("projectNo", projectNo);
			
			result = dao.insertUser(map);
			
			if(result > 0) result = dao.insertVideoRoom(projectNo);
			
		}
		
		return result;
	}

	@Override
	public List<Project> autocomplete(Map<String, Object> map) {
		return dao.autocomplete(map);
	}

	// 프로젝트 삭제
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteProject(int projectNo) {
		
		return dao.deleteProject(projectNo);
	}

	// 프로젝트 조회
	@Override
	public Project selectProject(int projectNo) {
		return dao.selectProject(projectNo);
	}

	// 멤버 목록 조회
	@Override
	public List<User> selectMemeberList(int projectNo) {
		return dao.selectMemberList(projectNo);
	}

	// 멤버 삭제(탈퇴)
	@Override
	public int deleteMember(Map<String, Object> map) {
		return dao.deleteMember(map);
	}

	// 초대 수락
	@Override
	public int accept(int projectNo, String userEmail) {
		
		// 이메일로 회원번호 조회
		int result = dao.selectUserNo(userEmail);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("userNo", result);
		map.put("projectNo", projectNo);
		
		// 유저 프로젝트 insert
		if(result > 0) result = dao.insertUser(map);
		
		return result;
	}

	// 매니저 위임
	@Override
	public int changeManager(Map<String, Object> map) {
		return dao.changeManager(map);
	}


}
