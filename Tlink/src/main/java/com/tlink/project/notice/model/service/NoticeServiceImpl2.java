package com.tlink.project.notice.model.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.tlink.project.calendar.model.exception.FileUploadException;
import com.tlink.project.common.utility.Util;
import com.tlink.project.notice.model.dao.NoticeDAO2;
import com.tlink.project.notice.model.dto.Notice;
import com.tlink.project.notice.model.dto.NoticeFiles;

@Service
public class NoticeServiceImpl2 implements NoticeService2{

	@Autowired
	private NoticeDAO2 dao;

	// 공지사항 등록하기
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int noticeInsert(Notice notice, List<MultipartFile> files, String webPath, String filePath) throws IllegalStateException, IOException {

		// 0. XSS 방지 처리
		notice.setNoticeTitle(Util.XSShandling(notice.getNoticeTitle()));
		notice.setNoticeContent(Util.XSShandling(notice.getNoticeContent()));
		notice.setNoticeContent(Util.newLineHandling(notice.getNoticeContent()));

		// 1. Board 테이블 INSERT(제목, 내용, 작성자, 게시판 코드)
		// -> boardNo(시퀀스로 생성한 번호) 반환 받기
		int noticeNo = dao.noticeInsert(notice);

		// 2. 게시글 삽입이 성공 시
		// 	  업로드 된 이미지가 있다면 BOARD_IMG 테이블에 삽입하는 DAO 호출
		if(noticeNo > 0) { // 게시글 삽입 성공


			// 실제 업로드 된 파일의 정보를 기록할 List
			List<NoticeFiles> uploadList = new ArrayList<NoticeFiles>();

			for(int i=0; i<files.size(); i++) {

				// i번째 요소에 업로드 한 파일이 있다면
				if(files.get(i).getSize() > 0) {

					NoticeFiles file = new NoticeFiles();

					// img에 파일 정보를 담아서 uploadList에 추가
					file.setFilePath(webPath); 	// 웹 접근 경로
					file.setTargetNo(noticeNo); 	// 게시글 번호
					file.setFileOrder(i); 		// 이미지 순서

					// 파일 원본명
					String fileName = files.get(i).getOriginalFilename();
					file.setFileOriginal(fileName); 
					file.setFileReName(Util.fileRename(fileName)); // 변경명

					uploadList.add(file); 
				}
			} // 분류 for문 끝

			System.out.println(uploadList);
			// 분류 작업 후 uploadList가 비어있지 않은 경우
			// == 업로드한 파일이 있다. (업로드 유무에 따라 크기가 결정됨 ex) 사진 2개 업로드 -> 사이즈 2)
			if(!uploadList.isEmpty()) {

				// BOARD_IMG 테이블에 INSERT하는 DAO 호출
				int result = dao.insertFileList(uploadList);
				// result == 삽입된 행의 개수 == uploadList.size()

				// 삽입된 행의 개수(result)와 uploadList의 개수가 같다면
				// == 전체 insert 성공
				if(result == uploadList.size()) { 

					for(int i=0; i<uploadList.size(); i++) {

						// 변경된 파일명 
						String rename = uploadList.get(i).getFileReName();

						int index = uploadList.get(i).getFileOrder();

						files.get(index).transferTo(new File(filePath + rename));
					}

				}else { // 일부 또는 전체 insert 실패

					throw new FileUploadException(); // 예외 강제 발생

				}
			}

		}

		return noticeNo;

	}

	// 공지사항 수정하기
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int noticeUpdate(Notice notice, List<MultipartFile> files, String webPath, String filePath,
			String deleteList) throws IllegalStateException, IOException {

		// 1. 게시글 제목/내용만 수정
		// 1) XSS 방지 처리
		notice.setNoticeTitle(Util.XSShandling(notice.getNoticeTitle()));
		notice.setNoticeContent(Util.XSShandling(notice.getNoticeContent()));
		notice.setNoticeContent(Util.newLineHandling(notice.getNoticeContent()));

		// 2) DAO 호출
		int result = dao.noticeUpdate(notice);

		// 2. 게시글 부분이 수정 성공했을 때
		if (result > 0) {
			// 문자열이라서 
			if (!deleteList.equals("")) { // 삭제할 이미지가 있다면

				// 3. deleteList에 작성된 이미지 모두 삭제
				Map<String, Object> deleteMap = new HashMap<>();
				deleteMap.put("targetNo", notice.getNoticeNo()); // boardNo 파라미터 안 얻어와서 board에서 가져옴
				deleteMap.put("deleteList", deleteList);
				
				result = dao.fileDelete(deleteMap);
				if (result == 0) { // 이미지 삭제 실패 시 전체 롤백
					// -> 예외 강제로 발생
					throw new FileUploadException();
				}

			}
			// 4. 새로 업로드된 이미지 분류 작업

			// images : 실제 파일이 담긴 List
			// -> input type="file" 개수만큼 요소가 존재
			// -> 제출된 파일이 없어도 MultiPartFile 객체가 존재

			List<NoticeFiles> uploadList = new ArrayList<>();

			// images에 담겨 있는 파일 중 실제 업로드된 파일만 분류
			for (int i = 0; i < files.size(); i++) {

				// i번째 요소에 업로드한 파일이 있다면
				if (files.get(i).getSize() > 0) {

					NoticeFiles file = new NoticeFiles();

					// img에 파일 정보를 담아서 uploadList에 추가
					file.setFilePath(webPath); 		   // 웹 접근 경로
					file.setTargetNo(notice.getNoticeNo()); // 게시글 번호
					file.setFileOrder(i); 			   // 이미지 순서

					// 파일 원본명
					String fileName = files.get(i).getOriginalFilename();

					file.setFileOriginal(fileName); // 원본명
					file.setFileReName(Util.fileRename(fileName)); // 파일 변경명

					uploadList.add(file);

					// 오라클은 다중 UPDATE를 지원하지 않기 때문에
					// 하나씩 UPDATE 수행

					result = dao.fileUpdate(file);
					if (result == 0) {
						// 수정 실패 == DB에 이미지가 없었다.
						// -> 이미지 삽입

						result = dao.fileInsert(file);
					}
				}
			}

			// 5. uploadList에 있는 이미지들만 서버에 저장
			if (!uploadList.isEmpty()) {

				for (int i = 0; i < uploadList.size(); i++) {

					int index = uploadList.get(i).getFileOrder();

					// 파일로 변환
					String rename = uploadList.get(i).getFileReName();

					files.get(index).transferTo(new File(filePath + rename));
				}

			} // for문 끝

		}
		return result;
	}
	
	// 공지사항 삭제하기
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int noticeDelete(Map<String, Object> map) {
		return dao.noticeDelete(map);
	}

	// 공지사항 복구하기
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int noticeRestore(Map<String, Object> map) {
		return dao.noticeRestore(map);
	}

}
