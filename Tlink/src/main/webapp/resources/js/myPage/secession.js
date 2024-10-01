document.addEventListener("DOMContentLoaded", () => {
    const secessionFrm = document.getElementById("secessionFrm");
    const inputPw = document.getElementById("inputPw");
    const agree = document.getElementById("agree");

    if (secessionFrm) {
        secessionFrm.addEventListener("submit", e => {
            // 비밀번호 체크
            if (inputPw.value.trim().length === 0) {
                alert("비밀번호를 입력해주세요.");
                inputPw.focus();
                e.preventDefault(); // 제출 방지
                return;
            }

            // 약관 동의 체크
            if (!agree.checked) {
                alert('약관에 동의해주세요.');
                e.preventDefault(); // 제출 방지
                return;
            }

            // 확인 대화상자
            if (!confirm("정말로 탈퇴하시겠습니까?")) {
                e.preventDefault(); // 제출 방지
                return;
            }
        });
    }
});
