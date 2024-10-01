package com.tlink.project.notice.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tlink.project.common.utility.Util;
import com.tlink.project.notice.model.dao.CommentDAO;
import com.tlink.project.notice.model.dto.NoticeComment;

@Service
public class CommentServiceImpl implements CommentService {

	
	@Autowired
	private CommentDAO dao;

	// 공지사항 게시글 댓글 조회
	@Override
	public List<NoticeComment> selectCommentList(int noticeNo) {
		return dao.selectCommentList(noticeNo);
	}

	// 공지사항 게시글 댓글 등록
	@Override
	public int insert(NoticeComment noticeComment) {
		noticeComment.setCommentContent(Util.XSShandling(noticeComment.getCommentContent()));
		return dao.insert(noticeComment);
	}

	// 공지사항 게시글 댓글 수정
	@Override
	public int update(NoticeComment noticeComment) {
		noticeComment.setCommentContent(Util.XSShandling(noticeComment.getCommentContent()));
		return dao.update(noticeComment);
	}

	// 공지사항 게시글 댓글 삭제
	@Override
	public int delete(int commentNo) {
		return dao.delete(commentNo);
	}
	
	// 댓글 고정하기
	@Override
	public int updateFix(NoticeComment noticeComment) {
		return dao.updateFix(noticeComment);
	}

	// 댓글 고정 해제하기
	@Override
	public int updateDisableFix(NoticeComment noticeComment) {
		return dao.updateDisableFix(noticeComment);
	}
	
	
}
