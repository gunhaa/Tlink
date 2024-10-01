<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">
    
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>관리자 페이지</title>
        <link rel="stylesheet" href="../CSS/sideMenu.css">
        <link rel="stylesheet" href="../CSS/myPage.css">
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage/myPage.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    
    <body>
    
        <main>
    
            <section class="container">
                <jsp:include page="/WEB-INF/views/myPage/sideMenu.jsp"/>
                <!-- 우측 -->
                <div class="content">
                        <div class="title">관리자 계정</div>
    
                        <!-- 상단 카드 -->
                        <div class="card">
                            <div class="card-row">
                                <div class="member-project-title">관리자 목록</div>
                            </div>
                            <div class="member-list">

                                <c:forEach var="admin" items="${adminList}">
                                    <div class="member">
                                        <div class="member-profile">
                                            <img src="/resources/images/common/user.png" id="image">
                                        </div>
                                        <c:if test="${admin.role == 'S'}">
                                            <div class="member-name">
                                                시스템 관리자
                                            </div>
                                        </c:if>
                                        <c:if test="${admin.role == 'A'}">
                                            <div class="member-name">
                                                일반 관리자
                                            </div>
                                        </c:if>
                                        <div class="member-email">
                                            ${admin.userEmail}
                                        </div>
                                        <c:if test="${loginUser.userNo != admin.userNo}">
                                            <i class="fa-solid fa-user-xmark" onclick="location.href='/deleteAdmin?userNo=${admin.userNo}'"></i>
                                        </c:if>
                                    </div>
                                </c:forEach>
                  
                            </div>
                            
                        </div>
                        
                        <div class="btn-area">
                            <button class="modal-btn">관리자 생성</button>
                        </div>
                </div>
            </section>
        </main>

        <jsp:include page="/WEB-INF/views/myPage/admin-modal.jsp"/>
    

    </body>
    
    </html>