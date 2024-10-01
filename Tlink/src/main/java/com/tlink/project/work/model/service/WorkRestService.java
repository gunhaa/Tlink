package com.tlink.project.work.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.tlink.project.work.model.dto.CommentWork;
import com.tlink.project.work.model.dto.Todo;
import com.tlink.project.work.model.dto.Work;


public interface WorkRestService {

	int update(Map<String, Object> data);

	int delete(Map<String, Object> data);

	int insertTable(Map<String, Object> data);

	
	int updateWorkTitle(Map<String, Object> data);
	int updateDueDate(Map<String, Object> data);
	int updateWorkState(Map<String, Object> data);
	int updateWorkPriority(Map<String, Object> data);
	int updateWorkManager(Map<String, Object> data);
	int updateParentNo(Map<String, Object> data);

	Work insertStateBy(Map<String, Object> data);

	int insertMywork(Map<String, Object> data);

	Map<Integer, Object> managerByMList(Map<String, Object> data);

	Map<Integer, Object> projectByPList(Map<String, Object> data);

	List<Todo> todoTList(Map<String, Object> data);

	int updateTodoState(Map<String, Object> data);

	Todo insertTodo(Map<String, Object> data);

	int deleteTodo(Map<String, Object> data);

	int updateTodoTitle(Map<String, Object> data);

	int commentInsert(Map<String, Object> data);

	int commentDelete(Map<String, Object> data);

	List<CommentWork> commentSelect(Map<String, Object> data);

	int commentUpdate(Map<String, Object> data);

	List<Work> selectList(Map<String, Object> data);



}
