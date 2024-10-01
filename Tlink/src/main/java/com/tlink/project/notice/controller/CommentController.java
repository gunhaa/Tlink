package com.tlink.project.notice.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.tlink.project.notice.model.dto.NoticeComment;
import com.tlink.project.notice.model.service.CommentService;

@RestController
public class CommentController {

	@Autowired
	private CommentService service;
	
	// 댓글 목록 조회
	// ajax를 통해 수정 / 삭제 / 등록시 새 댓글 목록 조회해야하여
	@GetMapping(value="/comment", produces="application/json; charset=UTF-8")
	public List<NoticeComment> select(int noticeNo) {
		List<NoticeComment> a = service.selectCommentList(noticeNo);
		System.out.println(a);
		return a; 
	}
	

	// 댓글 삽입
	@PostMapping("/comment")
	private int insert(@RequestBody NoticeComment noticeComment) {
		// 요청 데이터(JSON)를
		// HttpMessageConverter가 해석해서 Java 객체(NoticeComment)에 대입
		return service.insert(noticeComment);
	}
	
	// 댓글 수정
	@PutMapping("/comment")
	private int update(@RequestBody NoticeComment noticeComment) {
		return service.update(noticeComment);
	}
	
	// 댓글 삭제
	@DeleteMapping("/comment")
	public int delete(@RequestBody int commentNo) {
		// ajax 요청 시 body에 담겨있는 하나 뿐인 데이터는
		// 매개변수 commentNo에 담기게 된다.
		return service.delete(commentNo);
	}
	
	// 댓글 고정
	@PutMapping("/comment/fix")
	private int updateFix(@RequestBody NoticeComment noticeComment) {
		return service.updateFix(noticeComment);
	}
	
	// 댓글 고정
	@PutMapping("/comment/disableFix")
	private int updateDisableFix(@RequestBody NoticeComment noticeComment) {
		return service.updateDisableFix(noticeComment);
	}
	
	
	
	
}
