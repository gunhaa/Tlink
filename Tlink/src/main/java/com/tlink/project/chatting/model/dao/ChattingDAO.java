package com.tlink.project.chatting.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.chatting.controller.VideoController;
import com.tlink.project.chatting.model.dto.Chat;
import com.tlink.project.chatting.model.dto.MyObjectType;
import com.tlink.project.chatting.model.dto.videoConference;

@Repository
public class ChattingDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	private Logger logger = LoggerFactory.getLogger(ChattingDAO.class);
	
	public int makeRoom(String projectNo, String memberNo) {
		
		Map<String , String> inputMap = new HashMap<String, String>();
		
		inputMap.put("projectNo", projectNo);
		inputMap.put("memberNo", memberNo);
		
		return sqlSession.insert("videoMapper.makeRoom", inputMap);
	}
	
	
	public int changeRoomName(videoConference data) {

		return sqlSession.update("videoMapper.changeRoomName", data);
	}


	public String selectTitle(videoConference data) {
		return sqlSession.selectOne("videoMapper.selectTitle", data);
	}


	public int changeStatusY(String projectNo, String memberNo) {

		Map<String , String> inputMap = new HashMap<String, String>();
		
		inputMap.put("projectNo", projectNo);
		inputMap.put("memberNo", memberNo);
		
		return sqlSession.update("videoMapper.changeStatusY", inputMap);
	}


	public int changeStatusN(String exitProjectNo, String exitMemberNo) {
		
		Map<String , String> inputMap = new HashMap<String, String>();
		
		inputMap.put("projectNo", exitProjectNo);
		inputMap.put("memberNo", exitMemberNo);
		
		return sqlSession.update("videoMapper.changeStatusN", inputMap);
	}


	public int chatSend(Map<String, Object> msg) {
		return sqlSession.insert("videoMapper.chatSend", msg);
	}


	public List<Chat> selectChat(videoConference data) {
		return sqlSession.selectList("videoMapper.selectChat", data);
	}


	public int insertBookedChat(Map<String, Object> msg) {
		return sqlSession.insert("videoMapper.insertBookedChat", msg);
	}


	public int updateBookedChatStatusY(String projectNo, String memberNo, int seq) {
		
		Map<String , Object> inputMap = new HashMap<String, Object>();
		
		inputMap.put("projectNo", projectNo);
		inputMap.put("memberNo", memberNo);
		inputMap.put("seq", seq);
		
		return sqlSession.update("videoMapper.updateBookedChatStatusY", inputMap);
	}

	public String whatIsMyName(MyObjectType data) {
		return sqlSession.selectOne("videoMapper.whatIsMyName",data);
	}


	public int selectNowBookedChatSeq() {
		return sqlSession.selectOne("videoMapper.selectNowBookedChatSeq");
	}
	
}
