package com.tlink.project.notice.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.tlink.project.calendar.model.dto.CalendarData;
import com.tlink.project.user.model.dto.User;
import com.tlink.project.notice.model.dto.Notice;
import com.tlink.project.notice.model.service.NoticeService;

@SessionAttributes("loginUser") // 멤버 정보 필요해서
@Controller
@RequestMapping("/notice")
public class NoticeController  {

	@Autowired
	private NoticeService service;
	
	//메인
    @RequestMapping("")
    public String notice(Model model
    		, @SessionAttribute("loginUser") User loginUser 
    		,@RequestParam(value = "cp",required = false, defaultValue = "1") int cp
    		,@RequestParam Map<String, Object> paramMap
    		) {
    	
    	if(paramMap.get("query") == null) { // 검색어가 없을 때 (검색X)
 			
 			// 게시글 목록 조회 서비스 호출
    		Map<String, Object> map = service.selectAll(cp);
    		List<Notice> topNoticeList = service.selectTopNotice(); // 공지사항 상단 고정글 조회하기
 			
 			// 조회 결과를 request scope에 세팅 후 forward 
 			model.addAttribute("map", map);
 			model.addAttribute("topNoticeList", topNoticeList);
 			
 		} else { //  검색어가 있을 떄 (검색 O)
 			
 			Map<String, Object> map = service.selectNoticeList(paramMap, cp);
 			List<Notice> topNoticeList = service.selectTopNotice(); // 공지사항 상단 고정글 조회하기
 			model.addAttribute("map", map);
 			model.addAttribute("topNoticeList", topNoticeList);
 			
 		}
        
        return "notice/noticeMain"; 
    }
    
    
    // 공지사항 게시글 상세조회 
	@GetMapping("/{noticeNo}")
	public String noticeDetail(@PathVariable("noticeNo") int noticeNo
							 , Model model 
							 , RedirectAttributes ra 
							 , @SessionAttribute(value="loginUser", required=false) User loginUser
							 , HttpServletRequest req
							 , HttpServletResponse resp) throws ParseException {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeNo", noticeNo);

		// 공지사항 상세조회의 옆 게시글 제목 네비 입력 값 위해
		List<Notice> noticeTitleList = service.selectNoticeTitleList(); 
		System.out.println(noticeTitleList);
		
		// 게시글 상세 조회 서비스 호출
		Notice notice = service.selectNotice(map);

		String path = null;
		if(notice != null) { // 조회된 결과가 있을 경우
			
			// 쿠키를 이용한 조회수 증가 처리
			// 1. 로그인한 회원의 글이 아닌 경우
			if(loginUser.getUserNo() != notice.getUserNo()) {
				// 2. 쿠키 얻어오기
				Cookie c = null;

				// 요청에 담겨있는 모든 쿠키 얻어오기
				Cookie[] cookies = req.getCookies();
				
				if(cookies != null) { // 쿠키가 존재할 경우 -> for문 돌린다(모든 쿠키에서 얻어오기 때문에)
					// 쿠키 중 "readBoardNo"라는 쿠키를 찾아서 c에 대입
					for(Cookie cookie : cookies) {
						if(cookie.getName().equals("readNoticeNo")) { 
							c = cookie; // c에 cookie 대입
							break;
						}
					}
				}
				// 3. 기존 쿠키가 없거나(c == null) 쿠키는 존재하나 현재 게시글 번호가
				//    쿠키에 저장되지 않은 경우 -> 오늘 해당게시글을 본 적 없음
				int result = 0; // 공통된 result 선언
				if(c == null) {
					// 쿠키가 존재 X -> 쿠키 새로 생성해준다
					c = new Cookie("readNoticeNo", "|" + noticeNo + "|"); 
					// 조회수 증가하는 서비스 호출
					result = service.updateReadCount(noticeNo);
					
				}else{ // 현재 게시글 번호가 쿠키에 있는지 확인
					
					// Cookie.getValue() : 쿠키에 저장된 모든 값을 읽어옴 -> String으로 반환
				
					// String.indexOf("문자열")
					// : 찾는 문자열이 몇 번째 인덱스에 존재하는지 반환 단, 없으면 -1 반환
					
					// 쿠키의 현재 게시글 번호가 없다면
					if(c.getValue().indexOf("|" + noticeNo + "|") == -1) {
						
						// 기존 값에 게시글 번호 추가해서 다시 세팅
						c.setValue(c.getValue() + "|" + noticeNo + "|");
						
						// 조회수 증가하는 서비스 호출
						result = service.updateReadCount(noticeNo);
					}
				} // 4. 종료
				// 5. 조회수 증가 성공 시 쿠키가 적용되는 경로, 쿠키 수명(당일 23시 59분 59초) 지정
				
				if(result > 0) {
					// 조회된 board 조회수와 DB 조회수 동기화
					notice.setReadCount(notice.getReadCount() + 1);
					
					// 적용 경로 설정
					c.setPath("/"); // "/" 이하 경로 요청 시 쿠키 서버로 전달
					
					// 수명 지정
					Calendar cal = Calendar.getInstance(); // 싱글톤 패턴
					cal.add(cal.DATE, 1); // 하루 날짜 세팅
					
					// 날짜 표기법 변경 객체
					// TO_CHAR
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					
					Date now = new Date(); // 현재 시간
					
					Date temp = new Date(cal.getTimeInMillis()); // 내일 (24시간 후)
					// 2024-08-17 10:09:30
					
					Date tmr = sdf.parse(sdf.format(temp)); // 내일 0시 0분 0초
					
					// 내일 0시 0분 0초 - 현재 시간 
					long diff = (tmr.getTime() - now.getTime()) / 1000;
					// -> 내일 0시 0분 0초까지 남은 시간을 초 단위로 반환
					
					c.setMaxAge((int)diff); // 수명 설정
					// setMaxAge는 int 자료형만 가능해서 형변환 시켜줘야 함
					
					resp.addCookie(c); // 응답 객체를 이용해서 클라이언트에게 전달
					
				}
			}

			path = "notice/noticeDetail";
			model.addAttribute("notice", notice);
			model.addAttribute("noticeTitleList", noticeTitleList);
			System.out.println("notice"+notice);
		}else { // 조회된 결과가 없을 경우

			// 게시판 첫 페이지로 리다이렉트
			path = "redirect:/notice";

			// "해당 게시글이 존재하지 않습니다." 알림창 출력
			ra.addFlashAttribute("message", "해당 게시글이 존재하지 않습니다.");

		}

		return path;
	}
 
	
    @GetMapping("/deletedList")
    public String noticeDeleteList(Model model
    		, @SessionAttribute("loginUser") User loginUser 
    		,@RequestParam(value = "cp",required = false, defaultValue = "1") int cp
    		,@RequestParam Map<String, Object> paramMap
    		) {
    	
    	if(paramMap.get("query") == null) { // 검색어가 없을 때 (검색X)
 			
 			// 게시글 목록 조회 서비스 호출
    		Map<String, Object> map = service.selectDeleteAll(cp);
 			
 			// 조회 결과를 request scope에 세팅 후 forward 
 			model.addAttribute("map", map);
 			
 		} else { //  검색어가 있을 떄 (검색 O)
 			
 			Map<String, Object> map = service.selectDeleteNoticeList(paramMap, cp);
 			model.addAttribute("map", map);
 			
 		}
        
        return "notice/noticeDeleteList"; 
    }
	
    // 공지사항 게시글 상세조회 
	@GetMapping("/deletedList/{noticeNo}")
	public String noticeDeleteDetail(@PathVariable("noticeNo") int noticeNo
							 , Model model 
							 , RedirectAttributes ra 
							 , @SessionAttribute(value="loginUser", required=false) User loginUser
							 , HttpServletRequest req
							 , HttpServletResponse resp) throws ParseException {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("noticeNo", noticeNo);

		
		// 게시글 상세 조회 서비스 호출
		Notice noticeDelete = service.selectNoticeDelete(map);

		String path = null;
		if(noticeDelete != null) { // 조회된 결과가 있을 경우
			
			
			path = "notice/noticeDeleteDetail";
			model.addAttribute("noticeDelete", noticeDelete);

		}else { // 조회된 결과가 없을 경우

			// 게시판 첫 페이지로 리다이렉트
			path = "redirect:/notice/deletedList";

			// "해당 게시글이 존재하지 않습니다." 알림창 출력
			ra.addFlashAttribute("message", "해당 게시글이 존재하지 않습니다.");

		}

		return path;
	}
	
	
	// 공지사항 조회순으로 정렬하기
	@GetMapping(value = "/arrayRead", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> noticeArrayRead(
	        @SessionAttribute("loginUser") User loginUser,
	        @RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
	        @RequestParam(value = "sort", required = false) String sort,
	        @RequestParam(value = "query", required = false) String query, 
	        HttpSession session,
	        @RequestParam Map<String, Object> paramMap) {

	    // 세션에 정렬 상태 저장
	    if (sort != null) {
	        session.setAttribute("sortOrder", sort);
	    }

	    // 세션에서 정렬 상태 가져오기
	    String currentSortOrder = (String) session.getAttribute("sortOrder");

	    Map<String, Object> map = new HashMap<>();

	    // 검색어가 있는 경우 필터링 처리
	    if (query != null && !query.isEmpty()) {
	        paramMap.put("query", query);
	    }

	    if ("arrayRead".equals(currentSortOrder)) {
	        // 조회순 정렬 로직
	        map = service.noticeArrayRead(cp, paramMap);  // 검색어 전달
	    } else {
	        // 기본 정렬 로직
	        map = service.selectNoticeList(paramMap, cp);
	    }

	    // 상단 고정 공지사항 추가
	    List<Notice> topNoticeList = service.selectTopNotice();
	    map.put("topNoticeList", topNoticeList);

	    return map;
	}
	
	// 공지사항 조회순으로 정렬하기
	@GetMapping(value = "/arrayComment", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> noticeArrayComment(
	        @SessionAttribute("loginUser") User loginUser,
	        @RequestParam(value = "cp", required = false, defaultValue = "1") int cp,
	        @RequestParam(value = "sort", required = false) String sort,
	        @RequestParam(value = "query", required = false) String query, 
	        HttpSession session,
	        @RequestParam Map<String, Object> paramMap) {

	    // 세션에 정렬 상태 저장
	    if (sort != null) {
	        session.setAttribute("sortOrder", sort);
	    }

	    // 세션에서 정렬 상태 가져오기
	    String currentSortOrder = (String) session.getAttribute("sortOrder");

	    Map<String, Object> map = new HashMap<>();

	    // 검색어가 있는 경우 필터링 처리
	    if (query != null && !query.isEmpty()) {
	        paramMap.put("query", query);
	        System.out.println(query);
	    }

	    if ("arrayComment".equals(currentSortOrder)) {
	        // 댓글순 정렬 로직
	        map = service.noticeArrayComment(cp, paramMap); // 검색어 전달
	    } else {
	        // 기본 정렬 로직
	        map = service.selectNoticeList(paramMap, cp);
	    }
	    // 상단 고정 공지사항 추가
	    List<Notice> topNoticeList = service.selectTopNotice();
	    map.put("topNoticeList", topNoticeList);

	    return map;
	}



	
    
}
