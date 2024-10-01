<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main/main.css">
    <title>TLink</title>
</head>
<body>
    <main>
        <section>
            <div class="main-logo"></div>
            <div class="btn-area">
                <button class="login-btn" onclick="location.href='/login'">로그인</button>
                <button class="signUp-btn" onclick="location.href='/signup'">회원가입</button>
            </div>
        </section>
    </main>

    <c:if test="${!empty message}">

        <script>
            // EL/JSTL 구문이 먼저 해석되는데
            // 문자열의 경우 따옴표가 없는 상태이니 붙여줘야한다!!!
            alert('${message}');
        </script>

    </c:if>
    
</body>
</html>