package com.tlink.project.calendar.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tlink.project.calendar.model.dto.CalendarData;
import com.tlink.project.calendar.model.service.CalendarService;
import com.tlink.project.user.model.dto.User;
import com.tlink.project.notice.model.dto.NoticeFiles;

@SessionAttributes("loginUser") // 멤버 정보 필요해서
@Controller
@RequestMapping("/calendar")
public class CalendarController {

    @Autowired
    private CalendarService service;
    
    //메인
    @RequestMapping("")
    public String calendar(Model model
    		, @SessionAttribute("loginUser") User loginUser 
    		, @RequestParam(value="projectNo") int projectNo
    		) {
    	
    	model.addAttribute("projectNo", projectNo);
    	
        List<CalendarData> schedules = service.selectAll(projectNo);
       
        System.out.println(schedules);

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("schedules", schedules);
        return "calendar/calendar"; // 캘린더 페이지를 렌더링하는 JSP
    }
    
    // 일정 등록하기
    @PostMapping("/eventForm")
    public String event(CalendarData calendar
    		, Model model
    		, @SessionAttribute("loginUser") User loginUser
    		, @RequestParam(value="projectNo") int projectNo
    		) {
    	calendar.setProjectNo(projectNo);
    	calendar.setUserNo(loginUser.getUserNo());
    	calendar.setUserName(loginUser.getUserName());
        calendar.setScheduleType("1");
        
        int result = service.insertEvent(calendar);
        if(result>0) {
        	System.out.println("일정 등록 성공");
        }
        
        model.addAttribute("projectNo", projectNo);
        
        return "redirect:/calendar"; // 변경된 리다이렉트 URL
    }

    // 휴가 등록하기
    @PostMapping("/holidayForm")
    public String holiday(CalendarData calendar
    		, @SessionAttribute("loginUser") User loginUser
    		, @RequestParam(value="scheduleFile", required=false) MultipartFile scheduleFile
    		, HttpSession session
    		, Model model
    		, @RequestParam(value="projectNo") int projectNo
    		) throws IllegalStateException, IOException {
    	
    	String webPath = "/resources/images/calendar/";
		String filePath = session.getServletContext().getRealPath(webPath);
    	
		calendar.setProjectNo(projectNo);
    	calendar.setUserNo(loginUser.getUserNo());
    	calendar.setUserName(loginUser.getUserName());
        
    	String holidayType = calendar.getScheduleType();
       
    	if ("2".equals(holidayType)) {
            calendar.setScheduleType("2");
        } else if ("3".equals(holidayType)) {
            calendar.setScheduleType("3");
        }
        
        try {
            // 휴가 종료일 다음날 오후 5시로 변경
        	// 예시) 휴가를 9월 2일 에서 9월 5일로 등록시 fullcalendar이 종료일을 포함하지 않아
        	//      갤린더에 9월 2일에서 9월 4일까지만 휴가로 등록됨
        	// 이에 종료일을 입력한 다음날 17시로 지정(시간은 내 마음대로 지정한 것)
            calendar.setEndDate(setTimeToEndOfDay(calendar.getEndDate(), 17, 0));
        } catch (ParseException e) {
            e.printStackTrace();
            // 에러 처리 로직 추가
        }
        
        int calendarNo = service.insertHoliday(calendar, scheduleFile, webPath, filePath);
        
        String message = null;

        if (calendarNo > 0) {
            System.out.println("휴가 등록 성공");
        }

        model.addAttribute("projectNo", projectNo);
        
        return "redirect:/calendar"; // 변경된 리다이렉트 URL
    }
    
    // 일정 업데이트
    @PostMapping("/eventUpdate")
    public String updateEvent(CalendarData calendar
    		, @SessionAttribute("loginUser") User loginUser
    		, @RequestParam(value="projectNo") int projectNo
    		, Model model
    		) {
    	
    	calendar.setProjectNo(projectNo);
    	calendar.setUserNo(loginUser.getUserNo());
    	calendar.setUserName(loginUser.getUserName());
    	
    	int result = service.updateEvent(calendar);
    	if (result > 0) {
            System.out.println("일정 수정 성공");
        }
    	
    	model.addAttribute("projectNo", projectNo);
    	
    	return "redirect:/calendar";
    }
    
    // 휴가 업데이트
    @PostMapping("/holidayUpdate")
    public String updateHoliday(CalendarData calendar
    		, @SessionAttribute("loginUser") User loginUser
    		, @RequestParam(value="scheduleFile", required=false) MultipartFile scheduleFile
    		, @RequestParam(value="deleteList", required=false) String deleteList
    		, @RequestParam(value="projectNo") int projectNo
    		, HttpSession session
    		, Model model
    		) throws IllegalStateException, IOException {
    	
    	String webPath = "/resources/images/calendar/";
		String filePath = session.getServletContext().getRealPath(webPath);
		
		calendar.setProjectNo(projectNo);
    	calendar.setUserNo(loginUser.getUserNo());
    	calendar.setUserName(loginUser.getUserName());
    	
    	String holidayType = calendar.getScheduleType();
    	
    	System.out.println("controller"+scheduleFile);
    	
        if ("2".equals(holidayType)) {
            calendar.setScheduleType("2");
        } else if ("3".equals(holidayType)) {
            calendar.setScheduleType("3");
        }
        
        try {
            calendar.setEndDate(setTimeToEndOfDay(calendar.getEndDate(), 17, 0));
        } catch (ParseException e) {
            e.printStackTrace();
        }
    	
    	int result = service.updateHoliday(calendar, webPath, filePath, deleteList, scheduleFile);
    	if (result > 0) {
            System.out.println("휴가 수정 성공");
        }
    	
    	model.addAttribute("projectNo", projectNo);
    	
    	return "redirect:/calendar";
    }
    
    // 일정 삭제하기
    @PostMapping("/deleteEvent")
    public String deleteEvent(int scheduleNo
    		, @SessionAttribute("loginUser") User loginUser
    		, Model model
    		, @RequestParam(value="projectNo") int projectNo
    		) {
    	
    	System.out.println("일정 삭제" + scheduleNo);
    	int userNo = loginUser.getUserNo();
    	
    	int result = service.deleteEvent(scheduleNo, userNo);
    	if (result > 0) {
            System.out.println("일정 삭제 성공");
        }
    	
    	model.addAttribute("projectNo", projectNo);
    	
    	return "redirect:/calendar";
    }
    
    // 휴가 삭제하기
    @PostMapping("/deleteHoliday")
    public String deleteHoliday(int scheduleNo
    		, @SessionAttribute("loginUser") User loginUser
    		, Model model
    		, @RequestParam(value="projectNo") int projectNo
    		) {
    	
    	System.out.println("휴가 삭제 : "+ scheduleNo);
    	int userNo = loginUser.getUserNo();
    	
    	int result = service.deleteHoliday(scheduleNo,userNo);
    	if (result > 0) {
            System.out.println("휴가 삭제 성공");
        }
    	
    	model.addAttribute("projectNo", projectNo);
    	
    	return "redirect:/calendar";
    }
    
    // 날자 형식 / 종료일 변경하기
    private String setTimeToEndOfDay(String dateStr, int hour, int minute) throws ParseException {
    	
        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = inputFormat.parse(dateStr); // String -> Date 변환

        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.set(Calendar.HOUR_OF_DAY, hour);
        cal.set(Calendar.MINUTE, minute);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);

        // 종료일 다음 날로 설정 (FullCalendar가 날짜를 포함하기 위해)
        cal.add(Calendar.DATE, 1); // 하루 추가

        // 데이터베이스가 인식할 수 있도록 'T'를 제거한 형식으로 변경
        SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        return outputFormat.format(cal.getTime()); // Date -> String 변환
    }
    
    
    // 비동기, 드래그 이벤트오 일정 수정하기
    @PutMapping(value = "/eventUpdate", produces = "application/json; charset=UTF-8")
    @ResponseBody // JSON 응답을 위해 추가
    public ResponseEntity<String> updateEventDrop(
            @RequestBody CalendarData calendar,
            @SessionAttribute("loginUser") User loginUser,
            @RequestParam(value = "projectNo") int projectNo,
            Model model) {
        
        calendar.setProjectNo(projectNo);
        calendar.setUserNo(loginUser.getUserNo());
        calendar.setUserName(loginUser.getUserName());

        System.out.println("Received Calendar Data: " + calendar);
        int result = service.updateEventDrop(calendar);
        
        if (result > 0) {
            System.out.println("일정 수정 성공");
            return ResponseEntity.ok("일정 수정 성공");
        } else {
            System.out.println("일정 수정 실패");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("일정 수정 실패");
        }
    }
    
    
}

