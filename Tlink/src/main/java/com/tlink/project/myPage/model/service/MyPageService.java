package com.tlink.project.myPage.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.tlink.project.project.model.dto.Project;
import com.tlink.project.user.model.dto.User;

public interface MyPageService {

	int changePw(Map<String, String> map, int userNo);

	int secession(String inputPw, int userNo);

	int updateProfile(MultipartFile profileImage, String webPath, String filePath, User loginUser) throws Exception;

	int deleteProfile(int userNo);

	int updateInfo(User loginUser);

	List<User> selectAdmin();

	List<Project> selectProjectList(int userNo);

}
