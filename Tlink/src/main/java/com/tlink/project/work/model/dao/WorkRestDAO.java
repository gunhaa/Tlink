package com.tlink.project.work.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.work.model.dto.CommentWork;
import com.tlink.project.work.model.dto.Todo;
import com.tlink.project.work.model.dto.Work;

@Repository
public class WorkRestDAO {
	@Autowired private SqlSessionTemplate sqlSession;



	
	public int update(Map<String, Object> data) {
		return  sqlSession.update("workRestMapper.update", data);
		
	}




	public int delete(Map<String, Object> data) {
		return  sqlSession.delete("workRestMapper.delete", data);
	}




	public int insertTable(Map<String, Object> data) {
		 int result=sqlSession.insert("workRestMapper.insertTable", data);
		 int workNo=0;
		 if(result !=0) { workNo=sqlSession.selectOne("workRestMapper.selectWorkNo"); }
		 System.out.println(workNo);
		 return workNo;
	}




	public int updateWorkTitle(Map<String, Object> data) {
		return sqlSession.update("workRestMapper.updateWorkTitle", data);
	}
	public int updateDueDate(Map<String, Object> data) {
		return sqlSession.update("workRestMapper.updateDueDate", data);
	}
	public int updateWorkState(Map<String, Object> data) {
		return sqlSession.update("workRestMapper.updateWorkState", data);
	}
	public int updateWorkPriority(Map<String, Object> data) {
		return sqlSession.update("workRestMapper.updateWorkPriority", data);
	}
	public int updateWorkManager(Map<String, Object> data) {
		return sqlSession.update("workRestMapper.updateWorkManager", data);
	}
	public int updateParentNo(Map<String, Object> data) {
		return sqlSession.update("workRestMapper.updateParentNo", data);
	}




	public int insertMywork(Map<String, Object> data) {
		 int result=sqlSession.insert("workRestMapper.insertMywork", data);
		 int workNo=0;
		 if(result !=0) { workNo=sqlSession.selectOne("workRestMapper.selectWorkNo"); }
		 System.out.println(workNo);
		 return workNo;
	}
	
	
	
	


	public Map<Integer, Object> managerByMList(Map<String, Object> data) {
		List<Integer> intList = new ArrayList<>();
		intList=sqlSession.selectList("workRestMapper.selectManager", data);
		
		Map<Integer, Object> map=new HashMap<>();
		for(int managerNo : intList){
			List<Work> wList=sqlSession.selectList("workRestMapper.selectManagerByWork", managerNo);
			map.put(managerNo, wList);
		}
		
		return map;
	}




	public Map<Integer, Object> projectByPList(Map<String, Object> data) {
		List<Integer> intList = new ArrayList<>();
		intList=sqlSession.selectList("workRestMapper.selectProject", data);
		
		Map<Integer, Object> map=new HashMap<>();
		for(int projectNo : intList){
			List<Work> wList=sqlSession.selectList("workRestMapper.selectProjectByWork", projectNo);
			map.put(projectNo, wList);
		}
		
		return map;
	}


	
	
	

	public Work insertStateBy(Map<String, Object> data) {
		 int result=sqlSession.insert("workRestMapper.insertStateBy", data);
		 int workNo=0;
		 Work work=null;
		 if(result !=0) { workNo=sqlSession.selectOne("workRestMapper.selectWorkNo"); }
		 System.out.println(workNo);
		 if(workNo !=0) { work=sqlSession.selectOne("workRestMapper.selectWork",workNo); }
		 System.out.println(work);
		 return work;
	}




	public List<Todo> todoTList(Map<String, Object> data) {
		return sqlSession.selectList("todoRestMapper.todoTList", data);
	}




	public int updateTodoState(Map<String, Object> data) {
		return sqlSession.update("todoRestMapper.updateTodoState", data);
	}




	public Todo insertTodo(Map<String, Object> data) {
		 int result=sqlSession.insert("todoRestMapper.insertTodo", data);
		 int todoNo=0;
		 Todo todo=null;
		 if(result !=0) { todoNo=sqlSession.selectOne("todoRestMapper.selectTodoNo"); }
		 System.out.println(todoNo);
		 if(todoNo !=0) { todo=sqlSession.selectOne("todoRestMapper.selectTodo",todoNo); }
		 System.out.println(todo);
		 return todo;
	}




	public int deleteTodo(Map<String, Object> data) {
		return  sqlSession.delete("todoRestMapper.deleteTodo", data);
	}




	public int updateTodoTitle(Map<String, Object> data) {
		return sqlSession.update("todoRestMapper.updateTodoTitle", data);
	}




	public int commentInsert(Map<String, Object> data) {
		return sqlSession.insert("workRestMapper.commentInsert", data);
	}

	public int commentDelete(Map<String, Object> data) {
		return sqlSession.update("workRestMapper.commentDelete", data);
	}
	public List<CommentWork> commentSelect(Map<String, Object> data) {
		
		List<CommentWork> a= sqlSession.selectList("workRestMapper.commentSelect", data);
		return sqlSession.selectList("workRestMapper.commentSelect", data);
	}




	public int commentUpdate(Map<String, Object> data) {
		return sqlSession.update("workRestMapper.commentUpdate", data);
	}




	public List<Work> selectList(Map<String, Object> data) {
		return sqlSession.selectList("workRestMapper.selectList", data);
	}




	
}
