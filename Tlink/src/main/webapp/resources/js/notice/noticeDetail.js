
document.addEventListener('copy', function (event) {
    if (noticeCopy == 2) {
        event.preventDefault(); // 복사 차단
        alert('해당 게시물에서는 복사 기능이 차단되었습니다.');
    } else if (noticeCopy == 1){
        const selectedText = window.getSelection().toString(); // 선택된 텍스트 가져오기
        if (selectedText.length >= 1) { // 10자 이상일 때만 출처 추가
            const url = window.location.href; // 현재 페이지 URL 가져오기
            const additionalText = `\n\n출처: ${url}`; // 추가할 출처 텍스트
            // 기본 복사 동작을 방지
            event.preventDefault();
            // 클립보드에 출처 추가된 내용 설정
            event.clipboardData.setData('text/plain', selectedText + additionalText);
        }
    }
})

function confirmDelete() {
    const userConfirmed = confirm('정말로 삭제하시겠습니까?');
    if (userConfirmed) {
        window.location.href = `/notice2/${noticeNo}/delete`; // 삭제 요청 URL로 이동
        alert('게시글이 삭제되었습니다.')
    }
}
