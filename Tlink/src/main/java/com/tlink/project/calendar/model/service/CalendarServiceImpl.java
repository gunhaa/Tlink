package com.tlink.project.calendar.model.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.tlink.project.calendar.model.exception.FileUploadException;
import com.tlink.project.calendar.model.dao.CalendarDAO;
import com.tlink.project.calendar.model.dto.CalendarData;
import com.tlink.project.common.utility.Util;
import com.tlink.project.notice.model.dto.NoticeFiles;

@Service
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	private CalendarDAO dao;

	
	// 모든 일정 조회하기
	@Override
	public List<CalendarData> selectAll(int projectNo) {
		List<CalendarData> schedules = dao.selectAll(projectNo);
		
		return schedules;
	}

	// 일정 등록하기
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertEvent(CalendarData calendar) {
		
		calendar.setScheduleTitle(Util.XSShandling(calendar.getScheduleTitle() ));
		
		calendar.setScheduleContent(Util.XSShandling(calendar.getScheduleContent() ));
		calendar.setScheduleContent(Util.newLineHandling(calendar.getScheduleContent() ));
        
		return dao.insertEvent(calendar);
	}
	
	// 일정 수정하기
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateEvent(CalendarData calendar) {
		
		calendar.setScheduleTitle(Util.XSShandling(calendar.getScheduleTitle() ));
		
		calendar.setScheduleContent(Util.XSShandling(calendar.getScheduleContent() ));
		calendar.setScheduleContent(Util.newLineHandling(calendar.getScheduleContent() ));
		
		return dao.updateEvent(calendar);
	}

	// 휴가 등록하기
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int insertHoliday(CalendarData calendar, MultipartFile scheduleFile, String webPath, String filePath) throws IllegalStateException, IOException {
		calendar.setScheduleTitle(Util.XSShandling(calendar.getScheduleTitle() ));
		
		calendar.setScheduleContent(Util.XSShandling(calendar.getScheduleContent() ));
		calendar.setScheduleContent(Util.newLineHandling(calendar.getScheduleContent() ));
		
		int calendarNo = dao.insertEvent(calendar);
		
		// 휴가 먼저 등록하고 등록한 휴가 번호를 얻어와야 파일 테이블의 targetNo에 대입 가능
		
	    if (calendarNo > 0 && scheduleFile != null && !scheduleFile.isEmpty()) {
	        // 파일이 존재하는 경우에만 파일 데이터 설정 및 저장
	        NoticeFiles fileData = new NoticeFiles();
	        fileData.setFilePath(webPath);
	        fileData.setTargetNo(calendar.getScheduleNo());  // 일정 번호 설정
	        fileData.setFileOrder(0);  // 파일 순서 설정

	        // 파일 이름 설정
	        String fileName = scheduleFile.getOriginalFilename();
	        fileData.setFileOriginal(fileName);
	        fileData.setFileReName(Util.fileRename(fileName));

	        // 파일 정보 DB에 저장
	        int result = dao.insertScheduleFile(fileData);
	        if (result > 0) {
	            // 파일 실제 경로로 저장
	            String rename = fileData.getFileReName();
	            scheduleFile.transferTo(new File(filePath + rename));
	        }
	    }

		return calendarNo;
	}
	
	// 휴가 수정하기
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateHoliday(CalendarData calendar, String webPath, String filePath, String deleteList,
			MultipartFile scheduleFile) throws IllegalStateException, IOException {
		calendar.setScheduleTitle(Util.XSShandling(calendar.getScheduleTitle() ));
		
		calendar.setScheduleContent(Util.XSShandling(calendar.getScheduleContent() ));
		calendar.setScheduleContent(Util.newLineHandling(calendar.getScheduleContent() ));
		
		int calendarNo = dao.updateEvent(calendar);
		// 등록하기와 동일하게 휴가만 먼저 업데이트하여 일정 번호 얻어와 파일도 업데이트 수행
		
	    if (calendarNo > 0 && scheduleFile != null && !scheduleFile.isEmpty()) {
	        // 파일이 존재하는 경우에만 파일 데이터 설정 및 저장
	        NoticeFiles fileData = new NoticeFiles();
	        fileData.setFilePath(webPath);
	        fileData.setTargetNo(calendar.getScheduleNo());  // 일정 번호 설정
	        fileData.setFileOrder(0);  // 파일 순서 설정

	        // 파일 이름 설정
	        String fileName = scheduleFile.getOriginalFilename();
	        fileData.setFileOriginal(fileName);
	        fileData.setFileReName(Util.fileRename(fileName));

	        // 파일 정보 DB에 저장
	        int result = dao.updateScheduleFile(fileData);
	        if (result > 0) {
	            // 파일 실제 경로로 저장
	            String rename = fileData.getFileReName();
	            scheduleFile.transferTo(new File(filePath + rename));
	        }
	    }

		return calendarNo;
	}

	// 일정 삭제하기
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteEvent(int scheduleNo, int userNo) {
		return dao.deleteEvent(scheduleNo, userNo);
	}
	
	// 휴가 삭제하기
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int deleteHoliday(int scheduleNo, int userNo) {
		
		// 파일삭제하기
		int result1 = dao.deleteHolidayFile(scheduleNo);
		
		// 휴가 일정 삭제하기
		int result2 = dao.deleteEvent(scheduleNo, userNo);
		
		int result = 0;
		
		if(result>0) {
			result = 1;
		}
		
		return result;
	}
	
	// 비동기로 일정 수정하기
	@Transactional(rollbackFor = Exception.class)
	@Override
	public int updateEventDrop(CalendarData calendar) {
		
		
		calendar.setScheduleTitle(Util.XSShandling(calendar.getScheduleTitle() ));
		
		calendar.setScheduleContent(Util.XSShandling(calendar.getScheduleContent() ));
		calendar.setScheduleContent(Util.newLineHandling(calendar.getScheduleContent() ));
		
		return dao.updateEventDrop(calendar);
		
	}

	
	





}
