document.getElementById("infoFrm").addEventListener("submit", e => {
    const userPhone = document.getElementById("userPhone");

    // 전화번호 입력란이 비어 있는지 확인
    if (userPhone.value.trim().length === 0) {
        userPhone.value = ""; // 비어 있는 경우 값 초기화
        alert("전화번호를 입력해주세요."); // 오류 메시지 표시 (선택 사항)
        userPhone.focus(); // 입력란에 포커스 이동
        e.preventDefault(); // 폼 제출 방지
        return;
    }

    // 전화번호 형식에 대한 정규 표현식 정의
    const regEx = /^0(1[079]|2|[3-6][1-5]|70)\d{3,4}\d{4}$/;

    // 전화번호 형식이 올바른지 검증
    if (!regEx.test(userPhone.value.trim())) {
        userPhone.value = "";
        userPhone.focus(); // 입력란에 포커스 이동
        e.preventDefault(); // 폼 제출 방지
        alert("전화번호 형식이 올바르지 않습니다."); // 오류 메시지 표시 (선택 사항)
        return;
    }
});