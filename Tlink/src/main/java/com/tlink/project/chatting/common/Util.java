package com.tlink.project.chatting.common;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.tlink.project.chatting.websocket.VideoConference;
@Component
public class Util {

//    @Autowired
//    private Map<String, String> whiteBoardMap;
	
	public static final void broadCasting(Map<String, WebSocketSession> projectMemberMap, String msg) {
		
		projectMemberMap.forEach((memberId, s)->{
			try {
				
				s.sendMessage(new TextMessage(msg));
				
			}catch(IOException e){
				e.printStackTrace();
			}
		});
		
	}
	
	
	
	// 파일명 변경 메소드
	public static String fileRename(String originFileName) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String date = sdf.format(new java.util.Date(System.currentTimeMillis()));

		int ranNum = (int) (Math.random() * 100000); // 5자리 랜덤 숫자 생성

		String str = "_" + String.format("%05d", ranNum);

		String ext = originFileName.substring(originFileName.lastIndexOf("."));

		return date + str + ext;
	}
	
	
}
