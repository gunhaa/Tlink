<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- map에 저장된 값들을 각각 변수에 저장 --%>
<c:set var="pagination" value="${map.pagination}"/>
<c:set var="deleteNoticeList" value="${map.deleteNoticeList}"/>

<c:if test="${!empty param.query}">
    <c:set var="sURL" value="&query=${param.query}"/>
</c:if>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>notice main</title>
    <script src="https://kit.fontawesome.com/71eaa9d255.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/css/notice/noticeMain.css">
</head>
<body>
    <section class="all-container">
        <jsp:include page="/WEB-INF/views/myPage/sideMenu.jsp"/>

        <section class="notice-main">

            <article class="main-top">
                <a href="/notice"><img src="/resources/images/common/TLink_logo.png"></a>
            </article>
            <article class="main-middle">
                <div>
                    <span><a href="/notice/deletedList">삭제된 게시글</a></span>
                </div>
                <div>
                    <div>

                    </div>
                    <fieldset>
                        <form action="/notice/deletedList" method="get" id="boardSearch">
                            <input type="text" name="query"  id="searchQuery" placeholder="검색어를 입력해주세요.">
                            <button id="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
                        </form>
                    </fieldset>
                </div>
            </article>
                
            <article id="table-area">
                <table class="list-table">
                    
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>제목</th>
                            <th>작성일</th>
                            <th>첨부파일</th>
                            <th>조회수</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="notice" items="${deleteNoticeList}">
                            <tr>
                                <td>${notice.noticeNo}</td>
                                <td> 
                                    <a href="/notice/deletedList/${notice.noticeNo}?cp=${pagination.currentPage}&${sURL}">
                                    <c:if test="${notice.noticeType == 1}">
                                        [안내]${notice.noticeTitle}
                                    </c:if>
                                    <c:if test="${notice.noticeType == 2}">
                                        [새기능 안내]${notice.noticeTitle}
                                    </c:if>
                                    <c:if test="${notice.noticeType == 3}">
                                        [정책 변경 안내]${notice.noticeTitle}
                                    </c:if>
                                    </a>
                                    <c:if test="${notice.noticeCommentView == 2}"> 
                                    </c:if>
                                    <c:if test="${notice.noticeCommentView == 1}"> 
                                        [${notice.commentCount}]   
                                    </c:if>
                                </td>
                                <td>${notice.createDate}</td>
                                <td>
                                    <c:forEach var="file" items="${notice.fileList}">
                                        <c:if test="${file.fileOrder == 0}">
                                            <span><i class="fa-solid fa-file-lines"></i></span>
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>${notice.readCount}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </article>
            <article>

                

                <div class="pagination-area">

                    <ul class="pagination">
                        <li><a href="/notice/deletedList?cp=1${sURL}">&lt;&lt;</a></li>
                        <li><a href="/notice/deletedList?cp=${pagination.prevPage}${sURL}">&lt;</a></li>

                        <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}" step="1">
                            <c:choose>
                                <c:when test="${i == pagination.currentPage}">
                                    <li><a class="current">${i}</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href="/notice/deletedList?cp=${i}${sURL}">${i}</a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <li><a href="/notice/deletedList?cp=${pagination.nextPage}${sURL}">&gt;</a></li>
                        <li><a href="/notice/deletedList?cp=${pagination.maxPage}${sURL}">&gt;&gt;</a></li>
                    </ul>
                </div>
            </article>
        </section>
    </section>


</body>
</html>