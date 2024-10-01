package com.tlink.project.work.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.tlink.project.work.model.service.WorkService;

@Controller
public class WorkController {
	@Autowired private WorkService service;
	
	@GetMapping("/test")
	public String test() {
		service.test();
		return "redirect:/workList";
	}
}
