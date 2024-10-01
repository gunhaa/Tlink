<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" href="/resources/css/notice/noticeWrite.css">
    <script src="https://kit.fontawesome.com/71eaa9d255.js" crossorigin="anonymous"></script>
</head>
<body>

<section class="all-container">
    <jsp:include page="/WEB-INF/views/myPage/sideMenu.jsp"/>
    <section class="notice-main">
        <article class="main-top">
            <a href="/notice"><img src="/resources/images/common/TLink_logo.png"></a>
        </article>
        <form action="/notice2/insert" method="POST" enctype="multipart/form-data">
            <article class="main-title-area">
                <input type="text" placeholder="제목을 입력하세요(최대 50자)" name="noticeTitle"/>
            </article>
            <article>
                <article class="main-container">
                    <div class="file-download">
                        <span>첨부파일 : </span>
                        <input type="file" id="noticeUpdateFile" name="images" />
                        <button type="button" id="noticeCancelFile">X</button>
                    </div>

                    <div class="text-area">
                        <textarea class="content-textarea" placeholder="내용을 입력하새요(최대 1500자)" name="noticeContent"></textarea>
                    </div>
                    <div id="imagesContainer">
                        <!-- Initial Image Area -->
                        <div class="each-image-area">
                            <div class="images-area">
                                <label for="img1">
                                    <img class="preview">
                                </label>
                                <input type="file" name="images" class="inputImage" id="img1" accept="image/*,application/zip">
                                <span class="delete-image">&times;</span>
                            </div>
                            <div>
                                <i class="fa-solid fa-trash-can"></i>
                            </div>
                        </div>
                    </div>
                    <button type="button" id="addImageButton"><i class="fa-solid fa-file-circle-plus"></i></button>

                    
                </article>
                <article class="titleNav">
                    <div>
                        <div>
                            <div class="TLINK-title">공지 설정</div>
                            <label><input type="checkbox" name="noticeStatus" value="3"/>공지사항 상단 고정</label></br>
                            <label><input type="checkbox" name="noticeCommentView" value="1" checked/>댓글 허용</label></br>
                            <label><input type="checkbox" name="noticeCopy" value="1"/>복사 저장 허용 </label></br>
                            <span>게시글 타입 : </span>
                            <select name="noticeType" id="searchKey">
                                <option value="1">안내</option>
                                <option value="2">새기능 안내</option>
                                <option value="3">정책 변경</option>
                            </select>
                        </div>
                        <div class="btn-area">
                            <button type="button" id="insertBtn">등록하기</button>
                            <button><a href="/notice">취소하기</a></button>
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

    <script src="/resources/js/notice/noticeWrite.js"></script>

</body>
</html>