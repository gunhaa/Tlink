<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원탈퇴</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage/myPage.css">
    <script src="${pageContext.request.contextPath}/resources/js/myPage/secession.js" defer></script>
</head>

<body>

    <main>

        <section class="container">
            <jsp:include page="/WEB-INF/views/myPage/sideMenu.jsp"/>
            <!-- 우측 -->
            <div class="content">
                <div class="title">회원탈퇴</div>

                <!-- 상단 카드 -->
                <form action="/myPage/secession" method="post" id="secessionFrm">
                    <div class="card">
                        <div class="card-row">
                            <div class="row-title">현재 비밀번호</div>
                            <div class="row-content">
                                <input type="password" id="inputPw" name="inputPw" placeholder="현재 비밀번호를 입력해주세요.">
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="terms">
                            <span>회원 탈퇴에 관한 약관</span>
                            <span>1. 회원 정보가 소실됩니다.</span>
                            <span>2. 현재 아이디로 재가입이 불가능합니다.</span>
                            <span>3. 진행중인 프로젝트에서 탈퇴 처리됩니다.</span>
                            <span>4. 생성한 프로젝트의 매니저 직위는 위임됩니다.</span>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-row">
                            <div class="agree">
                                위의 약관을 확인했습니다.
                            </div>
                            <div>
                                <input type="checkbox" id="agree">
                            </div>
                        </div>
                    </div>

                    <div class="btn-area">
                        <button type="submit">탈퇴</button>
                    </div>
                </form>
            </div>
        </section>
    </main>

</body>

</html>
