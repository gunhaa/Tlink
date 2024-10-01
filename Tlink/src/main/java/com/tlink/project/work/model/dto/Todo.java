package com.tlink.project.work.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Todo {
	
    private int    todoNo          ;
    private String todoTitle       ;
    private String todoContent     ;
    private String createDate      ;
    private String updateDate      ;
    private int    todoState       ;
    private String todoManager     ;
    private int    parentNo        ;
    private int    projectNo       ;
 
}

