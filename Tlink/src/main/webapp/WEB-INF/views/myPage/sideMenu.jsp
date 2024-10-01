<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage/sideMenu.css">
            <title>Document</title>
        </head>

        <body>
            
            <main>
                
                <section class="container">
                    <div class="sidebar">
                        <!-- 프로필 이미지 -->
                        <div class="side-menu">
                            <div class="top">
                                <div class="profile-img">
                                    <input type="file" style="display: none;" id="inputProfile">
                                    <label for="inputProfile">
                                        <c:if test="${empty loginUser.profileImg}">
                                            <img src="/resources/images/common/user.png" id="image">
                                        </c:if>
                                        <c:if test="${!empty loginUser.profileImg}">
                                            <img src="${loginUser.profileImg}" id="image">
                                        </c:if>
                                        
                                    </label>
                                    <span id="delete-image">x</span>
                                </div>
                            </div>
                            <!-- 메뉴 -->
                            <div class="mid">
                                <!-- 사용자 -->
                                <c:if test="${loginUser.role == 'U'}">
                                    <div class="menu" onclick="location.href='/myPage/project'">프로젝트</div>
                                    <div class="menu" onclick="location.href='/notice'">공지사항</div>
                                    <div class="menu" onclick="location.href='/myPage/info'">내 정보</div>
                                    <div class="menu" onclick="location.href='/myPage/changePw'">비밀번호 변경</div>
                                    <div class="menu" onclick="location.href='/myPage/secession'">회원 탈퇴</div>
                                </c:if>
                                <!-- 시스템 관리자 -->
                                <c:if test="${loginUser.role != 'U'}">
                                    <div class="menu" onclick="location.href='/notice'">공지사항</div>
                                    <c:if test="${loginUser.role == 'S'}">
                                        <div class="menu" onclick="location.href='/myPage/systemUser'">관리자 계정</div>
                                    </c:if>
                                    <div class="menu" onclick="location.href='/myPage/secession'">회원 탈퇴</div>
                                </c:if>
                                
                            </div>
                            <div class="bot">
                                <div class="logout" onclick="location.href='/logout'">로그아웃</div>
                            </div>
                        </div>
                    </div>
                </section>
            </main>
            
            <c:if test="${!empty message}">
                
                <script>
                    // EL/JSTL 구문이 먼저 해석되는데
                    // 문자열의 경우 따옴표가 없는 상태이니 붙여줘야한다!!!
                    alert('${message}');
                    </script>

            </c:if>
<script src="${pageContext.request.contextPath}/resources/js/myPage/profileImage.js" defer></script>

</body>

</html>