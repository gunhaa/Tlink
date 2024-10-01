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
	

//	@Autowired
//	private Map<String, String> whiteBoardMap;
	
	
//	private Logger logger = LoggerFactory.getLogger(Util.class);
	
	
//    public final void appendDrawData(String projectNo, String newDraw) {
//        try {
//            // 기존 JSON 데이터를 가져와서 리스트로 변환
//            ObjectMapper objectMapper = new ObjectMapper();
//            if(whiteBoardMap ==null) {
//            	whiteBoardMap.put(projectNo, "");
//            }
//            String existingDrawJson = whiteBoardMap.get(projectNo);
//            List<Map<String, Object>> drawList;
//
//            if (existingDrawJson == null || existingDrawJson.isEmpty()) {
//                drawList = new ArrayList<>();
//            } else {
//                try {
//                    drawList = objectMapper.readValue(existingDrawJson, new TypeReference<List<Map<String, Object>>>() {});
//                } catch (IOException e) {
//                    logger.error("기존 JSON 파싱 오류: {}", existingDrawJson, e);
//                    drawList = new ArrayList<>(); // 파싱 오류 발생 시 빈 리스트로 초기화
//                }
//            }
//
//            // 새로운 JSON 데이터를 리스트로 변환
//            List<Map<String, Object>> newDrawList;
//            try {
//                newDrawList = objectMapper.readValue(newDraw, new TypeReference<List<Map<String, Object>>>() {});
//            } catch (IOException e) {
//                logger.error("새로운 JSON 파싱 오류: {}", newDraw, e);
//                newDrawList = new ArrayList<>(); // 파싱 오류 발생 시 빈 리스트로 초기화
//            }
//
//            // 새로운 데이터를 기존 리스트에 추가
//            drawList.addAll(newDrawList);
//
//            // 업데이트된 리스트를 JSON 문자열로 변환하여 저장
//            String updatedDrawJson = objectMapper.writeValueAsString(drawList);
//            whiteBoardMap.put(projectNo, updatedDrawJson);
//
//        } catch (Exception e) {
//            logger.error("appendDrawData 오류", e);
//        }
//    }
	
}
