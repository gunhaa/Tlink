package com.tlink.project.calendar.model.dto;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tlink.project.calendar.model.service.CalendarService;
import com.tlink.project.notice.model.dto.NoticeFiles;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CalendarData {

	private int userNo;
	private String userName;
	private int scheduleNo;
	private int projectNo;
	private String scheduleType;
	private String scheduleTitle;
	private String startDate;
	private String endDate;
	private String scheduleContent;
	
	private List<NoticeFiles> fileList;
	
}
