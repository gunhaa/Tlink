package com.tlink.project.thread.model.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.tlink.project.thread.model.dto.Crong;
import com.tlink.project.thread.model.dto.ThreadChat;
import com.tlink.project.thread.model.dto.ThreadInfo;
import com.tlink.project.user.model.dto.User;

public interface ThreadService {

	int insertChat(ThreadChat threadChat, List<MultipartFile> files, String webPath, String filePath) throws IllegalStateException, IOException;

	int insertThread(ThreadInfo threadInfo);

	List<Map<String, Object>> selectUser(int projectNo, int userNo, String query);

	List<ThreadInfo> selectThread(int projectNo, int userNo);

	List<ThreadChat> selectChat(int threadNo);
	
	List<Crong> selectThreadLoppy(String threadNo);

	ThreadInfo selectThreadInfo(int threadNo);
}
