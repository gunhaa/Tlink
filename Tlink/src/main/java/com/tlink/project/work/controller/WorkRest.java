package com.tlink.project.work.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.tlink.project.user.model.dto.User;
import com.tlink.project.work.model.dto.Todo;
import com.tlink.project.work.model.dto.Work;
import com.tlink.project.work.model.service.WorkRestService;
import com.tlink.project.work.model.service.WorkService;

@Controller
@RestController
public class WorkRest {
	
	@Autowired private WorkRestService service;
	@Autowired private WorkService workService;
	
	
	//작업수정
	@PutMapping(value=("/workSheet/detail"))
	public int update(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.update(data);
	}

	@DeleteMapping(value=("/workSheet/detail"))
	public int delete(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.delete(data);
	}
	
	
	
	//작업차트
	@PostMapping(value=("/work/select"))
	public List<Work> selectWork(@RequestBody Map<String, Object> data) {
		int projectNo=(Integer)data.get("projectNo");
		return workService.table(projectNo);
	}
	
	
	

	
	//table
	@PostMapping(value=("/workList/table"))
	public int insertTable(@RequestBody Map<String, Object> data) {
		return service.insertTable(data);
	}
	
	
	@PostMapping(value=("/workList/table/pList"))              
	public List<Work> tablePList(@RequestBody Map<String, Object> data, Model model)          { 
		System.out.println(data);
		int projectNo=(int)data.get("projectNo");

		List<Work> pList=workService.tableParentList(projectNo);
		System.out.println(pList);
		return pList; 
	}
	
	
	
	//수정
	@PutMapping(value=("/workList/table/update/workTitle"))
	public int updateWorkTitle(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.updateWorkTitle(data);
	}
	@PutMapping(value=("/workList/table/update/dueDate"))
	public int updateDueDate(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.updateDueDate(data);
	}
	@PutMapping(value=("/workList/table/update/workState"))
	public int updateWorkState(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.updateWorkState(data);
	}
	@PutMapping(value=("/workList/table/update/workPriority"))
	public int updateWorkPriority(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.updateWorkPriority(data);
	}
	@PutMapping(value=("/workList/table/update/workManager"))
	public int updateWorkManager(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.updateWorkManager(data);
	}
	@PutMapping(value=("/workList/table/update/parentNo"))
	public int updateParentNo(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.updateParentNo(data);
	}
	
	
	
	
	
	//내작업
	@GetMapping(value=("/workList/mywork/insert"))
	public int insertMywork(@RequestBody Map<String, Object> data) {
		return service.insertMywork(data);
	}
	
	
	//리스트
	@PostMapping(value=("/workList/list"))
	public List<Work> selectList(@RequestBody Map<String, Object> data) {
		return service.selectList(data);
	}
	
	
	
	
	
	//담장자별
	@PostMapping(value=("/workList/managerBy/mList"))
	public Map<Integer, Object> managerByMList(@RequestBody Map<String, Object> data) {
		Map<Integer, Object> map=new HashMap<>();
		map=service.managerByMList(data);
		return map;
	}
		
	
	
	//프로젝트별
	@PostMapping(value=("/workList/projectBy/pList"))
	public Map<Integer, Object> projectByPList(@RequestBody Map<String, Object> data) {
		Map<Integer, Object> map=new HashMap<>();
		map=service.projectByPList(data);
		return map;
	}
	
	
	
	
	//상태별
	@PostMapping(value=("/workList/stateBy"))
	public Work insertStateBy(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.insertStateBy(data);
	}
	
	
	
	
	
	
	
	//TODO
	@PostMapping(value=("/todo/tList"))
	public List<Todo> todoTList(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.todoTList(data);
	}
	@PutMapping(value=("/todoList/update/todoState"))
	public int updateTodoState(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.updateTodoState(data);
	}
	@PostMapping(value=("/todo"))
	public Todo insertTodo(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.insertTodo(data);
	}
	
	
	
	
	@DeleteMapping(value=("/todo/detail"))
	public int deleteTodo(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.deleteTodo(data);
	}
	@PutMapping(value=("/todo/update/todoTitle"))
	public int updateTodoTitle(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.updateTodoTitle(data);
	}
	
	
}




