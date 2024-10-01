package com.tlink.project.thread.model.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.tlink.project.common.utility.Util;
import com.tlink.project.thread.model.dao.ThreadDAO;
import com.tlink.project.thread.model.dto.Crong;
import com.tlink.project.thread.model.dto.ThreadChat;
import com.tlink.project.thread.model.dto.ThreadFile;
import com.tlink.project.thread.model.dto.ThreadInfo;
import com.tlink.project.thread.model.exception.FileUploadException;
import com.tlink.project.user.model.dto.User;

@Service
public class ThreadServiceImpl implements ThreadService {

   @Autowired
   private ThreadDAO dao;

   @Transactional(rollbackFor = Exception.class)
   @Override
   public int insertChat(ThreadChat threadChat, List<MultipartFile> files, String webPath, String filePath) throws IllegalStateException, IOException {
      int chatNo = dao.insertChat(threadChat);
      
      if(files!=null) {
    	  
          if( chatNo > 0 ) {
              List<ThreadFile> uploadList = new ArrayList<>();
              
              for( int i = 0; i < files.size(); i++ ) {
                 ThreadFile file = new ThreadFile();
                 
                 file.setChatNo(chatNo);
                 file.setFilePath(filePath);
                 file.setFileOriginName(files.get(i).getOriginalFilename());
                 file.setFileRename(Util.fileRename(files.get(i).getOriginalFilename()));
                 file.setFileOrder(i);
                 file.setFileCode(2);
                 file.setTargetNumber(chatNo);
                 
                 uploadList.add(file);                 
              }
                            
              if( !uploadList.isEmpty() ) {
                 int result = dao.insertChatFile(uploadList);
                 
                 if( result == uploadList.size() ) {
                    for( int i = 0; i < uploadList.size(); i++ ) {
                       String rename = uploadList.get(i).getFileRename();
                       
                       files.get(i).transferTo(new File(filePath + rename));
                    }
                 } else {
                    throw new FileUploadException();
                 }
              }
           }
      }
      
      

      return chatNo;
   }

	@Override
	public int insertThread(ThreadInfo threadInfo) {
		// create thread
		int threadNo = dao.insertThread(threadInfo);
		
		if( threadNo > 0 ) threadNo = threadInfo.getThreadNo();
		// create project thread
		
		Map<String, Object> projectMap = new HashMap<>();
			
		projectMap.put("projectNo", threadInfo.getProjectNo());
		projectMap.put("threadNo", threadNo);
		
		int result = dao.insertProjectThread(projectMap);
		
		// create user thread with userList
		for( int i = 0; i < threadInfo.getUserList().size(); i++ ) {
			Map<String, Object>  map = new HashMap<>();
			
			map.put("userNo", threadInfo.getUserList().get(i));
			map.put("threadNo", threadNo);
			
			result = dao.insertThreadMember(map);
		}
		
		return result;
	}

	@Override
	public List<Map<String, Object>> selectUser(int projectNo, int userNo, String query) {
		Map<String, Object> map = new HashMap<>();
		
		map.put("projectNo", projectNo);
		map.put("userNo", userNo);
		map.put("query", query);
		
		return dao.selectUser(map);
	}

	@Override
	public List<ThreadInfo> selectThread(int projectNo, int userNo) {
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("projectNo", projectNo);
		map.put("userNo", userNo);
		
		return dao.selectThread(map);
	}

	@Override
	public List<ThreadChat> selectChat(int threadNo) {
		return dao.selectThreadChat(threadNo);
	}

	@Override
	public List<Crong> selectThreadLoppy(String threadNo) {
		return dao.selectThreadLoppy(threadNo);
	}

	@Override
	public ThreadInfo selectThreadInfo(int threadNo) {
		return dao.selectThreadInfo(threadNo);
	}

   

}
