<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage/myPage.css">
    <script src="${pageContext.request.contextPath}/resources/js/user/findPw.js" defer></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

</head>

<body>

    <main class="container2">
        <div class="small-logo" onclick="location.href='/'"></div>
        <section>
            <form action="">
                <div class="title">비밀번호 찾기</div>
                <div class="explanation">
                    임시 비밀번호를 메일로 보내드립니다.<br>
                    로그인 후 비밀번호 변경을 권장합니다.
                </div>
                <div class="card">
                    <div class="card-row">
                        <div class="row-title">이름</div>
                        <div class="row-content">
                            <input type="text" id="userName" placeholder="이름을 입력해주세요.">
                        </div>
                    </div>
                    <div class="card-row">
                        <div class="row-title">이메일</div>
                        <div class="row-content">
                            <input type="text" id="userEmail" placeholder="가입시 입력한 이메일을 입력해주세요.">
                            <button type="button" id="sendPwBtn">전송</button>
                        </div>
                    </div>

                </div>


            </form>
            <div class="btn-area">
                <button style="background-color: #ddd; color: grey;" onclick="location.href='/login'">취소</button>
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