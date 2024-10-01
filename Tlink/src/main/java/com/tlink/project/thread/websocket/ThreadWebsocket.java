package com.tlink.project.thread.websocket;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tlink.project.chatting.common.Util;
import com.tlink.project.thread.model.dto.Crong;
import com.tlink.project.thread.model.dto.Loppy;
import com.tlink.project.thread.model.dto.ThreadChat;
import com.tlink.project.thread.model.service.ThreadService;


public class ThreadWebsocket extends TextWebSocketHandler{
    
    private Logger logger = LoggerFactory.getLogger(ThreadWebsocket.class);
    
    private Map<WebSocketSession, String> sessions = new ConcurrentHashMap<WebSocketSession, String>();
    @Autowired
    private ThreadService service;

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {

    }
    
    
    //handlerTextMessage - 클라이언트로부터 텍스트 메세지를 받았을때 실행
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	
    	ObjectMapper objectMapper = new ObjectMapper(); 
    	
    	Loppy loppy = objectMapper.readValue(message.getPayload(), Loppy.class);
    	
    	if( loppy.getType().equals("bbororo") ) {
    		sessions.put(session, loppy.getMemberNo());
    	}
    	
    	if( loppy.getType().equals("crong")) {
    		
    		
    		Map<String, Object> msg = new HashMap<>();

			msg.put("type", "crong");
			msg.put("message", loppy.getMessage());
			msg.put("memberNo", loppy.getMemberNo());
			msg.put("nickname", loppy.getNickname());
			msg.put("profile", loppy.getProfile());
			msg.put("threadNo", loppy.getThreadNo());

	        LocalDateTime currentTime = LocalDateTime.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        String formattedTime = currentTime.format(formatter);
			msg.put("now", formattedTime);
			
			String jsonMsg = objectMapper.writeValueAsString(msg);
			
			List<Crong> memberList = service.selectThreadLoppy(loppy.getThreadNo());
			System.out.println("lulu");
			
			for( int i = 0; i < memberList.size(); i++ ) {				
				for( Map.Entry<WebSocketSession, String> entry : sessions.entrySet() ) {
					if( entry.getValue().equals(memberList.get(i).getMemberNo())){
						entry.getKey().sendMessage(new TextMessage(jsonMsg));
						break;
					}
				}
			}
			
			
			for( int i = 0; i < memberList.size(); i++ ) {
				
			}
    	}
    	
    }
    
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        //logger.info("{}연결끊김",session.getId());
    }
    
}

