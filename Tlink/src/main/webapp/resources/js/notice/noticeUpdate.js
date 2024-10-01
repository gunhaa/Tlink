 
const noticeUpdateFile = document.getElementById('noticeUpdateFile');
const noticeCancelFile = document.getElementById('noticeCancelFile');
const existingFile = document.getElementById('existingFile');
const deleteFileBtn = document.getElementById('deleteFileBtn');

function hidden(){
    noticeUpdateFile.style.display = 'none'
    noticeCancelFile.style.display = 'none'
}

function block(){
    noticeUpdateFile.style.display = 'block'
    noticeCancelFile.style.display = 'block'
}

function convertBrToNewline(text) {
    return text.replace(/<br\s*\/?>/gi, "\n");  // 정규 표현식으로 <br> 태그를 \n으로 변환
}

document.addEventListener("DOMContentLoaded", function () {
    const addImageButton = document.getElementById('addImageButton');
    const imagesContainer = document.getElementById('imagesContainer');
    const updateBtn = document.getElementById('updateBtn');
    const titleInput = document.querySelector('input[name="noticeTitle"]');
    const contentTextarea = document.querySelector('textarea[name="noticeContent"]');
    const maxImages = 10;
    let imageCount = document.querySelectorAll('#imagesContainer .each-image-area').length; // 현재 이미지 수로 초기화
    console.log(imageCount)
    let deleteList = [];
    const deleteListInput = document.querySelector('input[name="deleteList"]');

    const noticeCancelFile = document.getElementById('noticeCancelFile');
    const noticeUpdateFile = document.getElementById('noticeUpdateFile');

    if (contentTextarea) {
        const originalContent = contentTextarea.value;
        const convertedContent = convertBrToNewline(originalContent);
        contentTextarea.value = convertedContent;
    }

    // 'X' 버튼 클릭 시 파일 입력 초기화
    if(noticeCancelFile != null){
        noticeCancelFile.addEventListener('click', function () {
            noticeUpdateFile.value = ""; // 파일 입력 초기화
            const previewImg = noticeUpdateFile.previousElementSibling.querySelector('img');
            if (previewImg) {
                previewImg.removeAttribute("src"); // 미리보기 이미지 삭제
            }
        });
    }

    if(deleteFileBtn != null){
        hidden()
        deleteFileBtn.addEventListener('click', function(){
            const fileOrder = existingFile.querySelector('.fileOrder').value;
            existingFile.style.display='none'
            block()
            deleteList.push(fileOrder);
            deleteListInput.value = deleteList.join(',');
        })
    }

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

        if (e.target.classList.contains('delete-image') || e.target.classList.contains('fa-trash-can')) {
            const eachImageArea = e.target.closest('.each-image-area');
            const fileOrder = eachImageArea.querySelector('.fileOrder').value;

            // 삭제할 fileOrder를 deleteList 배열에 추가
            deleteList.push(fileOrder);

            // deleteListInput에 값 반영 (쉼표로 구분된 string 형식으로 변환)
            deleteListInput.value = deleteList.join(',');

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

    const initialInputImages = document.querySelectorAll('#imagesContainer .inputImage');
    initialInputImages.forEach(inputImage => {
        inputImage.addEventListener('change', function (event) {
            previewImage(event.target);
        });
    });

    // 폼 제출 시 제목, 내용, 파일 선택 여부 검사
    updateBtn.addEventListener('click', function (event) {
        const inputFiles = imagesContainer.querySelectorAll('input[type="file"]');
        let allFilesSelected = true;
        let titleValid = true;
        let contentValid = true;
        
        // 기존에 등록된 파일이 있는지 확인
        const existingFiles = document.querySelectorAll('#imagesContainer .each-image-area img');
        
        // 파일이 없더라도 기존 파일이 있으면 통과
        if (existingFiles.length > 0) {
            // 기존 파일이 있을 때, 파일을 선택하지 않으면 삭제
            let isFileSelected = false;
            inputFiles.forEach(input => {
                if (input.files.length > 0) {
                    isFileSelected = true; // 파일이 선택된 경우
                }
            });
            
            if (!isFileSelected) {
                // 파일이 선택되지 않은 경우 기존 파일 삭제 로직
                const existingFilesHidden = document.querySelectorAll('input[name="existingFiles"]');
                existingFilesHidden.forEach(hiddenInput => {
                    hiddenInput.remove(); // 기존 파일 정보 삭제
                });
            }
        } else {
            // 기존 파일이 없으면 선택 여부 체크
            inputFiles.forEach(input => {
                if (!input.files.length) {
                    allFilesSelected = false;
                }
            });
        }
    
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
            alert('게시글이 수정되었습니다.')
            updateBtn.setAttribute('type', 'submit');
        } else {
            updateBtn.setAttribute('type', 'button');
        }
    });
    

});


