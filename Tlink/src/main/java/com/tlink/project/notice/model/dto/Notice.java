package com.tlink.project.notice.model.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Notice {

	private int userNo;
	private String userName;
	
	private int noticeNo;
	private int noticeType;
	private int noticeStatus;
	private int noticeCommentView;
	private String noticeTitle;
	private String createDate;
	private String updateDate;
	private String noticeContent;
	private int noticeCopy;
	private int	readCount;

	// 서브쿼리
	private int commentCount; // 댓글 수
	private int likeCount;    // 좋아요 수

	// 회원 join
	private String profileImage;

	// 이미지 목록
	private List<NoticeFiles> fileList;

	// 댓글 목록
	private List<NoticeComment> commentList;

	
}
