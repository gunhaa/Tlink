<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>

    <script>
        const req = "<%=request.getContextPath()%>";
    </script>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>화상회의</title>

    <script src="https://kit.fontawesome.com/4bef400c33.js" crossorigin="anonymous"></script>
    <style>
/* @keyframes fadeInDown {
  0% {
    opacity: 0;
    transform: translate3d(0, -100%, 0);
  }
  100% {
    opacity: 1;
    transform: translateZ(0);
  }
}

@keyframes fadeOut {
  0% {
    opacity: 1;
  }
  100% {
    opacity: 0;
  }
} */
</style>
</head>
<body>
<head>

</head>
<body>
    <main>

        <input id="memberNo" placeholder="memberNo 입력">
        <input id="roomNo" placeholder="projectNo 입력">
        <button id="btn_videoConference">입장</button>
        <button id="btn2">모달 테스트</button>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
        <script src="<%=request.getContextPath()%>/resources/js/videoConference/videoConference.js" crossorigin="anonymous"></script>
	</main>
	
</body>
</html>