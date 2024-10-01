<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="https://kit.fontawesome.com/71eaa9d255.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/css/notice/noticeDetail.css">
</head>
<body>

    <section class="all-container">
        <jsp:include page="/WEB-INF/views/myPage/sideMenu.jsp"/>
        <section class="notice-main">
            <article class="main-top">
                <a href="/notice"><img src="/resources/images/common/TLink_logo.png"></a>
            </article>
            <article class="main-title-area">
                <div>
                    <c:choose>
                        <c:when test="${notice.noticeStatus == 3}">
                            [중요]${notice.noticeTitle}
                        </c:when>
                        <c:otherwise>
                            <c:if test="${notice.noticeType == 1}">[안내]</c:if>
                            <c:if test="${notice.noticeType == 2}">[새기능 안내]</c:if>
                            <c:if test="${notice.noticeType == 3}">[정책 변경 안내]</c:if>
                            ${notice.noticeTitle}
                        </c:otherwise>
                    </c:choose>
                </div>
            </article>
            <article>
                <article class="main-container">
                    <div class="writer-info">
                        <img src="/resources/images/common/admin_profile.png" alt="">
                        <div>
                            <p>관리자</p>
                            <c:choose>
                                <c:when test="${empty notice.updateDate}">작성일 : ${notice.createDate}</c:when>
                                <c:otherwise>마지막 수정일 : ${notice.updateDate}</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <c:forEach var="file" items="${notice.fileList}">
                        <c:if test="${file.fileOrder == 0}">
                            <div class="file-download">
                                첨부파일 <a href="${file.filePath}${file.fileReName}" download>${file.fileOriginal}</a>
                            </div>
                        </c:if>
                    </c:forEach>
                    <div class="text-area">
                        ${notice.noticeContent}
                    </div>

                    <c:forEach var="file" items="${notice.fileList}">
                        <c:if test="${file.fileOrder != 0}"> <!-- fileOrder가 0이 아닌 경우에만 -->
                            <div class="images-area">
                                <c:set var="path" value="${file.filePath}${file.fileReName}"/>
                                <img src="${path}"/>
                            </div>
                        </c:if>
                    </c:forEach>
                    
                    <c:if test="${notice.noticeCommentView == 1}"> 
                        <jsp:include page="noticeComment.jsp"/>
                    </c:if>
                    <c:if test="${notice.noticeCommentView == 2}"> 
                        <div class="comment-view">
                            <span>해당 게시글은 댓글 작성이 중지되었습니다.</span>
                        </div>
                    </c:if>
                </article>
                
                <article class="titleNav">
                    <div>
                        <div>
                            <div class="TLINK-title">최근 TLINK 소식</div>
                            <c:forEach var="TitleList" items="${noticeTitleList}">
                                <div class="listTitle">
                                    <a href="/notice/${TitleList.noticeNo}">
                                        <c:choose>
                                            <c:when test="${TitleList.noticeStatus == 3}">
                                                [중요]${TitleList.noticeTitle}
                                            </c:when>
                                            <c:otherwise>
                                                <c:if test="${TitleList.noticeType == 1}">✓[안내]</c:if>
                                                <c:if test="${TitleList.noticeType == 2}">✓[새기능 안내]</c:if>
                                                <c:if test="${TitleList.noticeType == 3}">✓[정책 변경 안내]</c:if>
                                                ${TitleList.noticeTitle}
                                            </c:otherwise>
                                        </c:choose>
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                        <div class="btn-area">
                            <button><a href="/notice">목록으로</a></button>
                            <c:if test="${loginUser.role != 'U'}">
                                <div>
                                    <button><a href="/notice2/${notice.noticeNo}/update">수정하기</a></button>
                                    <button id="deleteBtn" onclick="confirmDelete()">삭제하기</button>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </article>
            </article>
        </section>


    </section>

    <script>
        // 게시글 번호 변수로 선언
        const noticeNo = "${notice.noticeNo}";

        const noticeCopy = "${notice.noticeCopy}"
        // 로그인한 회원 번호 변수로 선언
        const loginUserNo = "${loginUser.userNo}";
        const loginUserRole = "${loginUser.role}";

    </script>

    <script src="/resources/js/notice/noticeDetail.js"></script>
    <script src="/resources/js/notice/noticeComment.js"></script>

</body>
</html>