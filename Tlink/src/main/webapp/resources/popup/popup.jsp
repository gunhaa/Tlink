<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
   	     <html lang="ko" translate="no">
            <script>
                const req = "<%=request.getContextPath()%>";
            </script>

            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
                <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/videoConference/popup.css">
                <script src="https://kit.fontawesome.com/4bef400c33.js" crossorigin="anonymous"></script>
            </head>

            <body>
                <main>

                    <div id="title-container"><b></b></div>
                    <div id="middle-container">
                        <div id="video-container">
                        </div>
                        <div id="chat-container">
                            <div class="chat-itembox">

                            </div>
                           <div class="chat-inputbox">
                                <div class="chat-background">
                                    <input class="chat-input">
                                </div>
                                <button class="chat-send btn btn2"><span class="material-symbols-outlined">send</span></button>
                                <button class="chat-booked btn btn2"><span class="material-symbols-outlined">alarm</span></button>
                           </div>
                        </div>
                    </div>
                    <div id="button-container">
                        <div id="btn-box">
                            <div class="btn btn1" id="video-btn"><span class="material-symbols-outlined">videocam</span></div>
                            <div class="btn btn1" id="mic-btn"><span class="material-symbols-outlined">mic</span></div>
                            <!-- <div class="btn btn1" id="display-btn">화</div> -->
                            <div class="btn btn1" id="change-btn"><span class="material-symbols-outlined">screen_share</span></div>
                            <div class="btn btn1" id="board-btn"><span class="material-symbols-outlined">content_paste</span></div>
                            <div class="btn btn1" id="changeTitle-btn">주제 변경</div>
                            <div class="optionBox none" id="option-window">
                                <div class="options1">카메라(사용중)</div>
                                <div class="options2">화면 공유</div>
                            </div>
                        </div>
                        <div class="btn" id="exit-btn">
                            <b>나가기</b>
                        </div>
                    </div>

                    </div>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
                    <script src="<%=request.getContextPath()%>/resources/js/videoConference/popup.js"
                        crossorigin="anonymous"></script>
                </main>

            </body>

            </html>