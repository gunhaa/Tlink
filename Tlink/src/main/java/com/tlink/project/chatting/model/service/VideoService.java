package com.tlink.project.chatting.model.service;

import java.util.List;
import java.util.Map;

import com.tlink.project.chatting.model.dto.Chat;
import com.tlink.project.chatting.model.dto.MyObjectType;
import com.tlink.project.chatting.model.dto.videoConference;

public interface VideoService {

	int makeRoom(String projectNo, String memberNo);
	
	int changeRoomName(videoConference data);

	String selectTitle(videoConference data);

	int changeStatusY(String projectNo, String memberNo);

	int changeStatusN(String exitProjectNo, String exitMemberNo);

	int chatSend(Map<String, Object> msg);

	List<Chat> selectChat(videoConference data);

	int insertBookedChat(Map<String, Object> msg);

	int updateBookedChatStatusY(String projectNo, String memberNo, int seq);

	String whatIsMyName(MyObjectType data);

	int selectNowBookedChatSeq();
		
}
