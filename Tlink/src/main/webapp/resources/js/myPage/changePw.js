document.getElementById("changePwBtn").addEventListener("click", ()=>{
    const currentPw =  document.getElementById("currentPw");
    const newPw =  document.getElementById("newPw");
    const pwCheck =  document.getElementById("pwCheck");

    if(newPw.value == pwCheck.value){
        fetch("/myPage/changePw", {
            method : "POST",
            headers : {"Content-Type" : "application/json"},
            body : JSON.stringify({
                "currentPw" : currentPw.value,
                "newPw" : newPw.value
            })
            // JSON.stringify : JS객체 -> JSON
            // JSON.parse()   : JSON -> JS객체
        })
    
        .then(response => response.text()) // 응답 객체를 매개변수로 얻어와 파싱
    
        .then(result => {
            
            console.log(result)

            if(result > 0){
                alert("비밀번호가 변경되었습니다.")
                currentPw.value = "";
                newPw.value = "";
                pwCheck.value = "";
            }else{
                alert("현재 비밀번호가 일치하지 않습니다.")
            }
    
        })
    
        .catch(e=>{
            console.log(e)
        })
    }else{
        alert("새 비밀번호가 일치하지 않습니다.")
    }
})