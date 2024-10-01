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
import com.tlink.project.work.model.dto.CommentWork;
import com.tlink.project.work.model.dto.Todo;
import com.tlink.project.work.model.dto.Work;
import com.tlink.project.work.model.service.WorkRestService;
import com.tlink.project.work.model.service.WorkService;

@Controller
@RestController
public class CommentWorkRest {
	
	@Autowired private WorkRestService service;
	@Autowired private WorkService workService;
	
	
	@PostMapping(value=("/commentWork"))
	public int commentInsert(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.commentInsert(data);
	}
	@DeleteMapping(value=("/commentWork"))
	public int commentDelete(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.commentDelete(data);
	}
	@PutMapping(value=("/commentWork"))
	public int commentUpdate(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.commentUpdate(data);
	}

	@PostMapping(value=("/commentWork/select"))
	public List<CommentWork> commentSelect(@RequestBody Map<String, Object> data) {
		System.out.println(data);
		return service.commentSelect(data);
	}
	
	
	
}




