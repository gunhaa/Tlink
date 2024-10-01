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
                <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/videoConference/whiteBoard.css">
                <script src="https://kit.fontawesome.com/4bef400c33.js" crossorigin="anonymous"></script>
            </head>

            <body>
                <main>
							<div id="whiteboard-container">
							    <canvas id="whiteboard" width="600" height="600"></canvas>
   						</div>
   						<div id="button-container">
                        <div id="btn-box">
<!--                             <div class="btn btn1" id="blackPen"><span class="material-symbols-outlined">brush</span></div>
                            <div class="btn btn1" id="bluePen"><span class="material-symbols-outlined">brush</span></div>
 -->                            <!-- <div class="btn btn1" id="display-btn">화</div> -->
<!--                             <div class="btn btn1" id="redPen"><span class="material-symbols-outlined">brush</span></div> -->
                            <input type="color" class="btn2"></input>
<!--                             <div class="btn btn1" id="penBtn"><span class="material-symbols-outlined">brush</span></div> -->
                            <div class="btn btn1" id="erase"><span class="material-symbols-outlined">description</span></div>
                            <div class="btn btn1" id="save"><span class="material-symbols-outlined">save</span></div>
                        </div>
<!--                         <div class="btn" id="exit-btn">
                            <b>나가기</b>
                        </div> -->
                    </div>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
                    <script src="<%=request.getContextPath()%>/resources/js/videoConference/whiteBoard.js"
                        crossorigin="anonymous"></script>
                </main>

            </body>

            </html>