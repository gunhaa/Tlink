// 댓글 목록 조회
// 댓글 수정 / 삭제 / 등록 시 해당 함수를 호출해 비동기식으로 목록 조회하기 위해 함수 생성
function selectCommentList() {
    fetch("/comment?noticeNo=" + noticeNo)
    .then(response => response.json())
    .then(cList => {
        console.log(cList);

        const commentList = document.getElementById("commentList");
        commentList.innerHTML = "";

        // 고정된 댓글과 일반 댓글을 분리
        const fixedComments = cList.filter(comment => comment.commentDeleteFlag == 3);
        const regularComments = cList.filter(comment => comment.commentDeleteFlag == 1 || comment.commentDeleteFlag == 3); // 고정된 댓글 포함

        // 고정된 댓글이 있는지 여부 확인
        const hasFixedComment = fixedComments.length > 0;

        // 고정된 댓글 렌더링 (상단에 위치)
        for (let comment of fixedComments) {
            const commentRow = createCommentRow(comment, true, hasFixedComment); // 고정 댓글
            commentRow.classList.remove("child-comment");
            commentList.append(commentRow);  // 고정 댓글은 상단 고정 영역에 출력
        }

        // 댓글 렌더링
        for (let comment of cList) {
            // 삭제된 댓글 처리
            if (comment.commentDeleteFlag == 2) {
                const deletedCommentRow = document.createElement("li");
                deletedCommentRow.classList.add("comment-row", "addcolor");
                deletedCommentRow.innerText = "삭제된 댓글입니다.";
                commentList.append(deletedCommentRow);
            } 
            // 고정된 댓글 및 일반 댓글 처리
            else {
                const isFixed = comment.commentDeleteFlag == 3;
                const commentRow = createCommentRow(comment, isFixed, hasFixedComment);
                commentList.append(commentRow);
            }
        }
    })
    .catch(err => console.log(err));
}



function createCommentRow(comment, isFixed, hasFixedComment) {
    const commentRow = document.createElement("li");
    commentRow.classList.add("comment-row");

    if (isFixed) {
        commentRow.classList.add("topComment"); // 고정된 댓글에 추가 스타일 적용
    }

    if (comment.parentNo != 0) commentRow.classList.add("child-comment");
    
    const commentWriter = document.createElement("div");
    commentWriter.classList.add("comment-writer");
    const profileImage = document.createElement("img");
    if (comment.role == 'U') {
        profileImage.setAttribute("src", comment.profileImage ? comment.profileImage : "/resources/images/common/user.png");
    }

    if (comment.role != 'U') {
        profileImage.setAttribute("src", "/resources/images/common/admin_profile.png");
    }

    const userName = document.createElement("span");
    userName.innerText = comment.userName;

    const commentDate = document.createElement("span");
    commentDate.classList.add("comment-date");
    commentDate.innerText = "(" + comment.commentCreateDate + ")";

    const buttonArea = document.createElement("div");
    if (loginUserRole != 'U') {
        // 고정된 댓글인 경우 해제 버튼만 표시
        if (isFixed) {
            const fixDisableBtn = document.createElement("button");
            fixDisableBtn.classList.add("fixBtn");
            fixDisableBtn.innerHTML = '<i class="fa-solid fa-thumbtack-slash"></i>';
            fixDisableBtn.setAttribute("onclick", `commentFixDisabled(${comment.commentNo}, this)`);
            buttonArea.append(fixDisableBtn);
        }
        // 고정된 댓글이 없을 경우에만 고정 버튼 출력
        else if (!hasFixedComment) {  
            const fixBtn = document.createElement("button");
            fixBtn.classList.add("fixBtn");
            fixBtn.innerHTML = '<i class="fa-solid fa-thumbtack"></i>';
            fixBtn.setAttribute("onclick", `commentFixd(${comment.commentNo}, this)`);
            buttonArea.append(fixBtn);
        }
    }

    commentWriter.append(profileImage, userName, commentDate, buttonArea);
    
    if (isFixed) {
        const fixText = document.createElement("span");
        fixText.classList.add("fixText");
        fixText.innerText = '관리자가 고정한 댓글입니다.';
        commentWriter.append(fixText); // 댓글 행에 고정된 텍스트 추가
    }

    const commentContent = document.createElement("p");
    commentContent.classList.add("comment-content");
    commentContent.innerHTML = comment.commentContent;

    commentRow.append(commentWriter, commentContent);
    
    const commentBtnArea = document.createElement("div");
    commentBtnArea.classList.add("comment-btn-area");
    // 현재 로그인한 유저가 있는 경우 버튼 추가
    if (loginUserNo == comment.userNo) {
        const childCommentBtn = document.createElement("button");
        childCommentBtn.setAttribute("onclick", `showInsertComment(${comment.commentNo}, this)`);
        childCommentBtn.innerText = "답글";

        const updateBtn = document.createElement("button");
        updateBtn.innerText = "수정";
        updateBtn.setAttribute("onclick", `showUpdateComment(${comment.commentNo}, this)`);

        const deleteBtn = document.createElement("button");
        deleteBtn.innerText = "삭제";
        deleteBtn.setAttribute("onclick", `deleteComment(${comment.commentNo})`);

        commentBtnArea.append(childCommentBtn, updateBtn, deleteBtn);
    }
    // 댓글 작성자와 로그인한 유저가 동일하지 않은 경우
    else {
        if (loginUserRole != 'U') {
            const childCommentBtn = document.createElement("button");
            childCommentBtn.setAttribute("onclick", `showInsertComment(${comment.commentNo}, this)`);
            childCommentBtn.innerText = "답글";

            const deleteBtn = document.createElement("button");
            deleteBtn.innerText = "삭제";
            deleteBtn.setAttribute("onclick", `deleteComment(${comment.commentNo})`);

            commentBtnArea.append(childCommentBtn, deleteBtn);
        }
    }

    commentRow.append(commentBtnArea);

    return commentRow;
}











//-------------------------------------------------------------------------------------------------

// 댓글 등록
const addComment = document.getElementById("addComment");
const commentContent = document.getElementById("commentContent");

if(addComment != null){

    addComment.addEventListener("click", e => { // 댓글 등록 버튼이 클릭이 되었을 때
    
        // 1) 로그인이 여부 판별(전역 변수 loginUserNo 이용)
        if(loginUserNo == ""){ // 로그인 X
            alert("로그인 후 이용해주세요.");
            return; // 로그인 X 이면 아래의 코드 실행할 필요 없음
        }
    
        // 2) 댓글 내용이 작성 여부 판별
        if(commentContent.value.trim().length == 0){ // 미작성인 경우
            alert("댓글을 작성한 후 버튼을 클릭해주세요.");
            commentContent.value = ""; // 띄어쓰기, 개행문자 제거
            commentContent.focus();
            return; // 로그인 X 이면 아래의 코드 실행할 필요 없음
        }
    
        // 3) AJAX를 이용해서 댓글 내용 DB에 저장(INSERT)
        const data = {"commentContent" : commentContent.value,
                      "userNo" : loginUserNo,
                      "noticeNo" : noticeNo
        };
    
        fetch("/comment", {
            method : "POST",
            headers : {"Content-Type" : "application/json"},
            body : JSON.stringify(data) // JS 객체 -> JSON 파싱
        })
        .then(resp => resp.text())
        .then(result => {
            if(result > 0){ // 등록 성공
                alert("댓글이 등록되었습니다.");
    
                commentContent.value = ""; // 작성했던 댓글 삭제
    
                selectCommentList(); // 비동기 댓글 목록 조회 함수 호출
                // -> 새로운 댓글이 추가되어짐
    
            } else { // 실패
                alert("댓글 등록에 실패했습니다...");
            }
        })
        .catch(err => console.log(err));
    });
}



// -----------------------------------------------------------------------------------
// 댓글 삭제
function deleteComment(commentNo){

    if( confirm("정말로 삭제 하시겠습니까?") ){

        fetch("/comment", {
            method : "DELETE",
            headers : {"Content-Type" : "application/json"},
            body : commentNo // 값 하나 전달 시에는 JSON 필요X
        })
        .then(resp => resp.text())
        .then(result => {
            if(result > 0){
                alert("삭제되었습니다");
                selectCommentList(); // 목록을 다시 조회해서 삭제된 글을 제거
            }else{
                alert("삭제 실패");
            }
        })
        .catch(err => console.log(err));

    }
}




// ------------------------------------------------------------------------------------------
// 댓글 수정 화면 전환 

let beforeCommentRow; // 수정 전 원래 행의 상태를 저장할 변수


function showUpdateComment(commentNo, btn){
                     // 댓글번호, 이벤트발생요소(수정버튼)

    // ** 댓글 수정이 한 개만 열릴 수 있도록 만들기 **
    // 댓글 수정을 위한 textarea를 모두 얻어옴 -> 수정이 활성화 되어 있을 경우 1개, 없으면 0개
    const temp = document.getElementsByClassName("update-textarea");  

    if(temp.length > 0){ // 수정이 한 개 이상 열려 있는 경우

        if(confirm("다른 댓글이 수정 중입니다. 현재 댓글을 수정 하시겠습니까?")){ // 확인

            temp[0].parentElement.innerHTML = beforeCommentRow;
            // comment-row                       // 백업한 댓글
            // 백업 내용으로 덮어 씌워 지면서 textarea 사라짐
       
        }else{ // 취소
            return;
        }
    }


    // 1. 댓글 수정이 클릭된 행을 선택
    const commentRow = btn.parentElement.parentElement; // 수정 버튼의 부모의 부모

    // 2. 행 내용 삭제 전 현재 상태를 저장(백업) (문자열)
    //    (전역변수 이용)
    beforeCommentRow = commentRow.innerHTML;


    // 3. 댓글에 작성되어 있던 내용만 얻어오기 -> 새롭게 생성된 textarea 추가될 예정
    
    let beforeContent = commentRow.children[1].innerHTML;

    // 이것도 가능!
    //let beforeContent = btn.parentElement.previousElementSibling.innerHTML;


    // 4. 댓글 행 내부 내용을 모두 삭제
    commentRow.innerHTML = "";

    // 5. textarea 요소 생성 + 클래스 추가  +  **내용 추가**
    const textarea = document.createElement("textarea");
    textarea.classList.add("update-textarea");

    // ******************************************
    // XSS 방지 처리 해제
    beforeContent =  beforeContent.replaceAll("&amp;", "&");
    beforeContent =  beforeContent.replaceAll("&lt;", "<");
    beforeContent =  beforeContent.replaceAll("&gt;", ">");
    beforeContent =  beforeContent.replaceAll("&quot;", "\"");
    
    // ******************************************
    textarea.value = beforeContent; // 내용 추가

    // 6. commentRow에 생성된 textarea 추가
    commentRow.append(textarea);


    // 7. 버튼 영역 + 수정/취소 버튼 생성
    const commentBtnArea = document.createElement("div");
    commentBtnArea.classList.add("comment-btn-area");
    

    const updateBtn = document.createElement("button");
    updateBtn.innerText = "수정";
    updateBtn.setAttribute("onclick", "updateComment("+commentNo+", this)");


    const cancelBtn = document.createElement("button");
    cancelBtn.innerText = "취소";
    cancelBtn.setAttribute("onclick", "updateCancel(this)");


    // 8. 버튼영역에 버튼 추가 후 
    //    commentRow(행)에 버튼영역 추가
    commentBtnArea.append(updateBtn, cancelBtn);
    commentRow.append(commentBtnArea);

}


// -----------------------------------------------------------------------------------
// 댓글 수정 취소
function updateCancel(btn){
    // 매개변수 btn : 클릭된 취소 버튼
    // 전역변수 beforeCommentRow : 수정 전 원래 행(댓글)을 저장한 변수

    if(confirm("댓글 수정을 취소하시겠습니까?")){
        btn.parentElement.parentElement.innerHTML = beforeCommentRow;
    }
}

// -----------------------------------------------------------------------------------
// 댓글 수정(AJAX)
function updateComment(commentNo, btn){

    // 새로 작성된 댓글 내용 얻어오기
    const commentContent = btn.parentElement.previousElementSibling.value;

    const data = {
        "commentNo" : commentNo,
        "commentContent" : commentContent
    }

    fetch("/comment", {
        method : "PUT",
        headers : {"Content-Type" : "application/json"},
        body : JSON.stringify(data)
    })
    .then(resp => resp.text())
    .then(result => {
        if(result > 0){
            alert("댓글이 수정되었습니다.");
            selectCommentList();
        }else{
            alert("댓글 수정 실패");
        }
    })
    .catch(err => console.log(err));

}

// -------------------------------------------------------------------------------
// -------------------------------------------------------------------------------

// 답글 작성 화면 추가 
// -> 답글 작성 화면은 전체 화면에 1개만 존재 해야한다!

function showInsertComment(parentNo, btn){
                        // 부모 댓글 번호, 클릭한 답글 버튼


    // ** 답글 작성 textarea가 한 개만 열릴 수 있도록 만들기 **
    const temp = document.getElementsByClassName("commentInsertContent");

    if(temp.length > 0){ // 답글 작성 textara가 이미 화면에 존재하는 경우

        if(confirm("다른 답글을 작성 중입니다. 현재 댓글에 답글을 작성 하시겠습니까?")){
            temp[0].nextElementSibling.remove(); // 버튼 영역부터 삭제
            temp[0].remove(); // textara 삭제 (기준점은 마지막에 삭제해야 된다!)
        
        } else{
            return; // 함수를 종료시켜 답글이 생성되지 않게함.
        }
    }
    
    // 답글을 작성할 textarea 요소 생성
    const textarea = document.createElement("textarea");
    textarea.classList.add("commentInsertContent");
    
    // 답글 버튼의 부모의 뒤쪽에 textarea 추가
    // after(요소) : 뒤쪽에 추가
    btn.parentElement.after(textarea);


    // 답글 버튼 영역 + 등록/취소 버튼 생성 및 추가
    const commentBtnArea = document.createElement("div");
    commentBtnArea.classList.add("comment-btn-area");


    const insertBtn = document.createElement("button");
    insertBtn.innerText = "등록";
    insertBtn.setAttribute("onclick", "insertChildComment("+parentNo+", this)");


    const cancelBtn = document.createElement("button");
    cancelBtn.innerText = "취소";
    cancelBtn.setAttribute("onclick", "insertCancel(this)");

    // 답글 버튼 영역의 자식으로 등록/취소 버튼 추가
    commentBtnArea.append(insertBtn, cancelBtn);

    // 답글 버튼 영역을 화면에 추가된 textarea 뒤쪽에 추가
    textarea.after(commentBtnArea);

}


// 답글 취소
function insertCancel(btn){
                    // 취소
    btn.parentElement.previousElementSibling.remove(); // 취소의 부모의 이전 요소(textarea) 제거
    btn.parentElement.remove(); // 취소의 부모 요소(comment-btn-area) 제거
}


// 답글 등록
function insertChildComment(parentNo, btn){
                        // 부모 댓글 번호, 답글 등록 버튼

    // 누가?                loginUserNo(로그인한 회원의 userNo )(전역변수)
    // 어떤 내용?           textarea에 작성된 내용
    // 몇번 게시글?         현재 게시글 boardNo (전역변수)
    // 부모 댓글은 누구?    parentNo (매개변수)

    // 답글 내용
    const commentContent = btn.parentElement.previousElementSibling.value;

    // 답글 내용이 작성되지 않은 경우
    if(commentContent.trim().length == 0){
        alert("답글 작성 후 등록 버튼을 클릭해주세요.");
        btn.parentElement.previousElementSibling.value = "";
        btn.parentElement.previousElementSibling.focus();
        return;
    }

    const data = {
        "commentContent" : commentContent,
        "userNo" : loginUserNo,
        "noticeNo" : noticeNo,
        "parentNo" : parentNo
    };

    fetch("/comment", {
        method : "POST",
        headers : {"Content-Type" : "application/json"},
        body : JSON.stringify(data)
    })
    .then(resp => resp.text())
    .then(result => {
        if(result > 0){ // 등록 성공
            alert("답글이 등록되었습니다.");
            selectCommentList(); // 비동기 댓글 목록 조회 함수 호출

        } else { // 실패
            alert("답글 등록에 실패했습니다...");
        }
    })
    .catch(err => console.log(err));


}

const commentFix = document.getElementById('commentFix')

function commentFixd(commentNo){
    const data = {
        "commentNo" : commentNo,
    }

    if(confirm('해당 댓글을 고정하시겠습니까?')){
        fetch("/comment/fix", {
            method : "PUT",
            headers : {"Content-Type" : "application/json"},
            body : JSON.stringify(data)
        })
        .then(resp => resp.text())
        .then(result=>{
            if(result > 0){ // 등록 성공
                alert("댓글이 고정되었습니다.");
                selectCommentList(); // 비동기 댓글 목록 조회 함수 호출
    
            } else { // 실패
                alert("댓글 고정에 실패했습니다.");
            }
        })
        .catch(err => console.log(err));
    }
}

const commentFixDisable = document.getElementById('commentFixDisable')

function commentFixDisabled(commentNo){
    const data = {
        "commentNo" : commentNo,
    }

    if(confirm('해당 댓글의 고정을 해제하시겠습니까?')){
        fetch("/comment/disableFix", {
            method : "PUT",
            headers : {"Content-Type" : "application/json"},
            body : JSON.stringify(data)
        })
        .then(resp => resp.text())
        .then(result=>{
            if(result > 0){ // 등록 성공
                alert("댓글 고정이 해제되었습니다.");
                selectCommentList(); // 비동기 댓글 목록 조회 함수 호출
    
            } else { // 실패
                alert("댓글 고정 해제에 실패했습니다.");
            }
        })
        .catch(err => console.log(err));
    }
}