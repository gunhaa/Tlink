<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/modal.css">
    <title>Document</title>
</head>
<body>
<!--모달 팝업-->
<form action="/project/create" method="post" id="createFrm">
    <div class="modal1">
        <div class="modal_popup">
            <h3 style="margin-bottom: 20px;">프로젝트 생성</h3>
            <div class="modal-row">
                <span class="input-title">프로젝트명</span><input type="text" name="projectTitle" id="projectTitle">
            </div>
            <div class="modal-row">
                <span class="input-title">프로젝트 설명</span><input type="text" name="projectInfo" id="projectInfo">
            </div>
            <div class="btn-area">
                <button type="button" class="close-btn">닫기</button>
                <button class="submit-btn">생성</button>
            </div>
        </div>
    </div>
</form>

<script>
    document.getElementById("createFrm").addEventListener("submit", e=>{
        const projectTitle = document.getElementById("projectTitle");
        const projectInfo = document.getElementById("projectInfo");

        if(projectTitle.value.trim().length == 0){
            alert("프로젝트명을 입력해주세요.");
            projectTitle.focus()
            e.preventDefault();
            return;
        }

        if(projectInfo.value.trim().length == 0){
            alert("프로젝트 설명을 입력해주세요.");
            projectInfo.focus()
            e.preventDefault();
            return;
        }

    })
</script>


</body>
</html>