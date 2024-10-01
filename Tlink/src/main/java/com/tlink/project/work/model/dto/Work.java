package com.tlink.project.work.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Work {
	
    private int workNo        ;
    private String workTitle  ;
    private String workContent;
    private String createDate ;
    private String updateDate ;
    private String dueDate    ;
    private int workState     ;
    private int workPriority  ;
    private int workManager   ;
    	private String workManagerName	;
    	private String profileImage	;
    private int parentNo      ;
    	private String parentName      ;
    private int projectNo     ;
    	private String projectName     ;
	private int level     ;
}
