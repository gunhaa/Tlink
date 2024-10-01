package com.tlink.project.thread.model.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Loppy {
	private String type;
	private String message;
	private List<String> fileNames;
	
	private String nickname;
	private String memberNo;
	private String profile;
	private String threadNo;
}
