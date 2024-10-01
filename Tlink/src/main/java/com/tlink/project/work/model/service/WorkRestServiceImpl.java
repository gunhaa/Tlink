package com.tlink.project.work.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tlink.project.work.model.dao.WorkDAO;
import com.tlink.project.work.model.dao.WorkRestDAO;
import com.tlink.project.work.model.dto.CommentWork;
import com.tlink.project.work.model.dto.Todo;
import com.tlink.project.work.model.dto.Work;

@Service
public class WorkRestServiceImpl implements WorkRestService{
	
	@Autowired private WorkRestDAO dao;

	@Override @Transactional(rollbackFor=Exception.class)
	public int update(Map<String, Object> data) {
		return dao.update(data);
	}

	@Override  @Transactional(rollbackFor=Exception.class)
	public int delete(Map<String, Object> data) {
		return dao.delete(data);
	}

	@Override
	public int insertTable(Map<String, Object> data) {
		return dao.insertTable(data);
	}

	
	
	@Override
	public int updateWorkTitle(Map<String, Object> data) {
		return dao.updateWorkTitle(data);
	}
	@Override
	public int updateDueDate(Map<String, Object> data) {
		return dao.updateDueDate(data);
	}
	@Override
	public int updateWorkState(Map<String, Object> data) {
		return dao.updateWorkState(data);
	}
	@Override
	public int updateWorkPriority(Map<String, Object> data) {
		return dao.updateWorkPriority(data);
	}
	@Override
	public int updateWorkManager(Map<String, Object> data) {
		return dao.updateWorkManager(data);
	}
	@Override
	public int updateParentNo(Map<String, Object> data) {
		return dao.updateParentNo(data);
	}
	
	
	
	@Override
	public int insertMywork(Map<String, Object> data) {
		return dao.insertMywork(data);
	}
	
	
	@Override
	public Map<Integer, Object> managerByMList(Map<String, Object> data) {
		return dao.managerByMList(data);
	}
	@Override
	public Map<Integer, Object> projectByPList(Map<String, Object> data) {
		return dao.projectByPList(data);
	}


	
	@Override
	public Work insertStateBy(Map<String, Object> data) {
		return dao.insertStateBy(data);
	}

	@Override
	public List<Todo> todoTList(Map<String, Object> data) {
		return dao.todoTList(data);
	}

	@Override
	public int updateTodoState(Map<String, Object> data) {
		return dao.updateTodoState(data);
	}

	@Override
	public Todo insertTodo(Map<String, Object> data) {
		return dao.insertTodo(data);
	}

	@Override
	public int deleteTodo(Map<String, Object> data) {
		return dao.deleteTodo(data);
	}

	@Override
	public int updateTodoTitle(Map<String, Object> data) {
		return  dao.updateTodoTitle(data);
	}

	
	
	@Override
	public int commentInsert(Map<String, Object> data) {
		return dao.commentInsert(data);
	}

	@Override
	public int commentDelete(Map<String, Object> data) {
		return dao.commentDelete(data);
	}
	@Override
	public int commentUpdate(Map<String, Object> data) {
		return dao.commentUpdate(data);
	}
	
	@Override
	public List<CommentWork> commentSelect(Map<String, Object> data) {
		return dao.commentSelect(data);
	}

	@Override
	public List<Work> selectList(Map<String, Object> data) {
		return dao.selectList(data);
	}




	



	

	
	
	
}
