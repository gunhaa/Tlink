<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thread</title>

    <link rel="stylesheet" href="/resources/css/thread/newThread-style.css">
    <link rel="stylesheet" href="/resources/css/thread/threadUtil-style.css">

</head>
<body>
    <main style="display: flex;">
        <jsp:include page="/WEB-INF/views/common/side.jsp"/>

        <section class="view">
            <div class="createThread">
                <p>#스레드에 오신걸 환영합니다.</p>
                <P>아직 스레드를 만들지 않았다면 새로운 스레드와 함께 동료들과 의사 결정 파일 공유등을 진행하세요</P>
                <button id="createThread">새로운 스레드 시작하기</button>
            </div>
        </section>
    
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
                        <input type="text" name="threadTitle" id="threadTitle" >
                        <p>채널에서는 특정 주제에 대한 대화가 이루어집니다. 찾고 이해하기 쉬운 이름을 사용하세요.</p>
                        <p>멤버 검색</p>
                        <input type="search" name="query" id="query" placeholder="아이디 또는 이름을 입력해주세요." autocomplete="off" value="${param.query}">
        
                        <ul id="queryResult"></ul>
        
                        <div id="listArea" class="memberArea">
                            <div class="memberItem">
                                <div class="memberProfile">
                                    <img src="/resources/images/common/user.png">
                                    <span>${loginUser.userName}</span>
                                    <span class="email">${loginUser.email}/span>
                                </div>
                            </div>
                        </div>
                    </div>

                    
                    <div class="modalBtnArea">
                        <input type="submit" id="createThreadBtn" value="스레드 생성하기"></input>
                    </div>
                    <!-- input -->
                    <input type="hidden" nama="userList" value="${loginUser.userNo}" >
                    <input type="hidden" name="projectNo" value="${param.projectNo}">
                </form>
            </div>
        </section>
    
        <script>
            const loginMemberNo = "${loginUser.userNo}";
            const projectNo = "${param.projectNo}"; 
        </script>
    
        <script src="/resources/js/thread/newThread-modal.js"></script>
    </main>
</body>
</html>