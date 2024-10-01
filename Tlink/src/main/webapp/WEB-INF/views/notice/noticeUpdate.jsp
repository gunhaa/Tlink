<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

<c:if test="${!empty param.query}">
    <c:set var="sURL" value="&query=${param.query}"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" href="/resources/css/notice/noticeUpdate.css">
    <script src="https://kit.fontawesome.com/71eaa9d255.js" crossorigin="anonymous"></script>
</head>
<body>

    <section class="all-container">
        <jsp:include page="/WEB-INF/views/myPage/sideMenu.jsp"/>
        <section class="notice-main">
            <article class="main-top">
                <a href="/notice"><img src="/resources/images/common/TLink_logo.png"></a>
            </article>
            <form action="/notice2/${notice.noticeNo}/update" method="POST" enctype="multipart/form-data">
                <article class="main-title-area">
                        <input type="text" name="noticeTitle" value='${notice.noticeTitle}'/>
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

                        <div class="file-download">
                            <span>첨부파일 : </span>
                            <c:forEach items="${notice.fileList}" var="file">
                                <c:if test="${file.fileOrder == 0}">
                                    <div id="existingFile">
                                        <a href="${file.filePath}${file.fileReName}" download>${file.fileOriginal}</a>
                                        <button type="button" id="deleteFileBtn">삭제</button>
                                        <input type="hidden" class="fileOrder" value="${file.fileOrder}"/> <!-- 기존 파일 정보를 hidden input으로 저장 -->
                                    </div>
                                </c:if>
                            </c:forEach>
                            <input type="file" id="noticeUpdateFile" name="images" />
                            <button type="button" id="noticeCancelFile">X</button>
                        </div>

                        
                        <div class="text-area">
                            <textarea class="content-textarea" name="noticeContent">${notice.noticeContent}</textarea>
                        </div>


                        <c:forEach items="${notice.fileList}" var="file">
                        
                            <c:choose>
                                <c:when test="${file.fileOrder == 1}">
                                    <c:set var="img1" value="${file.filePath}${file.fileReName}"/>
                                </c:when>
                                <c:when test="${file.fileOrder == 2}">
                                    <c:set var="img2" value="${file.filePath}${file.fileReName}"/>
                                </c:when>
                                <c:when test="${file.fileOrder == 3}">
                                    <c:set var="img3" value="${file.filePath}${file.fileReName}"/>
                                </c:when>
                                <c:when test="${file.fileOrder == 4}">
                                    <c:set var="img4" value="${file.filePath}${file.fileReName}"/>
                                </c:when>
                                <c:when test="${file.fileOrder == 5}">
                                    <c:set var="img5" value="${file.filePath}${file.fileReName}"/>
                                </c:when>
                                <c:when test="${file.fileOrder == 6}">
                                    <c:set var="img6" value="${file.filePath}${file.fileReName}"/>
                                </c:when>
                                <c:when test="${file.fileOrder == 7}">
                                    <c:set var="img7" value="${file.filePath}${file.fileReName}"/>
                                </c:when>
                                <c:when test="${file.fileOrder == 8}">
                                    <c:set var="img8" value="${file.filePath}${file.fileReName}"/>
                                </c:when>
                                <c:when test="${file.fileOrder == 9}">
                                    <c:set var="img9" value="${file.filePath}${file.fileReName}"/>
                                </c:when>
                                <c:when test="${file.fileOrder == 10}">
                                    <c:set var="img10" value="${file.filePath}${file.fileReName}"/>
                                </c:when>
                            </c:choose>
                    
                        </c:forEach>

                        <div id="imagesContainer">
                            <c:forEach items='${notice.fileList}' var='file'>
                                <c:choose>
                                    <c:when test="${file.fileOrder >= 1 && file.fileOrder <= 10}">
                                        <div class="each-image-area">
                                            <div class="images-area">
                                                <label for="img${file.fileOrder}">
                                                    <img class="preview" src="${file.filePath}${file.fileReName}">
                                                </label>
                                                <input type="file" name="images" class="inputImage" id="img${file.fileOrder}" accept="image/*,application/zip">
                                                <span class="delete-image">&times;</span>
                                                <input type="hidden" class="fileOrder" value="${file.fileOrder}">
                                            </div>
                                            <div>
                                                <i class="fa-solid fa-trash-can"></i>
                                            </div>
                                        </div>
                                    </c:when>
                                </c:choose>
                            </c:forEach>
                        </div>
                        <button type="button" id="addImageButton"><i class="fa-solid fa-file-circle-plus"></i></button>
                        <!-- 기존 이미지가 있다가 삭제된 이미지의 순서를 기록 -->
                        <input type="hidden" name="deleteList" value="">

                        <!-- 수정 성공 시 주소(쿼리 스트링) 유지 용도 -->
                        <input type="hidden" name="cp" value="${param.cp}">
                                    
                    </article>

                    <article class="titleNav">
                        <div>
                            <div>
                                <div class="TLINK-title">공지 설정</div>
                                <label><input type="checkbox" name="noticeStatus" value="3" 
                                    <c:if test="${notice.noticeStatus == 3}">checked</c:if>/>공지사항 상단 고정
                                </label><br/>
                                <label><input type="checkbox" name="noticeCommentView" value="1" 
                                    <c:if test="${notice.noticeCommentView == 1}">checked</c:if>/>댓글 허용
                                </label><br/>
                                <label><input type="checkbox" name="noticeCopy" value="1" 
                                            <c:if test="${notice.noticeCopy == 1}">checked</c:if>/>복사 저장 허용
                                </label><br/>

                                <span>게시글 타입 : </span>
                                <select name="noticeType" id="searchKey">
                                    <c:if test="${notice.noticeType == 1}">
                                        <option value="1" selected>안내</option>
                                        <option value="2" >새기능 안내</option>
                                        <option value="3" >정책 변경</option>
                                    </c:if>
                                    <c:if test="${notice.noticeType == 2}">
                                        <option value="1" >안내</option>
                                        <option value="2" selected>새기능 안내</option>
                                        <option value="3" >정책 변경</option>
                                    </c:if>
                                    <c:if test="${notice.noticeType == 3}">
                                        <option value="1" >안내</option>
                                        <option value="2" >새기능 안내</option>
                                        <option value="3" selected>정책 변경</option>
                                    </c:if>
                                </select>
                            </div>
                            <div class="btn-area">
                                <button type="button" id="updateBtn">수정하기</button>
                                <button><a href="/notice/${notice.noticeNo}?cp=${pagination.currentPage}&${sURL}">취소하기</a></button>
                            </div>
                        </div>
                    </article>
                </article>
            </form>
        </section>
    </section>

    <script>
        // 게시글 번호 변수로 선언
        const noticeNo = "${notice.noticeNo}";



        // 로그인한 회원 번호 변수로 선언
        const loginUserNo = "${loginUser.userNo}";
    </script>

    <script src="/resources/js/notice/noticeUpdate.js"></script>

</body>
</html>