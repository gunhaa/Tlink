package com.tlink.project.chatting.common;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.WebSocketSession;

@Configuration
public class MapConfig {

    @Bean
    public Map<String, String> whiteBoardMap() {
        return new ConcurrentHashMap<>();
    }
 
    @Bean
    public Map<String, Map<String, WebSocketSession>> projectMap() {
        return new ConcurrentHashMap<>();
    }
    
}

