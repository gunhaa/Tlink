declare const req: any;
//declare const memberNo: any;


const input = document.querySelector<HTMLInputElement>("#memberNo")!;
const input2 = document.querySelector<HTMLInputElement>("#roomNo")!;
const btn = document.querySelector<HTMLElement>("#btn_videoConference");
const btn2 = document.querySelector("#btn2") as HTMLInputElement;
let popup;
if (btn) {

    btn.addEventListener("click", e => {


        fetch("/video/selectTitle", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                "projectNo": input2.value
            })
        })
            .then((resp: any) => resp.text())
            .then(data => {

                popup = window.open(`${req}/resources/popup/popup.jsp?memberNo=${input.value}&projectNo=${input2.value}&memberName=asd`, "VideoConference", "width=920,height=830")
                popup!.onload = () => {
                    popup!.document.querySelector("#title-container").innerHTML = `<b>${data}</b>`;

                    fetch("/video/selectChat", {
                        method: "POST",
                        headers: {
                            "Content-Type": "application/json",
                        },
                        body: JSON.stringify({
                            "projectNo": input2.value
                        })
                    })
                        .then(resp => resp.json())
                        .then(data => {

                            
                            data.forEach((item: any) => {
                                console.log("each 실행중 : ", item);

                                const content = makeChatBlock1(item.chatUserName, item.chatContent, item.chatTimestamp , item.chatProfileImg);


                                popup!.document.querySelector(".chat-itembox")?.insertAdjacentHTML("beforeend", content);
                            });
                            const chatBox =  popup!.document.querySelector(".chat-itembox") as HTMLElement
                            chatBox.scrollTop = chatBox.scrollHeight;
                            // console.log("chatBox 가 받아와짐? : ", chatBox);
                        })
                        .catch(e => {
                            console.log("chat 리스트 받아오는중 오류 발생 : ", e)
                        })
                };
            })



    })

}

const makeChatBlock1 = (chatNo: any, chatContent: any, chatTimestamp : any, chatProfileImg : any) => {

    if(chatProfileImg==null){
        chatProfileImg="/resources/images/common/user.png";
    }

    return `<div class="chat-block">
            <span class="today">@${chatTimestamp}</span>
            <div class="chat-item">
                <img src="${chatProfileImg}" class="chat-prof-img">
                <div class="chat-id">${chatNo}</div>
                <div class="chat-content">${chatContent}</div>
            </div>
        </div>`
}



if (btn2) {
    btn2.addEventListener("click", e => {


        /*
        추가 시켜야 할 태그
            <style>
            @keyframes fadeInDown {
            0% {
                opacity: 0;
                transform: translate3d(0, -100%, 0);
            }
            100% {
                opacity: 1;
                transform: translateZ(0);
            }
            }

            @keyframes fadeOut {
            0% {
                opacity: 1;
            }
            100% {
                opacity: 0;
            }
            }
            </style>
        
        */
        const main = document.querySelector("main")!;
        //body // modal색 // 글씨색 // 텍스트 // 지속 시간
        alert$1(main, "green", "white", "성공 하였습니다.", "2s", 2000);

    });
}


const alert$1 = (block: HTMLElement, color: any, fontColor: any, content: any, duration: any, time: any) => {

    const style = document.createElement("style");
    style.innerHTML = `
            @keyframes fadeInDown {
                0% {
                    opacity: 0;
                    transform: translate3d(0, -100%, 0);
                }
                100% {
                    opacity: 1;
                    transform: translateZ(0);
                }
            }
    
            @keyframes fadeOut {
                0% {
                    opacity: 1;
                }
                100% {
                    opacity: 0;
                }
            }
        `;

    document.head.appendChild(style);

    block.insertAdjacentHTML("beforebegin",
        `<div id="okModal" style="display: flex; flex-direction: column; position:relative; animation: fadeOut ${duration} forwards;"> 
      <div style="position: fixed; top: 0; left: 0; bottom: 0; right: 0; background: rgba(0, 0, 0, 0.8); z-index: 2; backdrop-filter: blur(2px); display: flex; align-items: center; justify-content: center;">
        <div style="position:absolute; top : 200px; left: 500px; background:${color}; border-radius:10px; width:800px; height:100px; animation: fadeInDown 0.3s; display: flex; align-items: center; justify-content: center;">
            <span style="font-size: 25px; color:${fontColor};">${content}</span>
        </div>
      </div>
    </div>`);

    setTimeout(() => {
        if (document.getElementById("okModal")) {
            document.getElementById("okModal")?.remove();
        }
    }, time);

    setTimeout(() => {
        document.head.removeChild(style);
    }, time + 500);

}

