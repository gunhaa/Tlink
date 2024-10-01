<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>





<c:forEach var="project" items="${projectList}">
  <c:if test="${project.projectNo==projectNo}">
     <c:set var="projectTitle" value="${project.projectTitle}"/>
     <c:set var="manager" value="${project.manager}"></c:set>
  </c:if>
</c:forEach>



<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>workspace</title>
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    
    <link rel="stylesheet" href="/resources/css/thread/threadUtil-style.css">


</head>

<body>
    <jsp:include page="/WEB-INF/views/thread/createModal.jsp"/>
    
    <aside class="aside">
        <div class="asideTop">
            <ul>
                <li>
                    <div>

                        <c:if test="${loginUser.profileImg==null}">
                            <a href="#"><img src="/resources/images/common/user.png"/></a>
                        </c:if>
                        <c:if test="${loginUser.profileImg!=null}">
                            <a href="#"><img src="${loginUser.profileImg}"/></a>
                        </c:if>
                    </div>
                </li>
                <li>
					<p style="font-size:24px; font-weight:400; margin-left:15px;">${projectTitle}</p>
                </li>
            </ul>
        </div>
        <div id="aside">
            <div class="sort"
                style="width: 70px; display: flex; justify-content: space-between; flex-direction: column;">
                <div>
                    <ul style="list-style-type: none; padding: 0 0 0 0px; text-align: center; margin: 0;">
                        <li><a href="#tab1"><span class="material-symbols-outlined"
                                    style="font-size: 30px;">home</span></a></li>
                        <li><a href="#tab2">


                        <span class="material-symbols-outlined"
                                    style="font-size: 30px;">sms</span></a></li>
                        <li><a href="#tab3"><span class="material-symbols-outlined"
                                    style="font-size: 30px;">info</span></a></li>
                    </ul>
                </div>
                <div>
                    <ul style="list-style-type: none; padding: 0; text-align: center; margin: 0;">
                            <li><a href="/myPage/project"><span class="material-symbols-outlined"
                                        style="transform: rotate(180deg); font-size: 30px;">logout</span></a></li>
                    </ul>
                </div>
            </div>
            <div id="tab1">
                <ul>
                    <li><a href="/workList/gantChart?projectNo=${projectNo}" style="font-weight:400;">워크스페이스</a></li>
                    <li><a href="/todoList?projectNo=${projectNo}" style="font-weight:400;">해야할 일</a></li>
                    <li><a href="/calendar?projectNo=${projectNo}" style="font-weight:400;">캘린더</a></li>
                    <li><span id="btn_videoConference" style="color:white; cursor:pointer; font-size:18px; font-weight:300;">화상회의</span></li>
                </ul>
            </div>
            <div id="tab2">
                <ul style="">
                    <c:forEach var="thread" items="${threadInfo}">
                        <li><a href="/thread/thread?threadNo=${thread.threadNo}&projectNo=${projectNo}">${thread.threadTitle}</a></li>
                    </c:forEach>
                </ul>
                <button id="createThread"><span class="material-symbols-outlined">add</span></button>
            </div>
            <div id="tab3">
                <ul style="">
                    <li><a href="/project/member?projectNo=${projectNo}">멤버관리</a></li>
                    <li><a href="/project/secession?projectNo=${projectNo}">프로젝트 탈퇴</a></li>
                    <c:if test="${loginUser.userNo == manager}">
                        <li><a href="/project/delete?projectNo=${projectNo}">프로젝트 삭제</a></li>
                    </c:if>
                    <li></li>
                    <li></li>
                    <li></li>
                </ul>
            </div>
        </div>
    </aside>

    


</body>

    <c:if test="${!empty message}">
        
        <script>
            // EL/JSTL 구문이 먼저 해석되는데
            // 문자열의 경우 따옴표가 없는 상태이니 붙여줘야한다!!!
            alert('${message}');
            
        </script>

    </c:if>

</html>

<style>

	@font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 100;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Thin.otf) format('opentype');}
@font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 300;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Light.otf) format('opentype');}
@font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 400;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Regular.otf) format('opentype');}
@font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 500;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Medium.otf) format('opentype');}
@font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 700;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Bold.otf) format('opentype');}
@font-face {font-family: 'Noto Sans KR';font-style: normal;font-weight: 900;src: url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.woff2) format('woff2'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.woff) format('woff'),url(//fonts.gstatic.com/ea/notosanskr/v2/NotoSansKR-Black.otf) format('opentype');}

* {
    font-family: 'Noto Sans KR', sans-serif;
}
	
    * { box-sizing: border-box; }
    body{ margin: 0; }
    .aside {
        list-style: none;
        width: 350px;
    }

    .aside ul{
        margin: 0;
        padding: 0;
    }
    .asideTop div{
        overflow: hidden;
    }

    .asideTop img{
        width: auto;
        height: 70px;
    }

</style>

<script src="/resources/js/thread/newThread-modal.js"></script>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script>

    function cen() { return `display:flex; justify-content: center; align-items: center;`; } //중앙정렬 함수

    $('a').attr("style", `
               text-decoration: none; 
               color: white; 
    				font-size:18px;
    				font-weight:300;
            `);
    $(function () { $("#aside").tabs(); });



    $('#aside').attr("style", `
         background-color: #643BAB; 
         width:350px; 
         height:100vh;
    
         display:flex;
    
         `);


    //하단*좌측
    //클릭시 변경부분
    //********************************************************************
    $('.sort').children().eq(0).find("a").on("click", function () {
        
        $('.sort').find("li").removeAttr("style");
        $('.sort').find("li").attr("style", `
                padding: 10px;
                width: 70px;
                height: 70px;
                `
            + cen()
        );
        $(this).parent("li").attr("style", `
                background-color: rgba(255, 255, 255, 0.1);
                border-radius: 10% 0 0 10%;
                padding: 10px;
                filter: drop-shadow(0 0 3px white);
    
                width: 70px;
                height: 70px;
                `
            + cen()
        );

    })
    //********************************************************************







    $('.sort').find("li").attr("style", `
            padding: 10px;
            width: 70px;
            height: 70px;
            `
        + cen()
    );
    

    $('.sort').find("li").eq(0).attr("style",
        $('.sort').find("li").eq(0).attr(`style`) +
        `
            background-color: rgba(255, 255, 255, 0.1);
            border-radius: 10% 0 0 10%;
            padding: 10px;
            filter: drop-shadow(0 0 3px white);
            width: 70px;
            height: 70px;
            `
        + cen()
    );








    //하단*우측
    $('.sort').siblings().attr("style", `
         width:280px; 
         color: black; 
         background-color: rgba(255, 255, 255, 0.1);
         border-radius: 0 10px 10px 10px;
         margin: 0px 30px 0 0;   
         font-size: 14px; 
         filter: drop-shadow(0 0 0.3px white);
         height:98vh;
         `
    );

    $('.sort').siblings().find("ul").attr("style", `list-style-type: none; padding: 0 0 0 10px;`);
    $('.sort').siblings().find("li").attr("style" , `margin: 15px; margin-bottom: 45px; font-size:16px;`);

    $(`.asideTop`).attr("style", `
            height:70px;
            width: 350px;
            background-color:#643BAB;
        `)
    $(`.asideTop ul`).attr(`style`, `display:flex;`);
    $(`.asideTop li`).attr(`style`, `
        width:70px;
        height: 70px;
        `
        + cen()
    );
    $(`.asideTop li`).eq(1).attr(`style`,
        $(`.asideTop li`).eq(1).attr(`style`)
        + `
            color:white;
            min-width: 200px;
            `
        + cen()
    );
    $(`.asideTop div`).attr(`style`, `
            width:  50px;
            height: 50px;
            
            border-radius:100%;
            background-color:#ddd;
            `
        + cen()
    );




</script>

<script>
const btn = document.querySelector("#btn_videoConference");
const profileImg_1 = "${loginUser.profileImg}";
const memberNo_1 = "${loginUser.userNo}";
const memberName_1 = "${loginUser.userName}"
let projectNo_1 = new URLSearchParams(location.search).get("projectNo");
let popup;
if (btn) {

    btn.addEventListener("click", e => {


        fetch("/video/selectTitle", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                "projectNo": projectNo_1
            })
        })
            .then((resp) => resp.text())
            .then(data => {
                let uriMemberName = `\${memberName_1}`;
                let encodeURIMemberName = encodeURIComponent(uriMemberName);
                console.log(encodeURIMemberName);
                console.log("적용됨");

                let uri = `/resources/popup/popup.jsp?memberNo=\${memberNo_1}&projectNo=\${projectNo_1}&memberName=\${encodeURIMemberName}`;

                popup = window.open(uri, "VideoConference", "width=920,height=830");
                popup.onload = () => {
                    // console.log(data);
                    console.log(popup.document.querySelector("#title-container"));
                    popup.document.querySelector("#title-container").innerHTML = `<b>\${data}</b>`;

                    fetch("/video/selectChat", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json",
                        },
                        body: JSON.stringify({
                            "projectNo": projectNo_1
                        })
                    })
                        .then(resp => resp.json())
                        .then(data => {

                            
                            data.forEach((item) => {
                                // console.log("each 실행중 : ", item);

                                const content = makeChatBlock(item.chatUserName, item.chatContent, item.chatTimestamp , item.chatProfileImg);
                                // console.log(content);
                                popup.postMessage({"type" : "popup", "profileImg" : profileImg_1}, "*");

                                popup.document.querySelector(".chat-itembox").insertAdjacentHTML("beforeend", content);
                            });

                            const chatBox =  popup.document.querySelector(".chat-itembox");
                            chatBox.scrollTop = chatBox.scrollHeight;
                            // console.log("chatBox 가 받아와짐? : ", chatBox);
                        })
                        .catch(e => {
                            console.log("chat 리스트 받아오는중 오류 발생 : ", e)
                        })
                };
            })



    })

}

const makeChatBlock = (chatUserName, chatContent, chatTimestamp, chatProfileImg) => {

    if(chatProfileImg==null){
        chatProfileImg="/resources/images/common/user.png";
    }

    return `<div class="chat-block">
            <span class="today">@\${chatTimestamp}</span>
            <div class="chat-item">
                <img src="\${chatProfileImg}" class="chat-prof-img">
                <div class="chat-id">\${chatUserName}</div>
                <div class="chat-content">\${chatContent}</div>
            </div>
        </div>`
}

</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
<script>

   


</script>