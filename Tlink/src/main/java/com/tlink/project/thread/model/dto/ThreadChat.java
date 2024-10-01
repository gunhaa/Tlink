package com.tlink.project.thread.model.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ThreadChat {
	private int chatNo;
	private int threadNo;
	private String chatMessage;
	private String chatType;
	private String chatCreateDate;
	private String chatUpdateDate;
	private int commentCount;

	private List<ThreadFile> fileList;
	private List<ThreadChatComment> commentList;
	
	private int memberNo;
	private String memberNickname;
	private String memberProfile;
}
