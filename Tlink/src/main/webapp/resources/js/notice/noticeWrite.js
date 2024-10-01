document.addEventListener("DOMContentLoaded", function () {
    const addImageButton = document.getElementById('addImageButton');
    const imagesContainer = document.getElementById('imagesContainer');
    const insertBtn = document.getElementById('insertBtn');
    const titleInput = document.querySelector('input[name="noticeTitle"]');
    const contentTextarea = document.querySelector('textarea[name="noticeContent"]');
    const maxImages = 10;
    let imageCount = 1; // img1로 초기화

    const noticeCancelFile = document.getElementById('noticeCancelFile');
    const noticeUpdateFile = document.getElementById('noticeUpdateFile');

    // 'X' 버튼 클릭 시 파일 입력 초기화
    noticeCancelFile.addEventListener('click', function () {
        noticeUpdateFile.value = ""; // 파일 입력 초기화
        const previewImg = noticeUpdateFile.previousElementSibling.querySelector('img');
        if (previewImg) {
            previewImg.removeAttribute("src"); // 미리보기 이미지 삭제
        }
    });

    // 이미지 영역 추가
    addImageButton.addEventListener('click', function () {
        if (imageCount >= maxImages) {
            alert('최대 10개의 이미지 영역을 추가할 수 있습니다.');
            return;
        }

        imageCount++;
        const newImageArea = document.createElement('div');
        newImageArea.classList.add('each-image-area');
        const newId = `img${imageCount}`;

        newImageArea.innerHTML = `
            <div class="images-area">
                <label for="${newId}">
                    <img class="preview"> 
                </label>
                <input type="file" name="images" class="inputImage" id="${newId}" accept="image/*">
                <span class="delete-image">&times;</span>
            </div>
            <div>
                <i class="fa-solid fa-trash-can"></i>
            </div>
        `;

        imagesContainer.appendChild(newImageArea);

        addImageButton.scrollIntoView({ behavior: 'smooth', block: 'end' });

        const inputImage = newImageArea.querySelector('.inputImage');
        inputImage.addEventListener('change', function (e) {
            previewImage(e.target);
        });
    });

    imagesContainer.addEventListener('click', function (e) {
        if (e.target.classList.contains('delete-image')) {
            const input = e.target.previousElementSibling;
            input.value = ""; // 파일 입력 초기화
            const img = e.target.parentElement.querySelector('img');
            img.removeAttribute("src"); // 미리보기 이미지 삭제
        }

        if (e.target.classList.contains('fa-trash-can')) {
            const eachImageArea = e.target.closest('.each-image-area');
            if (eachImageArea) {
                imagesContainer.removeChild(eachImageArea);
                imageCount--;
            }
        }
    });

    const previewImage = (inputElement) => {
        const file = inputElement.files[0];
        const preview = inputElement.previousElementSibling.querySelector('img');

        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.setAttribute("src", e.target.result);
            };
            reader.readAsDataURL(file);
        } else {
            preview.removeAttribute("src");
        }
    };

    const initialInputImage = document.getElementById('img1');
    initialInputImage.addEventListener('change', function (event) {
        previewImage(event.target);
    });

    // 폼 제출 시 제목, 내용, 파일 선택 여부 검사
    insertBtn.addEventListener('click', function (event) {
        const inputFiles = imagesContainer.querySelectorAll('input[type="file"]');
        let allFilesSelected = true;
        let titleValid = true;
        let contentValid = true;

        // 각 input[type="file"] 요소가 파일을 선택했는지 확인
        inputFiles.forEach(input => {
            if (!input.files.length) {
                allFilesSelected = false;
            }
        });

        // 제목 확인
        if (!titleInput.value.trim()) {
            titleValid = false;
            alert('제목을 입력해주세요');
            titleInput.focus();
            event.preventDefault();
            return;
        }

        // 내용 확인
        if (!contentTextarea.value.trim()) {
            contentValid = false;
            alert('내용을 입력해주세요');
            contentTextarea.focus();
            event.preventDefault();
            return;
        }

        if (!allFilesSelected) {
            alert('게시글 이미지를 추가 또는 영역을 삭제해주세요');
            event.preventDefault();
        }

        // 모든 조건을 만족하면 제출 허용
        if (titleValid && contentValid && allFilesSelected) {
            alert('게시글이 등록되었습니다.')
            insertBtn.setAttribute('type', 'submit');
        } else {
            insertBtn.setAttribute('type', 'button');
        }
    });
});
