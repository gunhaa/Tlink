package com.tlink.project.project.model.dto;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Project {
	
    private int projectNo;          // 프로젝트 고유 번호
    private String projectTitle;     // 프로젝트 제목
    private String projectInfo;      // 프로젝트 정보
    private Date createDate;         // 생성 날짜
    private int manager;            // 관리자 ID
    private int userCount;        // 멤버 수

}
