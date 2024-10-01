package com.tlink.project.chatting.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.tlink.project.chatting.model.dto.GeminiRequest;
import com.tlink.project.chatting.model.dto.GeminiResponse;

@Service
public class GeminiSeviceImpl implements GeminiService {

    @Qualifier("geminiRestTemplate")
    @Autowired
    private RestTemplate restTemplate;

    private static final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent";

    private static final String GEMINI_API_KEY = "AIzaSyD-4TZyQsJgNA8hIvQKEOOG5bVlpKzZHws";
	
	@Override
	public String useGemini(String prompt) {

        String requestUrl = API_URL + "?key=" + GEMINI_API_KEY;

        GeminiRequest request = new GeminiRequest(prompt);
        // gemini에 요청 전송
        GeminiResponse response = restTemplate.postForObject(requestUrl, request, GeminiResponse.class);
        
        String message = response.getCandidates().get(0).getContent().getParts().get(0).getText().toString();

        return message;
	}

}
