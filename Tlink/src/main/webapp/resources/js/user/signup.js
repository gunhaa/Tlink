// 회원 가입 JS
/* 정규 표현식(Regular Expression)
    https://regexper.com/
    https://regexr.com/
    https://developer.mozilla.org/ko/docs/Web/JavaScript/Guide/%EC%A0%95%EA%B7%9C%EC%8B%9D

    - 특정한 규칙을 가진 문자열 집합을 표현하는데 사용하는 형식 언어
    - 문자열에 대한 검색, 일치 여부, 치환 등을 수행할 수 있음


    *** JS 정규표현식 객체 생성 방법 ***

    1.  const regEx = new RegExp("정규표현식");
    2.  const regEx = /정규표현식/;


    *** 정규표현식 객체가 제공하는 메서드(함수) ***
    1.  regEx.test(문자열)
        -> 문자열이 정규표현식 패턴에 부합하면 true, 아니면 false

    2.  regEx.exec(문자열)
        -> 문자열이 정규표현식 패턴에 부합하면
            첫 번째 매칭되는 문자열을 반환,
            없으면 null 반환


     *** 정규 표현식의 메타 문자***
        
    문자열의 패턴을 나타내는 문자.
    문자마다 지정된 특별한 뜻이 담겨있다.
    
    a (일반문자열) : 문자열 내에 a라는 문자열이 존재하는 검색 
    [abcd] : 문자열 내에 a,b,c,d 중 하나라도 일치하는 문자가 있는지 검색
    ^(캐럿) : 문자열의 시작을 의미
    $(달러) : 문자열의 끝을 의미

    \w (word, 단어) : 아무 글자(단, 띄어쓰기, 특수문자, 한글 X)
    \d (digit, 숫자) : 아무 숫자(0~9 중 하나)
    \s (space, 공간) : 아무 공백 문자(띄어쓰기, 엔터, 탭 등)

    [0-9]  : 0부터 9까지 모든 숫자
    [ㄱ-힣] : ㄱ부터 힣까지  모든 한글

    [가-힣] : 가부터 힣까지  모든 한글(자음만, 모음만 있는 경우 제외)

    [a-z] : 모든 영어 소문자
    [A-Z] : 모든 영어 대문자

    * 특수문자의 경우 각각을 입력하는 방법밖엔 없음
    단, 메타문자와 중복되는 특수문자는 
    앞에 \(백슬래시)를 추가하여 탈출 문자(Escape)로 만들어 사용

    * 수량 관련 메타 문자
    a{5} : a문자가 5개 존재 == aaaaa
    a{2,5} : a가 2개 이상 5개 이하 ==  aa, aaa, aaaa, aaaaa
    a{2,} : a가 2개 이상
    a{,5} : a가 5개 이하


    * : 0개 이상 == 0번 이상 반복 == 있어도되고, 없어도 되고

    + : 1개 이상 == 1번 이상 반복

    ? : 0개 또는 1개

    . : 1칸 (개행문자를 제외한 문자 하나)
*/

// JS 객체 : { "K" : V, "K" : V }

// 특징
// 1) 원하는 value를 얻어오는 방법
//    - 객체명.key
//    - 객체명[key]

// 2) 객체에 특정 key가 존재하지 않을 때 추가
// ex) const obj = {"a" : 1, "b" : 2}
//     obj.c = 3; // {"a" : 1, "b" : 2, "c" : 3}

// 3) 객체의 특정 key 삭제하기 (delete 연산자)
// ex) const obj = {"a" : 1, "b" : 2}
//     delete obj.b; // {"a" : 1}


/* 유효성 검사 진행 여부를 위한 확인용 객체 -> 모든 value가 true인 경우에만 회원가입 진행 */
const checkObj = {
    "userEmail": false,
    "userPw": false,
    "pwCheck": false,
    "userName": false,
    "userPhone": false,
    "authKey" : false
    
}

// 이메일 유효성 검사
const userEmail = document.getElementById("userEmail");

// 이메일이 입력될 때마다
userEmail.addEventListener("input", () => {

    // 입력된 이메일이 없을 경우
    if (userEmail.value.trim().length == 0) {
        userEmail.value = "";
        checkObj.userEmail = false;
        return;
    }

    // 정규 표현식을 이용해서 유효한 형식인지 판별
    // 1) 정규표현식 객체 생성
    const regEx = /^[\w\-\_]{4,}@[a-z]+(\.\w+){1,3}$/;

    // 2) 입력 받은 이메일과 정규식 일치 여부 판별
    if (regEx.test(userEmail.value)) {

        /* *********************************************************** */
        /* fetch() API 이용한 비동기 통신 */

        // GET 방식 ajax 요청 (파라미터는 쿼리스트링으로 전달)
        fetch("/selectDupEmail?email="+userEmail.value)

        .then(resp => resp.text()) // 응답객체 -> 파싱(parsing, 데이터 형태 변환)

        .then(count => {

            if(count == 0){
                userEmail.classList.add("confirm");
                userEmail.classList.remove("error");
                checkObj.userEmail = true;
            }else{
                userEmail.classList.add("error");
                userEmail.classList.remove("confirm");
                checkObj.userEmail = false;
            }
        }) 

        .catch(e=>{console.log(e)})

        /* *********************************************************** */


    } else {
        // 유효하지 않은 경우 : "유효하지 않은 이메일 형식입니다." 빨강
        userEmail.classList.add("error");
        userEmail.classList.remove("confirm");
        checkObj.userEmail = false;
    }

})

// 비밀번호 유효성 검사
const userPw = document.getElementById("userPw");

userPw.addEventListener("input", () => {

    if (userPw.value.trim().length == 0) {
        userPw.classList.remove("error", "confirm");
        userPw.value = "";
        checkObj.userPw = false;
        return;
    }

    const regEx = /^[A-Za-z0-9!@#_-]{6,20}$/;

    if (regEx.test(userPw.value)) {
        checkObj.userPw = true;

        // 비밀번호가 유효하게 작성된 상태에서 
        // 비밀번호 확인이 입력되지 않았을 때
        if (pwCheck.value.trim().length == 0) {
            checkObj.pwCheck = false;
        } else {
            // 비밀번호가 유효하게 작성된 상태에서
            // 비밀번호 확인이 입력된 경우
            // 비밀번호 == 비밀번호 확인
            if (userPw.value == pwCheck.value) {
                checkObj.pwCheck = true;
            } else {
                checkObj.pwCheck = false;
            }
        }

    } else {
        checkObj.userPw = false;
    }
})

// 비밀번호 확인
const pwCheck = document.getElementById("pwCheck");

pwCheck.addEventListener("input", () => {

    if (checkObj.userPw) { // 비밀번호가 유효하게 작성된 경우

        // 비밀번호 == 비밀번호 확인
        if (userPw.value == pwCheck.value) {
            checkObj.pwCheck = true;
        } else {
            checkObj.pwCheck = false;
        }

    } else { // 비밀번호가 유효하지 않은 경우
        checkObj.pwCheck = false;
    }

})

// 닉네임 유효성 확인
const userName = document.getElementById("userName");

userName.addEventListener("input", () => {

    if (userName.value.trim().length == 0) {
        userName.value = "";
        checkObj.userName = false;
        return;
    }

    const regEx = /^[가-힣A-Za-z0-9]{2,10}$/;

    if (regEx.test(userName.value)) {

        userName.classList.add("confirm");
        userName.classList.remove("error");
        checkObj.userName = true;

    } else {
        userName.classList.add("error");
        userName.classList.remove("confirm");
        checkObj.userName = false;
    }
})

// 전화번호 유효성 확인
const userPhone = document.getElementById("userPhone");

userPhone.addEventListener("input", () => {

    if (userPhone.value.trim().length == 0) {
        userPhone.value = "";
        checkObj.userPhone = false;
        return;
    }

    const regEx = /^0(1[079]|2|[3-6][1-5]|70)\d{3,4}\d{4}$/;

    if (regEx.test(userPhone.value)) {
        userPhone.classList.add("confirm");
        userPhone.classList.remove("error");
        checkObj.userPhone = true;
    } else {
        userPhone.classList.add("error");
        userPhone.classList.remove("confirm");
        checkObj.userPhone = false;
    }
})

// -------------------------- 이메일 인증 --------------------------
// 인증번호 발송
const sendAuthKeyBtn = document.getElementById("sendAuthKeyBtn");
const authKeyMessage = document.getElementById("authKeyMessage");
let authTimer;
let authMin = 4;
let authSec = 59;


// 인증번호를 발송한 이메일 저장
let tempEmail;


sendAuthKeyBtn.addEventListener("click", function(){
    authMin = 4;
    authSec = 59;
    
    checkObj.authKey = false;


    if(checkObj.userEmail){ // 중복이 아닌 이메일인 경우


        /* fetch() API 방식 ajax */
        fetch("/sendEmail/signUp?email="+userEmail.value)
        .then(resp => resp.text())
        .then(result => {
            if(result > 0){
                console.log("인증 번호가 발송되었습니다.")
                tempEmail = userEmail.value;
            }else{
                console.log("인증번호 발송 실패")
            }
        })
        .catch(err => {
            console.log("이메일 발송 중 에러 발생");
            console.log(err);
        });
       


        alert("인증번호가 발송 되었습니다.");


       
        authKeyMessage.innerText = "05:00";
        authKeyMessage.classList.remove("confirm");

        clearInterval(authTimer);

        authTimer = window.setInterval(()=>{


            authKeyMessage.innerText = "0" + authMin + ":" + (authSec<10 ? "0" + authSec : authSec);
           
            // 남은 시간이 0분 0초인 경우
            if(authMin == 0 && authSec == 0){
                checkObj.authKey = false;
                clearInterval(authTimer);
                return;
            }


            // 0초인 경우
            if(authSec == 0){
                authSec = 60;
                authMin--;
            }


            authSec--; // 1초 감소


        }, 1000)


    } else{
        alert("중복되지 않은 이메일을 작성해주세요.");
        userEmail.focus();
    }

});

// 인증 확인
const authKey = document.getElementById("authKey");
const checkAuthKeyBtn = document.getElementById("checkAuthKeyBtn");

checkAuthKeyBtn.addEventListener("click", function(){


    if(authMin > 0 || authSec > 0){ // 시간 제한이 지나지 않은 경우에만 인증번호 검사 진행
        /* fetch API */
        const obj = {"inputKey":authKey.value, "email":tempEmail}
        const query = new URLSearchParams(obj).toString()
        
        fetch("/sendEmail/checkAuthKey?" + query)
        .then(resp => resp.text())
        .then(result => {
            if(result > 0){
                clearInterval(authTimer);
                authKeyMessage.innerText = "인증되었습니다.";
                authKeyMessage.classList.add("confirm");
                checkObj.authKey = true;


            } else{
                alert("인증번호가 일치하지 않습니다.")
                checkObj.authKey = false;
            }
        })
        .catch(err => console.log(err));

    } else{
        alert("인증 시간이 만료되었습니다. 다시 시도해주세요.")
    }

});


// form 태그 제출 시
document.getElementById("signUpFrm").addEventListener("submit", e => {

    // checkObj에 모든 value가 true인지 검사

    // 배열용 for문 of
    // 배열용 for문 in

    for(let key in checkObj){
        if(!checkObj[key]){ // 유효하지 않은 경우

            switch(key){
                case "userEmail" : alert("이메일이 유효하지 않습니다"); break;
                case "userPw" : alert("비밀번호가 유효하지 않습니다"); break;
                case "pwCheck" : alert("비밀번호 확인이 유효하지 않습니다"); break;
                case "userName" : alert("닉네임이 유효하지 않습니다"); break;
                case "userPhone" : alert("전화번호가 유효하지 않습니다"); break;
                case "authKey" : alert("인증번호가 유효하지 않습니다"); break;
            }
            // 유효하지 않은 input 태그로 focus 이동
            document.getElementById(key).focus();

            // form태그 기본 이벤트 제거
            e.preventDefault();
            return;
        }
    }
})

