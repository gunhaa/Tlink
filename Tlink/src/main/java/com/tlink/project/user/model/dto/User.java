package com.tlink.project.user.model.dto;

import java.sql.Date;
import java.util.List;

import com.tlink.project.project.model.dto.Project;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class User {

    private int    userNo;           // 사용자 번호
    private String userEmail;        // 이메일
    private String userPw;           // 비밀번호
    private String userName;         // 이름
    private String userPhone;        // 전화번호
    private String userAddr;         // 주소
    private String profileImg;       // 프로필 이미지
    private Date   enrollDate;       // 가입일
    private String userDeleteFlag;   // 탈퇴여부 
    private String role;             // 역할
    
	
}
