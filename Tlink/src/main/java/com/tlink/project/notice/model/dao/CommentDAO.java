package com.tlink.project.notice.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.notice.model.dto.NoticeComment;

@Repository
public class CommentDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	/**댓글 조회하기
	 * @param noticeNo
	 * @return
	 */
	public List<NoticeComment> selectCommentList(int noticeNo) {
		return sqlSession.selectList("noticeMapper.selectCommentList", noticeNo);
	}

	/**댓글 등록하기
	 * @param noticeComment
	 * @return
	 */
	public int insert(NoticeComment noticeComment) {
		return sqlSession.insert("noticeCommentMapper.insert", noticeComment);
	}

	/**댓글 수정하기
	 * @param noticeComment
	 * @return
	 */
	public int update(NoticeComment noticeComment) {
		return sqlSession.update("noticeCommentMapper.update", noticeComment);
	}

	/**댓글 삭제하기
	 * @param commentNo
	 * @return
	 */
	public int delete(int commentNo) {
		return sqlSession.delete("noticeCommentMapper.delete", commentNo);
	}

	/**댓글 고정하기
	 * @param noticeComment
	 * @return
	 */
	public int updateFix(NoticeComment noticeComment) {
		return sqlSession.update("noticeCommentMapper.updateFix", noticeComment);
	}

	/**댓글 고정 해제하기
	 * @param noticeComment
	 * @return
	 */
	public int updateDisableFix(NoticeComment noticeComment) {
		return sqlSession.update("noticeCommentMapper.updateDisableFix", noticeComment);
	}


	
	
	
}
