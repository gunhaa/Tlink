package com.tlink.project.work.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.tlink.project.myPage.model.service.MyPageService;
import com.tlink.project.project.model.dto.Project;
import com.tlink.project.thread.model.dto.ThreadInfo;
import com.tlink.project.thread.model.service.ThreadService;
import com.tlink.project.user.model.dto.User;
import com.tlink.project.work.model.dto.Work;
import com.tlink.project.work.model.service.WorkService;

@Controller
public class WorkList {
	
	
	@Autowired private WorkService service;
	@Autowired private MyPageService myPageservice;
	@Autowired private ThreadService threadService;

	@GetMapping("/workList") public String workList( @RequestParam(value="projectNo") int projectNo, Model model
			, @SessionAttribute("loginUser") User loginUser
			, HttpSession session
			) { 
		
		model.addAttribute("projectNo", projectNo);
		
		List<Project> projectList =myPageservice.selectProjectList(loginUser.getUserNo());
		session.setAttribute("projectList", projectList);
		
		List<ThreadInfo> threadInfo = threadService.selectThread(projectNo, loginUser.getUserNo());
		session.setAttribute("threadInfo", threadInfo);
		
		
		
		
		
		
		
		return "redirect:/workList/gantChart"; 
	}
	

	

	@GetMapping("/workList/gantChart")     	    public String gantChart  (@RequestParam(value="projectNo") int projectNo, Model model)      { 
		model.addAttribute("projectNo", projectNo); 
		List<Work> wList=service.table(projectNo);
		List<User> mList=service.tableManagerList(projectNo);
		List<Work> pList=service.tableParentList(projectNo);
		
		model.addAttribute("wList", wList); 
		model.addAttribute("mList", mList); 
		model.addAttribute("pList", pList); 
		
		return "workList/z1GantChart"; 
	}
	
		@GetMapping("/workList/sankeyChart")    public String sankeyChart(@RequestParam(value="projectNo") int projectNo, Model model)    { 
			model.addAttribute("projectNo", projectNo); 
			List<Work> wList=service.table(projectNo);
			List<User> mList=service.tableManagerList(projectNo);
			List<Work> pList=service.tableParentList(projectNo);
			
			model.addAttribute("wList", wList); 
			model.addAttribute("mList", mList); 
			model.addAttribute("pList", pList); 
			return "workList/z1z2SankeyChart"; 
		}
		@GetMapping("/workList/treeChart")      public String treeChart  (@RequestParam(value="projectNo") int projectNo, Model model)      { 
			model.addAttribute("projectNo", projectNo); 
			List<Work> wList=service.table(projectNo);
			List<User> mList=service.tableManagerList(projectNo);
			List<Work> pList=service.tableParentList(projectNo);
			
			model.addAttribute("wList", wList); 
			model.addAttribute("mList", mList); 
			model.addAttribute("pList", pList);  
			return "workList/z1z3TreeChart";
		}
		
	@GetMapping("/workList/workChart")          public String workChart  (@RequestParam(value="projectNo") int projectNo, Model model)      { model.addAttribute("projectNo", projectNo); return "workList/z2WorkChart"; }
		@GetMapping("/workList/pieChart")       public String pieChart   (@RequestParam(value="projectNo") int projectNo, Model model)       { model.addAttribute("projectNo", projectNo); return "workList/z2z2PieChart"; }
		@GetMapping("/workList/lineChart")      public String lineChart  (@RequestParam(value="projectNo") int projectNo, Model model)      { model.addAttribute("projectNo", projectNo); return "workList/z2z3LineChart"; }
	
	@GetMapping("/workList/table")              
	public String table(@RequestParam(value="projectNo") int projectNo, Model model
			)          
	{ 
		model.addAttribute("projectNo", projectNo); 
		
		List<Work> wList=service.table(projectNo);
		List<User> mList=service.tableManagerList(projectNo);
		List<Work> pList=service.tableParentList(projectNo);
		
		model.addAttribute("wList", wList); 
		model.addAttribute("mList", mList); 
		model.addAttribute("pList", pList); 

		
		return "workList/z3Table"; 
	}
	
	
	@GetMapping("/workList/mywork")             public String mywork     (
			@RequestParam(value="projectNo") int projectNo
			, Model model
			,@SessionAttribute(value="loginUser", required=false) User loginUser
			)         { 
		
		int userNo=loginUser.getUserNo();
		model.addAttribute("projectNo", projectNo); 
		
		
		List<Work> wList=service.mywork(projectNo,userNo);
		List<User> mList=service.tableManagerList(projectNo);
		List<Work> pList=service.tableParentList(projectNo);
		
		
		model.addAttribute("wList", wList); 
		model.addAttribute("mList", mList); 
		model.addAttribute("pList", pList); 

		
		return "workList/z4Mywork"; 
	}
	@GetMapping("/workList/list")               public String list       (@RequestParam(value="projectNo") int projectNo, Model model)           { model.addAttribute("projectNo", projectNo); return "workList/z5List"; }
	@GetMapping("/workList/managerBy")          public String managerBy  (@RequestParam(value="projectNo") int projectNo, Model model)      { model.addAttribute("projectNo", projectNo);  return "workList/z6ManagerBy"; }
	@GetMapping("/workList/projectBy")          public String projectBy  (@RequestParam(value="projectNo") int projectNo, Model model)      { model.addAttribute("projectNo", projectNo);  return "workList/z7ProjectBy"; }
	@GetMapping("/workList/stateBy")            public String stateBy    (@RequestParam(value="projectNo") int projectNo, Model model)        { 
		model.addAttribute("projectNo", projectNo); 
		
		List<Work> wList=service.table(projectNo);
		List<User> mList=service.tableManagerList(projectNo);
		List<Work> pList=service.tableParentList(projectNo);
		
		model.addAttribute("wList", wList); 
		model.addAttribute("mList", mList); 
		model.addAttribute("pList", pList); 
		
		return "workList/z8StateBy"; 
	}
	
	@GetMapping("/workSheet") 
	public String workSheet  (
			@RequestParam(value="projectNo") int projectNo, 
			@RequestParam(value="workNo") 	 int workNo,
			Model model)      
	{ 	
		
		model.addAttribute("workNo", workNo);
		model.addAttribute("projectNo", projectNo);

		
		Work work=service.workSheet(workNo,projectNo);
		model.addAttribute("work", work);
		
		List<User> mList=service.tableManagerList(projectNo);
		List<Work> pList=service.tableParentList(projectNo);
		model.addAttribute("mList", mList); 
		model.addAttribute("pList", pList); 
		
		return "workList/z9WorkSheet"; 
	}
	
	
	
	
	@GetMapping("/todoList")          	        public String todoList   (@RequestParam(value="projectNo") int projectNo, Model model)       { model.addAttribute("projectNo", projectNo); return "workList/zz1TodoList"; }
	
}




