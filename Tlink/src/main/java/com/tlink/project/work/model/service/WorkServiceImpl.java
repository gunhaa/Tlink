package com.tlink.project.work.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tlink.project.user.model.dto.User;
import com.tlink.project.work.model.dao.WorkDAO;
import com.tlink.project.work.model.dto.Work;

@Service
public class WorkServiceImpl implements WorkService{
	@Autowired private WorkDAO dao;

	@Override
	@Transactional(rollbackFor=Exception.class)
	public void test() {
		dao.test();
	}

	@Override
	public List<Work> table(int projectNo) {
		return dao.table(projectNo);
	}

	@Override
	public List<User> tableManagerList(int projectNo) {
		return dao.tableManagerList(projectNo);
	}

	@Override
	public List<Work> tableParentList(int projectNo) {
		return dao.tableParentList(projectNo);
	}

	@Override
	public Work workSheet(int workNo, int projectNo) {
		return dao.workSheet(workNo, projectNo);
	}

	@Override
	public List<Work> mywork(int projectNo, int userNo) {
		return dao.mywork(projectNo, userNo);
	}
	
	
	
	
}
