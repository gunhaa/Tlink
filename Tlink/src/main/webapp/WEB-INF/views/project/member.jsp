<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">
    
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>멤버 관리</title>
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage/myPage.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>
    
    <body>
        <c:set var="project" value="${map.project}"/>
        <c:set var="memberList" value="${map.memberList}"/>
    
        <main>

            <section class="container" style="display: flex;">
                <jsp:include page="/WEB-INF/views/common/side.jsp" />
                <!-- 우측 -->

                
                <div class="content">
                        <div class="title">멤버 관리</div>
    
                        <!-- 상단 카드 -->
                        <div class="card">
                            <div class="card-row">
                                <div class="member-project-title">${project.projectTitle}</div>
                            </div>
                            <div class="member-list">

                                <c:forEach var="member" items="${memberList}">
                                    <div class="member">
                                        <div class="member-profile">
                                            <c:if test="${empty member.profileImg}">
                                                <img src="/resources/images/common/user.png" id="image">
                                            </c:if>
                                            <c:if test="${!empty member.profileImg}">
                                                <img src="${member.profileImg}" id="image">
                                            </c:if>
                                        </div>
                                            <div class="member-name">
                                                ${member.userName}
                                            </div>
                                        <div class="member-email">
                                            ${member.userEmail}
                                        </div>
                                        <c:if test="${project.manager == loginUser.userNo}">
                                            <c:if test="${loginUser.userNo != member.userNo}">
                                                <i class="fa-solid fa-user-xmark" 
                                                onclick="location.href='/project/deleteMember?userNo=${member.userNo}&projectNo=${project.projectNo}'"></i>
                                            </c:if>
                                        </c:if>
                                    </div>
                                </c:forEach>
                  
                            </div>
                            
                        </div>
                        
                        <div class="btn-area">
                            <button class="modal-btn">멤버 초대</button>
                        </div>
                </div>
            </section>
        </main>

        <jsp:include page="/WEB-INF/views/project/member-modal.jsp">
            <jsp:param name="projectNo" value="${project.projectNo}" />
        </jsp:include>
    

    </body>
    
    </html>