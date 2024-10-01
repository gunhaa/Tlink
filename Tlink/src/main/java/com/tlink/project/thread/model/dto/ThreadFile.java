package com.tlink.project.thread.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ThreadFile {

	private int chatNo;
	private int fileNo;
	private String filePath;
	private String fileRename;
	private String fileOriginName;
	private int fileOrder;
	private int fileCode;
	private int targetNumber;
}
