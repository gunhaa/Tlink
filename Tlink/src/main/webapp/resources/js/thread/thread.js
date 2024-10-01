const inputBox = document.getElementById("inputBox");
const message = document.getElementById("message");
const sendBtn = document.getElementById("send");
const inputFile = document.getElementById("inputFile");
let threadNo = new URLSearchParams(location.search).get("threadNo");

let socket;
   	
socket = new SockJS("/ThreadWebsocket");

let formData = new FormData();
let fileNames = new Array();

inputBox.addEventListener("input", ()=>{
    message.value = inputBox.innerText;
})

inputBox.addEventListener("drop", e =>{
    e.preventDefault();

    const file = e.dataTransfer.files[0];

    if( file != undefined ){
        const fileName = file.name;

        const reader = new FileReader();
        reader.readAsDataURL(file);

        reader.onload = e=>{
            drowFile(fileName);
            formData.append("files", file);
        }
    }
})

inputFile.addEventListener("change", e =>{
    console.log(e);

    for( let file of e.target.files ){

        if( file != undefined ){

            let fileName = file.name;

            const reader = new FileReader();
            reader.readAsDataURL(file);

            reader.onload = e=> {
                drowFile(fileName);
                formData.append("files", file);
            }
        }
    }
})

function drowFile(fileName){
    let fileListBox = inputBox.getElementsByClassName("fileListBox")[0];

    if( fileListBox == undefined ){
        fileListBox = document.createElement("div");
        fileListBox.classList.add("fileListBox");
        inputBox.append(fileListBox);
    }

    const fileBox = document.createElement("div");
    fileBox.classList.add("fileBox");
    fileBox.innerText = fileName;
    fileBox.setAttribute("contenteditable", false);

    const deleteBtn = document.createElement("span");
    deleteBtn.classList.add("delete-image");
    deleteBtn.innerHTML = '&times;';

    fileBox.append(deleteBtn);

    fileListBox.append(fileBox);

    fileNames = [...fileNames, fileName];
}

sendBtn.addEventListener("click", ()=>{

    const threadNo = new URLSearchParams(location.search).get("threadNo");

    formData.append("message", message.value);
    formData.append("chatType", "normal");
    formData.append("threadNo",threadNo);


    fetch('/thread/insert', {
        method: 'POST',
        body: formData
    })
    .then( resp => resp.json())
    .then( res => {
        
        socket.send(
            (JSON.stringify({
                type: "crong",
                profile: res.memberProfile,
                nickname: res.memberNickname,
                message: res.chatMessage,
                threadNo: threadNo,
                memberNo: memberNo_1,
                fileNames: fileNames
            }))
        );
        
      
        /* 초기화 */
        for (let key of formData.keys()) {
            formData.delete(key);
        }

        message.value="";
        inputBox.innerText = "";
        fileNames = [];
    });
})

socket.onopen = function() {
    socket.send(JSON.stringify({type: "bbororo", "memberNo":memberNo_1, "threadNo" : threadNo}));
};

socket.onmessage = function(event){

    const data = JSON.parse(event.data);

    if(data.profile=="" || data.profile==null){
        data.profile = "/resources/images/common/user.png";
    }

    const now = new Date();

    const year = now.getFullYear();
    const month = (now.getMonth() + 1).toString().padStart(2, '0');
    const day = now.getDate().toString().padStart(2, '0');
    const hours = now.getHours().toString().padStart(2, '0');
    const minutes = now.getMinutes().toString().padStart(2, '0');
    
    const formattedTime = `${year}-${month}-${day} ${hours}:${minutes}`;

    document.querySelector("#chatBox").insertAdjacentHTML("beforeend", 
                            `<li class="chatNormal">
                                <div class="profile">
                                    <img src="${data.profile}">
                                </div>
                                <div>
                                    <div class="infoLine">
                                        <span>${data.nickname}</span>
                                        <span class="createDate">${formattedTime}</span>
                                    </div>
                                    <div>${data.message}</div>
                                </div>
                            </li>`);
};

socket.onclose = function() {
    console.log('SockJS connection closed');
};