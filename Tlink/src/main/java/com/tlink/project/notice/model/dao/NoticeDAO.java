package com.tlink.project.notice.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.notice.model.dto.Notice;
import com.tlink.project.notice.model.dto.NoticePagination;

@Repository
public class NoticeDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	
	/**일반 공지사항 게시글 갯수 조회하기
	 * @return
	 */
	public int getListCount() {
		return sqlSession.selectOne("noticeMapper.getListCount");
	}
	
	/**공지사항 조회하기
	 * @param pagination 
	 * @return
	 */
	public List<Notice> selectAll(NoticePagination pagination) {
		
		// 1) offset 계산
		int offset = (pagination.getCurrentPage() -1) * pagination.getLimit();
		
		// 2) RowBounds 객체 생성
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("noticeMapper.selectAll", null, rowBounds);
	}

	/**공지사항 상단 고정글 조회하기
	 * @return
	 */
	public List<Notice> selectTopNotice() {
		return sqlSession.selectList("noticeMapper.selectTopNotice");
	}

	
	/**공지사항 검색으로 게시글 수 조회하기
	 * @param paramMap 
	 * @return
	 */
	public int selectNoticeList(Map<String, Object> paramMap) {
		return sqlSession.selectOne("noticeMapper.getListCountForSearch", paramMap);
	}
	
	
	/**공지사항 검색으로 게시글 조회하기
	 * @param paramMap
	 * @param pagination
	 * @return
	 */
	public List<Notice> selectNoticeList(Map<String, Object> paramMap, NoticePagination pagination) {
		
		// 1) offset 계산
		int offset = (pagination.getCurrentPage() -1) * pagination.getLimit();
		
		// 2) RowBounds 객체 생성
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("noticeMapper.getListForSearch", paramMap, rowBounds);
		
	}

	/**공지사항 상세 조회
	 * @param map
	 * @return
	 */
	public Notice selectNotice(Map<String, Object> map) {
		return sqlSession.selectOne("noticeMapper.selectNotice", map);
	}

	/**조회수 증가
	 * @param noticeNo
	 * @return
	 */
	public int updateReadCount(int noticeNo) {
		return sqlSession.update("noticeMapper.updateBoardCount", noticeNo);
	}

	/**공지사항 최근 20개의 게시글 제목만 조회하기
	 * @return
	 */
	public List<Notice> selectNoticeTitleList() {
		return sqlSession.selectList("noticeMapper.selectNoticeTitleList");
	}

	/**삭제된 공지사항 갯수 조회하기
	 * @return
	 */
	public int getDeleteListCount() {
		return sqlSession.selectOne("noticeMapper.getDeleteListCount");
	}
	
	/**삭제된 공지사항 조회하기
	 * @param pagination
	 * @return
	 */
	public List<Notice> selectDeleteAll(NoticePagination pagination) {
		
		// 1) offset 계산
		int offset = (pagination.getCurrentPage() -1) * pagination.getLimit();
		
		// 2) RowBounds 객체 생성
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("noticeMapper.selectDeleteAll", null, rowBounds);
	}

	/**삭제된 공지사항 상세조회
	 * @param map
	 * @return
	 */
	public Notice selectNoticeDelete(Map<String, Object> map) {
		return sqlSession.selectOne("noticeMapper.selectNoticeDelete", map);
	}

	/**삭제된 공지사항 검색으로 게시글 수 조회하기
	 * @param paramMap
	 * @return
	 */
	public int selectDeleteNoticeList(Map<String, Object> paramMap) {
		return sqlSession.selectOne("noticeMapper.getDeleteListCountForSearch", paramMap);
	}

	/**삭제된 공지사항 검색으로 게시글 조회하기
	 * @param paramMap
	 * @param pagination
	 * @return
	 */
	public List<Notice> selectDeleteNoticeList(Map<String, Object> paramMap, NoticePagination pagination) {
		// 1) offset 계산
		int offset = (pagination.getCurrentPage() -1) * pagination.getLimit();
		
		// 2) RowBounds 객체 생성
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("noticeMapper.getDeleteListForSearch", paramMap, rowBounds);
	}

	/**조회순으로 공지사항 조회하기
	 * @param paramMap 
	 * @param pagination
	 * @return
	 */
	public List<Notice> noticeArrayRead(Map<String, Object> paramMap, NoticePagination pagination) {
		
		// 1) offset 계산
		int offset = (pagination.getCurrentPage() -1) * pagination.getLimit();
		
		// 2) RowBounds 객체 생성
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("noticeMapper.noticeArrayRead", paramMap, rowBounds);
	}

	/**댓글순으로 공지사항 조회하기
	 * @param paramMap 
	 * @param pagination
	 * @return
	 */
	public List<Notice> noticeArrayComment(Map<String, Object> paramMap, NoticePagination pagination) {
		// 1) offset 계산
		int offset = (pagination.getCurrentPage() -1) * pagination.getLimit();
		
		// 2) RowBounds 객체 생성
		RowBounds rowBounds = new RowBounds(offset, pagination.getLimit());
		return sqlSession.selectList("noticeMapper.noticeArrayComment", paramMap, rowBounds);
	}


	

	
	
	
}
