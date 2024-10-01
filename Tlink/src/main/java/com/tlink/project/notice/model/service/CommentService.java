package com.tlink.project.notice.model.service;

import java.util.List;

import com.tlink.project.notice.model.dto.NoticeComment;

public interface CommentService {

	/**공지사항 게시글 댓글 조회
	 * @param noticeNo
	 * @return
	 */
	List<NoticeComment> selectCommentList(int noticeNo);

	/**공지사항 게시글 댓글 등록
	 * @param noticeComment
	 * @return
	 */
	int insert(NoticeComment noticeComment);

	/**공지사항 게시글 댓글 수정
	 * @param noticeComment
	 * @return
	 */
	int update(NoticeComment noticeComment);

	/** 공지사항 게시글 댓글 삭제
	 * @param commentNo
	 * @return
	 */
	int delete(int commentNo);

	/**댓글 고정
	 * @param noticeComment
	 * @return
	 */
	int updateFix(NoticeComment noticeComment);

	/**댓글 고정 해제
	 * @param noticeComment
	 * @return
	 */
	int updateDisableFix(NoticeComment noticeComment);

}
