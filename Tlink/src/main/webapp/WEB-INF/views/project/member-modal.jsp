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
            <form action="/sendEmail/invite" method="post" id="inviteFrm">
                <input type="hidden" name="projectNo" value="${param.projectNo}">
                <div class="modal1">
                    <div class="modal_popup">
                        <h3 style="margin-bottom: 20px;">멤버 초대</h3>
                        <div class="modal-row">
                            <span class="input-title">이메일</span><input type="text" name="userEmail" id="userEmail">
                        </div>
                        <div class="btn-area">
                            <button type="button" class="close-btn">닫기</button>
                            <button class="submit-btn">초대</button>
                        </div>
                    </div>
                </div>
            </form>

            <script>
                const modal1 = document.querySelector('.modal1');
                const modalOpen = document.querySelector('.modal-btn');
                const modalClose = document.querySelector('.close-btn');

                //열기 버튼을 눌렀을 때 모달팝업이 열림
                modalOpen.addEventListener('click', function () {
                    //'on' class 추가
                    modal1.classList.add('on');
                });
                //닫기 버튼을 눌렀을 때 모달팝업이 닫힘
                modalClose.addEventListener('click', function () {
                    //'on' class 제거
                    modal1.classList.remove('on');
                });

                document.getElementById("inviteFrm").addEventListener("submit",e=>{
                    const userEmail = document.getElementById("userEmail");
                    
                    if(userEmail.value.trim().length == 0){
                        alert("이메일을 입력해주세요.");
                        userEmail.focus()
                        e.preventDefault();
                        return;
                    }
                })
                
            </script>



        </body>

        </html>