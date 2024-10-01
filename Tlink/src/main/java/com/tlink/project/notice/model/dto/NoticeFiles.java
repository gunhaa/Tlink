package com.tlink.project.notice.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeFiles {
	
	private int fileNo;
	private String filePath;
	private String fileReName;
	private String fileOriginal;
	private int fileOrder;
	private int fileCode;
	private int targetNo;

}
