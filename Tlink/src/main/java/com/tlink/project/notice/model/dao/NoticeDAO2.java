package com.tlink.project.notice.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.notice.model.dto.Notice;
import com.tlink.project.notice.model.dto.NoticeFiles;

@Repository
public class NoticeDAO2 {

	@Autowired
	private SqlSessionTemplate sqlSession;

	/**게시글 삽입하기
	 * @param notice
	 * @return
	 */
	public int noticeInsert(Notice notice) {
		int result = sqlSession.insert("noticeMapper.noticeInsert", notice);
		System.out.println(result);
		if(result > 0)  result = notice.getNoticeNo();
		return result; // 삽입 성공 시 boardNo, 실패 시 0 반환 
	}

	/**파일 리스트 등록하기
	 * @param uploadList
	 * @return
	 */
	public int insertFileList(List<NoticeFiles> uploadList) {
		int result =  sqlSession.insert("noticeMapper.insertFileList", uploadList);
		System.out.println(result);
		return result;
	}

	/**공지사항 수정하기
	 * @param notice
	 * @return
	 */
	public int noticeUpdate(Notice notice) {
		return sqlSession.update("noticeMapper.noticeUpdate", notice);
	}

	/**공지사항 파일 삭제
	 * @param deleteMap
	 * @return
	 */
	public int fileDelete(Map<String, Object> deleteMap) {
		return sqlSession.delete("noticeMapper.fileDelete", deleteMap);
	}

	/**공지사항 파일 수정
	 * @param file
	 * @return
	 */
	public int fileUpdate(NoticeFiles file) {
		return sqlSession.update("noticeMapper.fileUpdate", file);
	}

	/**공지사항 파일 등록
	 * @param file
	 * @return
	 */
	public int fileInsert(NoticeFiles file) {
		return sqlSession.insert("noticeMapper.fileInsert", file);
	}

	/**공지사항 삭제하기
	 * @param map
	 * @return
	 */
	public int noticeDelete(Map<String, Object> map) {
		return sqlSession.update("noticeMapper.noticeDelete", map);
	}

	/**공지사항 복구하기
	 * @param map
	 * @return
	 */
	public int noticeRestore(Map<String, Object> map) {
		return sqlSession.update("noticeMapper.noticeRestore", map);
	}
}
