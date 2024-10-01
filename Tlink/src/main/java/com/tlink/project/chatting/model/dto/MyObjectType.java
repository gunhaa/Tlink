package com.tlink.project.chatting.model.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MyObjectType {

	private String type;
	private String memberNo;
	private String memberName;
	private String title;
	private String profileImg;
	private String projectNo;
	private String prompt;
	private String bookedMsg;
	private String bookedTime;
	private Map<String, Object> body;
	private String targetNo;
	private String makeAnswerMemberNo;
	private String setAnswerMemberNo;
	private String iceSender;
	private String chatContent;
	private String key;
	private String draw;
}
