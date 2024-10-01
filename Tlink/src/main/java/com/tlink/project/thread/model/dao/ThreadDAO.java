package com.tlink.project.thread.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.thread.model.dto.Crong;
import com.tlink.project.thread.model.dto.ThreadChat;
import com.tlink.project.thread.model.dto.ThreadFile;
import com.tlink.project.thread.model.dto.ThreadInfo;
import com.tlink.project.user.model.dto.User;

@Repository
public class ThreadDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int insertChat(ThreadChat threadChat) {
		int result = sqlSession.insert("threadMapper.insertChat", threadChat);
		
		if( result > 0 ) result = threadChat.getChatNo();
		
		return result;
	}

	public int insertChatFile(List<ThreadFile> uploadList) {		
		return sqlSession.insert("threadMapper.insertChatFile", uploadList);
	}

	public List<ThreadInfo> selectThread(Map<String, Object> map) {		
		return sqlSession.selectList("threadMapper.selectThread", map);
	}

	public int insertThread(ThreadInfo threadInfo) {
		return sqlSession.insert("threadMapper.insertThread", threadInfo);
	}

	public int insertProjectThread(Map<String, Object> projectMap) {
		return sqlSession.insert("threadMapper.insertProjectThread", projectMap);
	}

	public int insertThreadMember(Map<String, Object> map) {
		return sqlSession.insert("threadMapper.insertThreadMember", map);		
	}

	public List<Map<String, Object>> selectUser(Map<String, Object> map) {
		return sqlSession.selectList("threadMapper.selectUser", map);
	}

	public List<ThreadChat> selectThreadChat(int threadNo) {
		return sqlSession.selectList("threadMapper.selectThreadChat", threadNo);
	}

	public List<Crong> selectThreadLoppy(String threadNo) {
		return sqlSession.selectList("threadMapper.selectThreadLoppy", threadNo);
	}

	public ThreadInfo selectThreadInfo(int threadNo) {
		return sqlSession.selectOne("threadMapper.selectThreadInfo", threadNo);
	}
}
