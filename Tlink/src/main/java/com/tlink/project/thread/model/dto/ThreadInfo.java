package com.tlink.project.thread.model.dto;

import java.util.List;

import com.tlink.project.user.model.dto.User;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ThreadInfo {
	private int threadNo;
	private String threadTitle;
	private int projectNo;
	private List<Integer> userList;
}
