package com.tlink.project.project.model.service;

import java.util.List;
import java.util.Map;

import com.tlink.project.project.model.dto.Project;
import com.tlink.project.user.model.dto.User;

public interface ProjectService {

	int create(Project project);

	List<Project> autocomplete(Map<String, Object> map);

	int deleteProject(int projectNo);

	Project selectProject(int projectNo);

	List<User> selectMemeberList(int projectNo);

	int deleteMember(Map<String, Object> map);

	int accept(int projectNo, String userEmail);

	int changeManager(Map<String, Object> map);
	

}
