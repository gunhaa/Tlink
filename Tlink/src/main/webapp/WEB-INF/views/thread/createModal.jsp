<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>

</head>
<body>
    <!-- 모달 파트 -->
    <section id="modalContainer" class="hidden">
        <div class="modalContent">
            <div class="modalHeader">
                <p>#새로운 스레드 시작하기</p>
                <button id="closeBtn">close</button>
            </div>
            <div class="saperator"></div>

            <form action="/thread/createThread" method="post" onsubmit="return invalid()">
                <div class="modalBody">
                    <p>스레드 이름</p>
                    <input type="text" name="threadTitle" id="threadTitle" class="searchBar">
                    <p>채널에서는 특정 주제에 대한 대화가 이루어집니다. 찾고 이해하기 쉬운 이름을 사용하세요.</p>
                    <p>멤버 검색</p>
                    <input type="search" name="query" id="query" placeholder="아이디 또는 이름을 입력해주세요." autocomplete="off" value="${param.query}" class="searchBar">
    
                    <ul id="queryResult"></ul>
    
                    <div id="listArea" class="memberArea">
                        <div class="memberItem">
                            <div class="memberInfo">
                                <div class="memberProfile">
                                    <img src="/resources/images/common/user.png">
                                </div>
                                <div class="userName">${loginUser.userName}</div>
                                <div class="email">${loginUser.userEmail}</div>
                            </div>
                            
                        </div>
                    </div>
                </div>

                
                <div class="modalBtnArea">
                    <input type="submit" id="createThreadBtn" value="스레드 생성하기"></input>
                </div>
                <!-- input -->
                <input type="hidden" name="userList" value="${loginUser.userNo}" >
                <input type="hidden" name="projectNo" value="${param.projectNo}">
            </form>
        </div>
    </section>
</body>
</html>