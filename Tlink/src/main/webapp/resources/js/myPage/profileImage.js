const inputProfile = document.getElementById("inputProfile");

inputProfile.addEventListener("change", () => {
    // inputProfile의 files 속성에 직접 접근
    const file =inputProfile.files[0];

    if (file != undefined) {
        const reader = new FileReader();

        // FileReader로 파일을 Data URL로 읽기
        reader.readAsDataURL(file);

        // 파일 읽기가 완료되면 이미지 소스를 업데이트
        reader.onload = function (e) {
            const image = document.getElementById("image");
            image.setAttribute("src", e.target.result);
        }

        const formData = new FormData();
        formData.append('profileImage', file);

        fetch('/myPage/profileImage', {
            method: 'POST',
            body: formData
        })
        .then(response => response.text())
        .then(result => {
            if(result > 0){
                alert("프로필 이미지가 변경되었습니다.");
            }else{
                alert("프로필 이미지 변경 실패");
            }
        })
        .catch(error => {
            console.error('Error:', error);
        });
    }
});

// 프로필 이미지 옆 X버튼 클릭 시
document.getElementById("delete-image").addEventListener("click", function(){

    fetch('/myPage/profileImage')
    .then(response => response.text())
    .then(result => {
        if(result > 0){
            // 프로필 이미지를 기본 이미지로 변경
            document.getElementById("image").setAttribute("src","/resources/images/common/user.png");
            alert("프로필 이미지가 삭제되었습니다.");
        }else{
            alert("프로필 이미지 삭제 실패");
        }
    })
    .catch(error => {
        console.error('Error:', error);
    });



})