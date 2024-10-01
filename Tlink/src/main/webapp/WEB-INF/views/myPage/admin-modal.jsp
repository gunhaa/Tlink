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
<form action="/createAdmin" method="post" id="adminFrm">
    <div class="modal1">
        <div class="modal_popup">
            <h3 style="margin-bottom: 20px;">관리자 생성</h3>
            <div class="modal-row">
                <span class="input-title">이메일</span><input type="text" name="userEmail" id="userEmail">
            </div>
            <div class="modal-row">
                <span class="input-title">비밀번호</span><input type="password" name="userPw" id="userPw">
            </div>
            <div class="modal-row">
                <span class="input-title">비밀번호 확인</span><input type="password" id="pwCheck">
            </div>
            <div class="modal-row">
                <span class="input-title">관리자 타입</span>
                <select name="role">
                    <option value="A">일반 관리자</option>
                    <option value="S">시스템 관리자</option>
                </select>
            </div>
            <input type="hidden" name="userName" value="관리자">
            <input type="hidden" name="userPhone" value="01012341234">
            <div class="btn-area">
                <button type="button" class="close-btn">닫기</button>
                <button class="submit-btn">생성</button>
            </div>
        </div>
    </div>
</form>
<script>

const modal1 = document.querySelector('.modal1');
const modalOpen = document.querySelector('.modal-btn');
const modalClose = document.querySelector('.close-btn');

//열기 버튼을 눌렀을 때 모달팝업이 열림
modalOpen.addEventListener('click',function(){
  	//'on' class 추가
    modal1.classList.add('on');
});
//닫기 버튼을 눌렀을 때 모달팝업이 닫힘
modalClose.addEventListener('click',function(){
    //'on' class 제거
    modal1.classList.remove('on');
});

/* ----------------------------------------------------------------- */

    const userEmail = document.getElementById("userEmail");
    const userPw = document.getElementById("userPw");
    const pwCheck = document.getElementById("pwCheck");

    document.getElementById("adminFrm").addEventListener("submit", (e)=>{

        if (userEmail.value.trim().length == 0) {
        userEmail.value = "";
        e.preventDefault();
        alert("이메일을 입력해주세요.")
        userEmail.focus();
        return;
    }

    const regEx = /^[\w\-\_]{4,}@[a-z]+(\.\w+){1,3}$/;

    if (regEx.test(userEmail.value)) {

/* *********************************************************** */
/* fetch() API 이용한 비동기 통신 */

// GET 방식 ajax 요청 (파라미터는 쿼리스트링으로 전달)
fetch("/selectDupEmail?email="+userEmail.value)

.then(resp => resp.text()) // 응답객체 -> 파싱(parsing, 데이터 형태 변환)

.then(count => {

    if(count > 0){
        alert("이미 존재하는 이메일입니다.")
        e.preventDefault();
        return;
    }
}) 

.catch(e=>{console.log(e)})

/* *********************************************************** */


} else {
// 유효하지 않은 경우 : "유효하지 않은 이메일 형식입니다." 빨강
    alert("이메일 형식이 올바르지 않습니다.")
    e.preventDefault();
    return;
}


    if (userPw.value.trim().length == 0) {
            userPw.value = "";
            e.preventDefault();
            alert("비밀번호를 입력해주세요.")
            userPw.focus();
            return;
    }else{
        
        if(userPw.value != pwCheck.value){
            alert("비밀번호가 일치하지 않습니다.")
            e.preventDefault();
            return;
        }
    }

    })


</script>


</body>
</html>