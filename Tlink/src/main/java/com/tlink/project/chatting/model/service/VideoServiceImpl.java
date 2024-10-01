package com.tlink.project.chatting.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tlink.project.chatting.model.dao.ChattingDAO;
import com.tlink.project.chatting.model.dto.Chat;
import com.tlink.project.chatting.model.dto.MyObjectType;
import com.tlink.project.chatting.model.dto.videoConference;

@Service
public class VideoServiceImpl implements VideoService {

	@Autowired
	private ChattingDAO dao;
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int makeRoom(String projectNo, String memberNo) {
		return dao.makeRoom(projectNo, memberNo);
	}
	
	
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int changeRoomName(videoConference data) {
		return dao.changeRoomName(data);
	}


	@Override
	public String selectTitle(videoConference data) {
		return dao.selectTitle(data);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int changeStatusY(String projectNo, String memberNo) {
		return dao.changeStatusY(projectNo, memberNo);
	}

	@Transactional(rollbackFor = Exception.class)
	@Override
	public int changeStatusN(String exitProjectNo, String exitMemberNo) {
		return dao.changeStatusN(exitProjectNo, exitMemberNo);
	}


	@Override
	public int chatSend(Map<String, Object> msg) {
		return dao.chatSend(msg);
	}


	@Override
	public List<Chat> selectChat(videoConference data) {
		return dao.selectChat(data);
	}


	@Override
	public int insertBookedChat(Map<String, Object> msg) {
		return dao.insertBookedChat(msg);
	}


	@Override
	public int updateBookedChatStatusY(String projectNo, String memberNo, int seq) {
		return dao.updateBookedChatStatusY(projectNo, memberNo, seq);
	}


	@Override
	public String whatIsMyName(MyObjectType data) {
		return dao.whatIsMyName(data);
	}


	@Override
	public int selectNowBookedChatSeq() {
		return dao.selectNowBookedChatSeq();
	}




}
