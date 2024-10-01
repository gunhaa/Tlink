package com.tlink.project.notice.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tlink.project.user.model.dto.User;
import com.tlink.project.notice.model.dto.Notice;
import com.tlink.project.notice.model.service.NoticeService;
import com.tlink.project.notice.model.service.NoticeService2;

@Controller
@RequestMapping("/notice2")
@SessionAttributes({"loginUser"})
public class NoticeController2 {

	@Autowired
	private NoticeService2 service;
	
	@Autowired // 게시글 수정 시 상세조회 서비스 호출용
	private NoticeService noticeService;
	
	// 게시글 작성 화면 전환
	@GetMapping("/insert")
	public String boardInsert(){
		
		return "notice/noticeWrite";
	}
	
	// 게시글 작성
	@PostMapping("/insert")
	public String boardInsert(
						     Notice notice // 커맨드 객체 (필드에 파라미터 담겨있음)
						    , @RequestParam(value="images", required=false) List<MultipartFile> files
						    , HttpSession session
						    , @SessionAttribute("loginUser") User loginUser
						    , RedirectAttributes ra
						    ) throws IllegalStateException, IOException {
		
		notice.setUserNo(loginUser.getUserNo());
		
		if(notice.getNoticeStatus() != 3) {
			notice.setNoticeStatus(1);
		}
		
		if(notice.getNoticeCommentView() != 1) {
			notice.setNoticeCommentView(2);
		}
		
		if(notice.getNoticeCopy() != 1) {
			notice.setNoticeCopy(2);
		}
		
		
		// 3. 업로드 된 이미지 서버에 실제로 저장되는 경로
		// 	  + 웹에서 요청 시 이미지를 볼 수 있는 경로(웹 접근 경로)
		String webPath = "/resources/images/notice/";
		String filePath = session.getServletContext().getRealPath(webPath);
		
		// 게시글 삽입 서비스 호출 후 삽입된 게시글 번호 반환 받기
		int noticeNo = service.noticeInsert(notice, files, webPath, filePath);

		
		String message = null;
		String path = "redirect:";
		
		if(noticeNo > 0) { // 게시글 등록 성공 시
			path += "/notice/" + noticeNo;
			
		}else { // 게시글 등록 실패 시
			message = "게시글이 등록 실패";
			path += "insert";
		}
		ra.addFlashAttribute("message", message);
		
		return path;
	}
	
	
	
	// 게시글 수정 화면 전환
	@GetMapping("/{noticeNo}/update")
	public String boardUpdate(@PathVariable("noticeNo") int noticeNo,
							  Model model  
							  ) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeNo", noticeNo);

		// 게시글 상세 조회 서비스 호출
		Notice notice = noticeService.selectNotice(map);
		
		model.addAttribute("notice", notice);

		// forward(요청 위임) -> request scope 유지
		return "notice/noticeUpdate";
	}
	
	// 게시글 수정 
	@PostMapping("/{noticeNo}/update")
	public String boardUpdate(Notice notice, // 커맨드 객체
							  @RequestParam(value="deleteList", required=false) String deleteList, // 삭제할 이미지
							  @RequestParam(value="cp", required=false, defaultValue="1") int cp, // 쿼리스트링 유지
							  @RequestParam(value="images", required=false) List<MultipartFile> files, // 업로드 된 이미지
							  @PathVariable("noticeNo") int noticeNo,
							  HttpSession session, // 서버 파일 저장 경로 얻어올 용도
							  RedirectAttributes ra // 리다이렉트 시 값 전달용
							  ) throws IllegalStateException, IOException {
		
		// 1) boardCode, boardNo를 커맨드 객체(Board)에 세팅
		notice.setNoticeNo(noticeNo);
		
		if(notice.getNoticeStatus() != 3) {
			notice.setNoticeStatus(1);
		}
		
		if(notice.getNoticeCommentView() != 1) {
			notice.setNoticeCommentView(2);
		}
		
		if(notice.getNoticeCopy() != 1) {
			notice.setNoticeCopy(2);
		}
		
		System.out.println(notice);
		// 2) 이미지 서버 저장 경로, 웹 접근 경로
		String webPath = "/resources/images/notice/";
		String filePath = session.getServletContext().getRealPath(webPath);
		
		// 3) 게시글 수정 서비스 호출
		int result = service.noticeUpdate(notice, files, webPath, filePath, deleteList);
		System.out.println(result);
		String path = "redirect:";
		
		if(result > 0) {
			path += "/notice/" + noticeNo;
		
		}else {
			path += "update";
		}
		
		return path;
	}
	
	
	// 게시글 삭제
	@GetMapping("/{noticeNo}/delete")
	public String noticeDelete(@PathVariable("noticeNo") int noticeNo,
							@RequestParam(value = "cp", required = false, defaultValue = "1") int cp
							) {
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeNo", noticeNo);
		int result = service.noticeDelete(map);
		
		String path = "redirect:";
		
		if(result > 0) {
			path += "/notice/";
		}else {
			path += "/notice/" + noticeNo + "?cp=" + cp;
		}
		
		
		return path;
	}
	
	// 게시글 복구하기
	@GetMapping("/{noticeNo}/restore")
	public String noticeRestore(@PathVariable("noticeNo") int noticeNo,
							@RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
							RedirectAttributes ra
							) {
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeNo", noticeNo);
		int result = service.noticeRestore(map);
		
		String path = "redirect:";
		String message = null;
		if(result > 0) {
			path += "/notice/deletedList";
			message = "게시글이 복구되었습니다";
		}else {
			path += "/notice/deletedList" + noticeNo + "?cp=" + cp;
			message = "게시글이 복구에 실패했습니다.";
		}
		
		ra.addFlashAttribute("message", message);
		return path;
	}
	
	
	
	
}
