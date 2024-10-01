const modal = document.getElementById("modalContainer");
let memberList = document.getElementById("listArea");
let projectNo = new URLSearchParams(location.search).get("projectNo");

const createBtn = document.getElementById("createThread");
createBtn.addEventListener("click", ()=>{
    console.log("hihihi");
    modal.classList.toggle("hidden");
})

const closeBtn = document.getElementById("closeBtn");
closeBtn.addEventListener("click", () =>{
    modal.classList.toggle("hidden");
})

const selectMember = document.getElementById("query");
selectMember.addEventListener("input", ()=>{
    const selectResult = document.getElementById("queryResult");

    if( selectMember.value.trim().length == 0 ){
        selectResult.style.display = 'none';
        return;
    }

    fetch("/thread/selectMember?projectNo="+ projectNo + "&query=" + selectMember.value)
    .then(resp => resp.json())
    .then(result => {
        selectResult.innerText = "";

        for( let item of result ){

            console.log(item);

            const li = document.createElement("li");
            const row = document.createElement("div");
            row.classList.add("searchRow");

            li.append(row);
            const info = document.createElement("span");
            info.innerHTML = `<strong>${item.USER_NAME}</strong> - ${item.USER_EMAIL}`;

            const addBtn = document.createElement("button");
            addBtn.classList.add("Btn");
            addBtn.setAttribute("type", "button");
            addBtn.setAttribute("onclick", `addMember(${JSON.stringify(item)})`);
            addBtn.innerText = "추가";

            row.append(info, addBtn);

            selectResult.append(li);
        }

        selectResult.style.display = "block";
    })
    .catch( e => console.log(e))
})

function deleteMember(e){
    e.parentElement.remove();
}

function addMember(member){

    const prevList = document.getElementsByName("userList");
    for( let mem of prevList ){
        if( mem.value == member.USER_NO ){            
            return;
        }
    }

    drowMember(member);
}

function invalid(){

    const threadName = document.getElementById("threadTitle");
    if( threadName.value.trim().length == 0 ){
        alert("스레드 이름을 입력해주세요");
        return false;
    }

    return true;
}

function drowMember(member){

    const memberItem = document.createElement("div");
    memberItem.classList.add("memberItem");

    const memberInfo = document.createElement("div");
    memberInfo.classList.add("memberInfo");

    const profile = document.createElement("img");
    profile.classList.add("memberProfile");
    if( member.profileImage != null ){
        profile.setAttribute("src", member.PROFILE_IMG);
    } else {
        profile.setAttribute("src", "/resources/images/common/user.png");
    }

    const nickname = document.createElement("div");
    nickname.classList.add("userName");
    nickname.innerText = member.USER_NAME;

    const memberId = document.createElement("div");
    memberId.classList.add("email");
    memberId.innerText = member.USER_EMAIL;

    memberInfo.append(profile, nickname, memberId);

    const deleteBtn = document.createElement("button");
    deleteBtn.classList.add("Btn");
    deleteBtn.innerText = "삭제";
    deleteBtn.setAttribute("type", "button");
    deleteBtn.setAttribute("onclick", "deleteMember(this)" );

    const userNo = document.createElement("input");
    userNo.setAttribute("type", "hidden");
    userNo.value = member.USER_NO;
    userNo.setAttribute("name", "userList");

    memberItem.append(memberInfo, deleteBtn, userNo);
    
    memberList.append(memberItem);
}