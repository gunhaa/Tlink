<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage/myPage.css">
    <script src="${pageContext.request.contextPath}/resources/js/myPage/info.js" defer></script>
</head>

<body>

    <main>

        <section class="container">
        	<jsp:include page="/WEB-INF/views/myPage/sideMenu.jsp"/>
            <!-- 우측 -->
            <div class="content">
                <form action="info" id="infoFrm" method="post">
                    <div class="title">내 정보</div>

                    <!-- 상단 카드 -->
                    <div class="card">
                        <div class="card-row">
                            <div class="row-title">이름</div>
                            <div class="row-content" class="cursor-df">${loginUser.userName}</div>
                        </div>
                        <div class="card-row">
                            <div class="row-title">이메일</div>
                            <div class="row-content">${loginUser.userEmail}</div>
                        </div>
                        <div class="card-row">
                            <div class="row-title">가입일</div>
                            <div class="row-content">${loginUser.enrollDate}</div>
                        </div>
                    </div>
                    <!-- 하단 카드 -->
                    <div class="card">
                        <div class="card-row">
                            <div class="row-title">전화번호</div>
                            <div class="row-content">
                                <input type="text" name="userPhone" value="${loginUser.userPhone}" id="userPhone">
                            </div>
                        </div>
                        <div class="card-row">
                            <c:set var="addr" value="${fn:split(loginUser.userAddr, '^^^') }" />

                            <div class="row-title">우편번호</div>
                            <div class="row-content">
                                <input type="text" name="userAddr" value="${addr[0]}" id="sample6_postcode">
                                <button type="button" onclick="sample6_execDaumPostcode()">검색</button>
                            </div>
                        </div>
                        <div class="card-row">
                            <div class="row-title">주소</div>
                            <div class="row-content">
                                <input type="text" name="userAddr" value="${addr[1]}" id="sample6_address">
                            </div>
                        </div>
                        <div class="card-row">
                            <div class="row-title">상세주소</div>
                            <div class="row-content">
                                <input type="text" name="userAddr" value="${addr[2]}" id="sample6_detailAddress">
                            </div>
                        </div>
                    </div>

                    <div class="btn-area">
                        <button>저장</button>
                    </div>
                </form>
            </div>
        </section>
    </main>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function sample6_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('sample6_postcode').value = data.zonecode;
                    document.getElementById("sample6_address").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("sample6_detailAddress").value = '';
                    document.getElementById("sample6_detailAddress").focus();
                }
            }).open();
        }
    </script>
</body>

</html>