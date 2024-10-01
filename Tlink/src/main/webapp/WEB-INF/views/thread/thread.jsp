<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>




<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thread</title>

    <link rel="stylesheet" href="/resources/css/thread/threadUtil-style.css">
    <link rel="stylesheet" href="/resources/css/thread/thread-style.css">

</head>
<body>
    <main style="display: flex; margin:0px;">
        <jsp:include page="/WEB-INF/views/common/side.jsp"/>

        <container style="display: flex; flex-direction: column; width: 1200px; margin: 0px;">
            <section class="chatView" style="height: 700px">
                <div class="viewHeader">
                    <span>${threadTitle}</span>
                    <div>
                        <div class="memberList"></div>
                        <button>Settings</button>
                    </div>
                </div> 
        
                <div class="saperator"></div>
        
                <div class="viewMain">
                    <ul id="chatBox">
                        <c:forEach var="chat" items="${chatList}">
                                <li class="chatNormal">
                                    <div class="profile">
                                        <c:if test="${ empty chat.memberProfile }">
                                            <img src="/resources/images/common/user.png">
                                        </c:if>
                                        <c:if test="${ !empty chat.memberProfile }">
                                            <img src="${contextPath}${chat.memberProfile}">
                                        </c:if>
                                    </div>
                                    <div>
                                        <div class="infoLine">
                                            <span>${chat.memberNickname}</span>
                                            <span class="createDate">${chat.chatCreateDate}</span>
                                        </div>
                                        <div>${chat.chatMessage}</div>
                                    </div>
                                </li>        
                        </c:forEach>

                    </ul>
                </div>
        
            </section>
     
            <section class="threadInput">
                    
                    <div id="inputBox" contenteditable="true"></div>
                    
                    <div class="inputBtnArea">
                        <input type="file" name="files" id="inputFile" multiple>
                        <button type="button" class="btn" id="send">send</button>
                    </div>
    
                    <!--  -->
                    <input type="hidden" name="message" id="message">
            </section>
        </container>
        
    
        <script src="/resources/js/thread/thread.js"></script>
    </main>
	
</body>
</html>