package com.tlink.project.chatting.controller;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.tlink.project.chatting.common.Util;
import com.tlink.project.chatting.model.dto.Chat;
import com.tlink.project.chatting.model.dto.MyObjectType;
import com.tlink.project.chatting.model.dto.videoConference;
import com.tlink.project.chatting.model.service.GeminiService;
import com.tlink.project.chatting.model.service.VideoService;
import com.tlink.project.chatting.websocket.VideoConference;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/video/*")
public class VideoController {
	
	@Autowired
	private VideoService service;

	@Autowired
    private GeminiService geminiService;
	
	@Autowired
	private Map<String, String> whiteBoardMap;
	
	@Autowired
	private Map<String, Map<String, WebSocketSession>> projectMap;
	private static final String MSG_TYPE_WHITEBOARD = "whiteBoard";
	
	private Logger logger = LoggerFactory.getLogger(VideoController.class);
	
	
	
	
	@RequestMapping("test")
	public String myPageProject() {
		return "/videoConference/videoConference";
	}
	
	
	@PostMapping(value="/changeRoomName", produces="application/json; charset=UTF-8")
	@ResponseBody
	public int changeRoomName(@RequestBody videoConference data) {
		
		return service.changeRoomName(data);
	}
	
	@PostMapping(value="/selectTitle", produces="application/json; charset=UTF-8")
	@ResponseBody
	public String selectTitle(@RequestBody videoConference data) {
		
		logger.info("projectNo : {}", data.getProjectNo());
		return service.selectTitle(data);
	}
	
	@PostMapping(value="/selectChat" , produces="application/json; charset=UTF-8")
	@ResponseBody
	public List<Chat> selectChat(@RequestBody videoConference data) {
		return service.selectChat(data);
	}
	
	@PostMapping(value="/whatIsMyName" , produces="application/json; charset=UTF-8")
	@ResponseBody
	public String whatIsMyName(@RequestBody MyObjectType data) {

		return service.whatIsMyName(data);
	}
	
	@PostMapping(value="/projectDrawStatus" , produces="application/json; charset=UTF-8")
	@ResponseBody
	public String projectDrawStatus(@RequestBody MyObjectType data) {
		logger.info("=====================fetch 실행됨==================");
	
//		return whiteBoardMap.get(data.getProjectNo());
	    String result = whiteBoardMap.get(data.getProjectNo());
	    return result;
	}
	
	@PostMapping(value="/erase" , produces="application/json; charset=UTF-8")
	@ResponseBody
	public String erase(@RequestBody MyObjectType data) {
		logger.info("=====================fetch 실행됨==================");
		whiteBoardMap.remove(data.getProjectNo());
		whiteBoardMap.put(data.getProjectNo(), "");
		logger.info("map의 현재 data.getprojectNo의 value : {}" , whiteBoardMap.get(data.getProjectNo()));
	
		Map<String, WebSocketSession> project = projectMap.get(data.getProjectNo());
		
		Map<String, Object> msg = new HashMap<>();
		ObjectMapper objectMapper = new ObjectMapper();
		msg.put("type", MSG_TYPE_WHITEBOARD);
		msg.put(data.getProjectNo(), "");
		
		String jsonMsg;
		
		try {
			jsonMsg = objectMapper.writeValueAsString(msg);
			Util.broadCasting(project, jsonMsg);
			
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		
		String result = whiteBoardMap.get(data.getProjectNo());
		
	    return result;

	}
	
	@PostMapping(value="/prompt" , produces="application/json; charset=UTF-8")
	@ResponseBody
	public ResponseEntity<?> prompt(@RequestBody MyObjectType data) {

        try {
            return ResponseEntity.ok().body(geminiService.useGemini(data.getPrompt()));
        } catch (HttpClientErrorException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
	}
	
	
	
	
}
