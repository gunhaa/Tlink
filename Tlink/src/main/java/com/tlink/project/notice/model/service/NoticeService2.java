package com.tlink.project.notice.model.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.tlink.project.notice.model.dto.Notice;

public interface NoticeService2 {


	/**공지사항 등록하기
	 * @param notice
	 * @param images
	 * @param webPath
	 * @param filePath
	 * @return
	 */
	int noticeInsert(Notice notice, List<MultipartFile> files, String webPath, String filePath) throws IllegalStateException, IOException;

	/**공지사항 수정하기
	 * @param notice
	 * @param files
	 * @param webPath
	 * @param filePath
	 * @param deleteList
	 * @return
	 */
	int noticeUpdate(Notice notice, List<MultipartFile> files, String webPath, String filePath, String deleteList) throws IllegalStateException, IOException;

	/**공지사항 삭제하기
	 * @param map
	 * @return
	 */
	int noticeDelete(Map<String, Object> map);

	/**공지사항 복구하기
	 * @param map
	 * @return
	 */
	int noticeRestore(Map<String, Object> map);

}
