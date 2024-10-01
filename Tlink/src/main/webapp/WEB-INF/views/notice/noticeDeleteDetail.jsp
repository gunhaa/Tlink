<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" href="/resources/css/notice/noticeDeleteDetail.css">
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
                        <c:when test="${noticeDelete.noticeStatus == 3}">
                            [중요]${noticeDelete.noticeTitle}
                        </c:when>
                        <c:otherwise>
                            <c:if test="${noticeDelete.noticeType == 1}">[안내]</c:if>
                            <c:if test="${noticeDelete.noticeType == 2}">[새기능 안내]</c:if>
                            <c:if test="${noticeDelete.noticeType == 3}">[정책 변경 안내]</c:if>
                            ${noticeDelete.noticeTitle}
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
                                <c:when test="${empty noticeDelete.updateDate}">작성일 : ${notice.createDate}</c:when>
                                <c:otherwise>마지막 수정일 : ${noticeDelete.updateDate}</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <c:forEach var="file" items="${noticeDelete.fileList}">
                        <c:if test="${file.fileOrder == 0}">
                            <div class="file-download">
                                첨부파일 <a href="${file.filePath}${file.fileReName}" download>${file.fileOriginal}</a>
                            </div>
                        </c:if>
                    </c:forEach>
                    <div class="text-area">
                        ${noticeDelete.noticeContent}
                    </div>

                    <c:forEach var="file" items="${noticeDelete.fileList}">
                        <c:if test="${file.fileOrder != 0}"> <!-- fileOrder가 0이 아닌 경우에만 -->
                            <div class="images-area">
                                <c:set var="path" value="${file.filePath}${file.fileReName}"/>
                                <img src="${path}"/>
                            </div>
                        </c:if>
                    </c:forEach>
                    
                    
                </article>
                
                <article class="titleNav">
                    <div>
                        <div>
                            <div class="TLINK-title">공지 설정</div>
                                <label><input type="checkbox" name="noticeStatus" value="3" 
                                    <c:if test="${noticeDelete.noticeStatus == 3}">checked</c:if>/>공지사항 상단 고정
                                </label><br/>
                                <label><input type="checkbox" name="noticeCommentView" value="1" 
                                    <c:if test="${noticeDelete.noticeCommentView == 1}">checked</c:if>/>댓글 허용
                                </label><br/>
                                <label><input type="checkbox" name="noticeCopy" value="1" 
                                            <c:if test="${noticeDelete.noticeCopy == 1}">checked</c:if>/>복사 저장 허용
                                </label><br/>

                                <span>게시글 타입 : </span>
                                <select name="noticeType" id="searchKey">
                                    <c:if test="${noticeDelete.noticeType == 1}">
                                        <option value="1" selected>안내</option>
                                    </c:if>
                                    <c:if test="${noticeDelete.noticeType == 2}">
                                        <option value="2" selected>새기능 안내</option>
                                    </c:if>
                                    <c:if test="${noticeDelete.noticeType == 3}">
                                        <option value="3" selected>정책 변경</option>
                                    </c:if>
                                </select>
                            </div>
                        <div class="btn-area">
                            <div>
                                <button><a href="/notice/deletedList">목록으로</a></button>
                                <button><a href="/notice2/${noticeDelete.noticeNo}/restore">복구하기</a></button>
                            </div>
                        </div>
                    </div>
                </article>
            </article>
        </section>


    </section>

    <script>
        // 게시글 번호 변수로 선언
        const noticeNo = "${notice.noticeNo}";

        const notice = "${notice}"
        const noticeCopy = "${notice.noticeCopy}"

        // 로그인한 회원 번호 변수로 선언
        const loginUserNo = "${loginUser.userNo}";

    </script>

    <script src="/resources/js/notice/noticeDetail.js"></script>

</body>
</html>