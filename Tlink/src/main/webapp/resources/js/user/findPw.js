// -------------------------- 임시 비밀번호 전송 --------------------------
const sendPwBtn = document.getElementById("sendPwBtn");


sendPwBtn.addEventListener("click", function(){
    const userEmail = document.getElementById("userEmail");
    const userName = document.getElementById("userName");

        /* fetch() API 방식 ajax */
        fetch("/sendEmail/findPw?userEmail="+userEmail.value+"&userName="+userName.value)
        .then(resp => resp.text())
        .then(result => {
            if(result > 0){
                alert("임시 비밀번호가 전송되었습니다.")
                location.href="/login";
            }else{
                alert("일치하는 회원이 없습니다.")
            }
        })
        .catch(err => {
            console.log("이메일 발송 중 에러 발생");
            console.log(err);
        });


});