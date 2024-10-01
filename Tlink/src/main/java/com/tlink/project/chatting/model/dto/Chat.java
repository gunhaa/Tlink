package com.tlink.project.chatting.model.dto;

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
public class Chat {
	private String chatNo;
	private String chatProjectNo;
	private String chatMemberNo;
	private String chatContent;
	private String chatTimestamp;
	private String chatUserName;
	private String chatProfileImg;
}
