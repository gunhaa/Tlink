<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage/myPage.css">
    <script src="${pageContext.request.contextPath}/resources/js/myPage/changePw.js" defer></script>
</head>

<body>

    <main>

        <section class="container">
        	<jsp:include page="/WEB-INF/views/myPage/sideMenu.jsp"/>
            <!-- 우측 -->
            <div class="content">
                <form action="#">
                    <div class="title">비밀번호 변경</div>

                    <!-- 상단 카드 -->
                    <div class="card">
                        <div class="card-row">
                            <div class="row-title">현재 비밀번호</div>
                            <div class="row-content">
                                <input type="password" id="currentPw" placeholder="현재 비밀번호를 입력해주세요.">
                            </div>
                        </div>
                        <div class="card-row">
                            <div class="row-title">새 비밀번호</div>
                            <div class="row-content">
                                <input type="password" id="newPw" placeholder="새로운 비밀번호를 입력해주세요.">
                            </div>
                        </div>
                        <div class="card-row">
                            <div class="row-title">비밀번호 확인</div>
                            <div class="row-content">
                                <input type="password" id="pwCheck" placeholder="새로운 비밀번호를 확인해주세요.">
                            </div>
                        </div>
                    </div>

                    <div class="btn-area">
                        <button id="changePwBtn" type="button">변경</button>
                    </div>
                </form>
            </div>
        </section>
    </main>

    
</body>

</html>