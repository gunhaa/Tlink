package com.tlink.project.myPage.model.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.tlink.project.chatting.common.Util;
import com.tlink.project.myPage.model.dao.MyPageDAO;
import com.tlink.project.project.model.dto.Project;
import com.tlink.project.user.model.dto.User;

@Service
public class MyPageServiceImpl implements MyPageService{

	@Autowired
	private MyPageDAO dao;
	
	@Autowired // bean으로 등록된 객체 중 타입이 일치하는 Bean을 DI
	private BCryptPasswordEncoder bcrypt;
	
	// 비밀번호 변경
	@Override
	public int changePw(Map<String, String> map, int userNo) {
		
		String currentPw = dao.selectCurrentPw(userNo);
		
		int result = 0;
		
		if(bcrypt.matches(map.get("currentPw"), currentPw)) { // 같은 경우
			
			map.put("newPw", bcrypt.encode(map.get("newPw")));
			map.put("userNo", userNo+"");
			
			result = dao.changePw(map);
			
		}
		
		
		return result; 
	}

	@Override
	public int secession(String inputPw, int userNo) {
		String currentPw = dao.selectCurrentPw(userNo);
		
		int result = 0;
		
		if(bcrypt.matches(inputPw, currentPw)) { // 같은 경우
			
			
			result = dao.secession(userNo);
			
		}
		
		return result;
	}
	
	// 프로필 이미지 수정
	@Override
	public int updateProfile(MultipartFile profileImage, String webPath, String filePath, User loginUser) throws Exception{
		
		// 프로필 이미지 변경 실패 대비
		String prevImg = loginUser.getProfileImg(); // 이전 이미지 저장
		
		String rename = null; // 변경된 이름을 저장할 변수
		
		if(profileImage.getSize() > 0) { // 업로드된 이미지가 있을 경우
			// 1) 파일 이름 변경
			rename = Util.fileRename(profileImage.getOriginalFilename());
			
			// 2) 바뀐 이름을 loginMember에 세팅
			loginUser.setProfileImg(webPath + rename);
							// /resources/images/member/20240816141920_12345.jpg
			
			
		}else { // 없을 경우 (x버튼)
			loginUser.setProfileImg(null);
			// 세션 이미지를 null로 변경해서 삭제
			
		}
		
		int result = dao.updateProfile(loginUser);
		
		if(result > 0) { // 성공
			
			if(rename != null) {
				profileImage.transferTo(new File(filePath + rename));
			}
			
		}else { // 실패
			// 이전 이미지로 프로필 세팅
			loginUser.setProfileImg(prevImg);
		}
		System.out.println(result);
		return result;
	}

	@Override
	public int deleteProfile(int userNo) {
		
		return dao.deleteProfile(userNo);
	}

	@Override
	public int updateInfo(User loginUser) {
		return dao.updateinfo(loginUser);
	}

	// 관리자 목록 조회
	@Override
	public List<User> selectAdmin() {
		return dao.selectAdmin();
	}

	// 프로젝트 목록 조회
	@Override
	public List<Project> selectProjectList(int userNo) {
		return dao.selectProjectList(userNo);
	}

}
