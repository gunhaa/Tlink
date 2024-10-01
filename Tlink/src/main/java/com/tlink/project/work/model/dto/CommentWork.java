package com.tlink.project.work.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommentWork {
	
    private int    commentNo        ;
    private String commentCon;
    private String commentDate ;
    private int parentNo      ;
    	private String parentName      ;
    private int projectNo     ;
    	private String projectName     ;
	private int workNo      ;
	private int userNo      ;
		private String userName      ;
 
}
