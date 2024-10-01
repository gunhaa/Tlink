package com.tlink.project.notice.model.service;

import java.util.List;
import java.util.Map;

import com.tlink.project.notice.model.dto.Notice;

public interface NoticeService {

	/**공지사항 조회하기
	 * @param cp 
	 * @return
	 */
	Map<String, Object> selectAll(int cp);

	/**공지사항 상단 고정글 조회하기
	 * @return
	 */
	List<Notice> selectTopNotice();

	/**공지사항 검색으로 조회하기
	 * @param paramMap
	 * @param cp
	 * @return
	 */
	Map<String, Object> selectNoticeList(Map<String, Object> paramMap, int cp);

	
	/**공지사항 상세 조회
	 * @param map
	 * @return
	 */
	Notice selectNotice(Map<String, Object> map);

	/**공지사항 조회수 증가
	 * @param noticeNo
	 * @return
	 */
	int updateReadCount(int noticeNo);

	/**공지사항 최근 20개의 게시글 제목만 조회하기
	 * @return
	 */
	List<Notice> selectNoticeTitleList();

	/**삭제된 공지사항 조회하기
	 * @param cp
	 * @return
	 */
	Map<String, Object> selectDeleteAll(int cp);

	/**삭제된 공지사항 상세조회
	 * @param map
	 * @return
	 */
	Notice selectNoticeDelete(Map<String, Object> map);

	/**삭제된 공지사항 검색으로 조회하기
	 * @param paramMap
	 * @param cp
	 * @return
	 */
	Map<String, Object> selectDeleteNoticeList(Map<String, Object> paramMap, int cp);

	/**조회순으로 공지사항 정렬하기
	 * @param cp
	 * @param paramMap 
	 * @return
	 */
	Map<String, Object> noticeArrayRead(int cp, Map<String, Object> paramMap);

	/**댓글순으로 공지사항 정렬하기
	 * @param cp
	 * @param paramMap 
	 * @return
	 */
	Map<String, Object> noticeArrayComment(int cp, Map<String, Object> paramMap);

}
