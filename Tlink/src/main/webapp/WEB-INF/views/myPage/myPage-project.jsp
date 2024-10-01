<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 프로젝트</title>
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage/myPage.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>


    <main>

        <section class="container">
		<jsp:include page="/WEB-INF/views/myPage/sideMenu.jsp"/>
            <!-- 우측 -->
            <div class="content-area">
                <!-- 프로젝트 모음 -->
                <div class="content">
                    <div class="title">
                        ${loginUser.userName}님의 프로젝트
                        <i class="fa-solid fa-file-circle-plus modal-btn"></i>
                    </div>

                    <!-- 검색창 -->
                    <div class="search-area">
                        <div class="search-bar">
                            <div class="fa-solid fa-magnifying-glass glass" id="search-btn"></div>
                            <input type="text" name="query" id="query">
                        </div>
                        <div id="autocomplete"></div>
                    </div>
                    <div class="projects swiper swiper-project">
                        <div class="swiper-button-next" style="color:#643BAB;" id="search-btn"></div>
                        <div class="wrapper swiper-wrapper">
                            <!-- .project : 프로젝트 하나 -->

                            <c:if test="${!empty projectList}">
                                <c:forEach var="project" items="${projectList}">
                                    <div class="project swiper-slide" onclick="location.href='/workList?projectNo=${project.projectNo}'">
                                        <div class="project-title">${project.projectTitle}</div>
                                        <div class="thumbnail">
                                            <img src="/resources/images/common/dashboard.png">
                                        </div>
                                        <div class="project-info">${project.projectInfo}</div>
                                        <div class="project-info">멤버 ${project.userCount}</div>
                                        <div class="project-info">${project.createDate}</div>
                                    </div>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty projectList}">
                                <div class="empty">
                                    <img src="/resources/images/common/TLink_logo.png">
                                    <div class="create modal-btn" id="show-modal">새로운 프로젝트를 시작해보세요!</div>
                                </div>
                            </c:if>



<!--                             <div class="project swiper-slide">
                                <div class="project-title">세미프로젝트</div>
                                <div class="thumbnail">
                                    <img src="/resources/images/common/dashboard.png">
                                </div>
                                <div class="project-info">kh 세미프로젝트입니다</div>
                                <div class="project-info">멤버 6</div>
                                <div class="project-info">2024.08.29</div>
                            </div>
                            <div class="project swiper-slide">
                                <div class="project-title">세미프로젝트</div>
                                <div class="thumbnail">
                                    <img src="/resources/images/common/dashboard.png">
                                </div>
                                <div class="project-info">kh 세미프로젝트입니다</div>
                                <div class="project-info">멤버 6</div>
                                <div class="project-info">2024.08.29</div>
                            </div>
                            <div class="project swiper-slide">
                                <div class="project-title">세미프로젝트</div>
                                <div class="thumbnail">
                                    <img src="/resources/images/common/dashboard.png">
                                </div>
                                <div class="project-info">kh 세미프로젝트입니다</div>
                                <div class="project-info">멤버 6</div>
                                <div class="project-info">2024.08.29</div>
                            </div>
                            <div class="project swiper-slide">
                                <div class="project-title">세미프로젝트</div>
                                <div class="thumbnail">
                                    <img src="/resources/images/common/dashboard.png">
                                </div>
                                <div class="project-info">kh 세미프로젝트입니다</div>
                                <div class="project-info">멤버 6</div>
                                <div class="project-info">2024.08.29</div>
                            </div> -->

                        </div>
                        <div class="swiper-button-prev" style="color:#643BAB;"></div>
                    </div>
                </div>
                    
            </div>  
        </section>
    </main>

    <jsp:include page="/WEB-INF/views/myPage/project-modal.jsp"/>
    <script src="${pageContext.request.contextPath}/resources/js/myPage/project.js" defer></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
    
</body>
</html>