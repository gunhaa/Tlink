package com.tlink.project.chatting.common;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ScheduledFuture;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tlink.project.chatting.model.service.VideoService;
import com.tlink.project.chatting.websocket.VideoConference;

@Component
public class Schduling {

	private Logger logger = LoggerFactory.getLogger(VideoConference.class);
	
    private final TaskScheduler taskScheduler;

	private static final String MSG_TYPE_CHAT = "chat";
    
	@Autowired
	private VideoService service;
    
    
    public Schduling(TaskScheduler taskScheduler) {
        this.taskScheduler = taskScheduler;
    }

    public ScheduledFuture<?> scheduleMessage(Map<String, Object> msg, LocalDateTime scheduledTime, Map<String, WebSocketSession> projectMemberMap, String projectNo, String memberNo, String chatContent) {
        
    	
    	long delay = Duration.between(LocalDateTime.now(), scheduledTime).toMillis();

        logger.info("예약 메시지 전송 딜레이 : {} ", delay);
        
        return taskScheduler.schedule(() -> {
            // 메시지 전송 로직

        	int seq = service.selectNowBookedChatSeq();
        	logger.info("seq : {}" , seq);
        	
//			Map<String, Object> boradCasting = new HashMap<>();

//			boradCasting.put("type", MSG_TYPE_CHAT);
//			boradCasting.put("chatContent", msgMap.get("chatContent"));
//			boradCasting.put("memberNo", msgMap.get("memberNo"));
//			boradCasting.put("memberName", obj.getMemberName());
//			boradCasting.put("profileImg", obj.getProfileImg());
	        LocalDateTime currentTime = LocalDateTime.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        String formattedTime = currentTime.format(formatter);
	        msg.put("now", formattedTime);
			
			ObjectMapper objectMapper = new ObjectMapper();
			String jsonMsg = null;
			
			try {
				jsonMsg = objectMapper.writeValueAsString(msg);
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
	        
            Util.broadCasting(projectMemberMap, jsonMsg);
            

            int res = service.updateBookedChatStatusY(projectNo, memberNo, seq);
            

            if(res >0 ) {
            	logger.info("예약 메시지 전송 후 상태 바꾸기 성공");
            	
    			Map<String, Object> inputMap = new HashMap<>();

    			inputMap.put("chatContent", chatContent);
    			inputMap.put("memberNo", memberNo);
    			inputMap.put("projectNo", projectNo);
            	res = service.chatSend(inputMap);
            	if(res > 0) {
                	logger.info("예약 메시지 전송 후 메시지 db 삽입");
            	} else {
            		logger.info("예약 메시지 전송 후 메시지 db 삽입 실패");
            	}
            	
            	
            } else {
            	logger.info("예약 메시지 전송 후 상태 바꾸기 실패");
            }
            
        }, new Date(System.currentTimeMillis() + delay));
    }
	
}
