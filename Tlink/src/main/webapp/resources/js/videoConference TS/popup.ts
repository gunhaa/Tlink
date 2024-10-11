

declare const SockJS: any;


let memberNo = new URLSearchParams(location.search).get("memberNo")!;
let projectNo = new URLSearchParams(location.search).get("projectNo")!;
let memberName = decodeURI(new URLSearchParams(location.search).get("memberName")!);
let main = document.querySelector("main") as HTMLElement;
let myStream: MediaStream = new MediaStream();
let camera = true;
let mic = true;
let display = true;
let otherMemberNoSet: Set<any> = new Set();
let peerConnectionMap = new Map();
let state = "camera";
let whiteBoard: any;
let profileImg: any;
const changeTitleBtn = document.querySelector("#changeTitle-btn") as HTMLElement;
const bookedMessageBtn = document.querySelector(".chat-booked") as HTMLElement;
const cameraBtn = document.querySelector("#video-btn") as HTMLElement;
const micBtn = document.querySelector("#mic-btn") as HTMLElement;
const displayBtn = document.querySelector("#display-btn") as HTMLElement;
const exitBtn = document.querySelector("#exit-btn") as HTMLElement;
const changeBtn = document.querySelector("#change-btn") as HTMLElement;
const optionBox = document.querySelector(".optionBox") as HTMLElement;
const option1 = document.querySelector(".options1") as HTMLElement;
const option2 = document.querySelector(".options2") as HTMLElement;
const myVideo = document.querySelector("#video-container") as HTMLElement;
const chatInput = document.querySelector(".chat-input") as HTMLInputElement;
const chatBtn = document.querySelector(".chat-send") as HTMLElement;
const boardBtn = document.querySelector("#board-btn") as HTMLElement;



changeTitleBtn!.addEventListener("click", e => {

    inputTitleModal("주제 변경", "이 화상회의의 주제는 무엇인가요?");

})

bookedMessageBtn!.addEventListener("click", e => {

    inputBookedModal("메시지 예약", "메시지를 입력해주세요.");

})


const inputTitleModal = (title: string, placeHolder: string) => {


    document.querySelector("main")?.insertAdjacentHTML("afterbegin",
        `<div id="main-container">
            <div class="modal-background">
                <div id="content-box1">
                    <div id="content-box-wrapper1">
                    <div id="content-box-item1">${title}</div>
                    <input id="content-box-item2" placeholder="${placeHolder}"></input>
                    <button id="content-box-item3" class="btn">확인</button>
                    <button id="content-box-item4" class="btn">취소</button>
                 </div>
            </div>
        </div>`)

    setTimeout(() => {
        const confirmButton = document.querySelector("#content-box-item3");
        const cancelButton = document.querySelector("#content-box-item4");

        if (confirmButton) {
            confirmButton.addEventListener("click", () => {
                const nowtitle = document.querySelector<HTMLDivElement>("#title-container")!;
                const input = document.querySelector<HTMLInputElement>("#content-box-item2");

                fetch("/video/changeRoomName", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body: JSON.stringify({
                        projectNo: projectNo,
                        title: input?.value
                    })
                })
                    .then(resp => resp.json())
                    .then(data => {


                        if (data > 0) {
                            nowtitle.innerHTML = `<b>${input!.value}</b>`
                            const existingModal = document.querySelector("#main-container");
                            alert$2(main, "green", "white", "변경을 성공 하였습니다.", "2s", 2000);
                            if (existingModal) {
                                existingModal.remove();
                            }

                            socket.send(JSON.stringify({
                                "type": "title",
                                "title": input!.value,
                                "projectNo": projectNo,
                            }))

                        } else {
                            alert$2(main, "red", "white", "변경을 실패 하였습니다.", "2s", 2000);
                        }

                    })
                    .catch(e => {
                        console.log("주제 변경 실패 : ", e);
                    })

            });
        }

        if (cancelButton) {
            cancelButton.addEventListener("click", () => {
                alert$2(main, "red", "white", "변경을 취소 하였습니다.", "2s", 2000);
                const existingModal = document.querySelector("#main-container");
                if (existingModal) {
                    existingModal.remove();
                }
            });
        }
    }, 10);
}

const inputBookedModal = (title: string, placeHolder: string) => {

    document.querySelector("main")?.insertAdjacentHTML("afterbegin",
        `<div id="main-container">
            <div class="modal-background">
                <div id="content-box2">
                    <div id="content-box-wrapper2">
                    <div id="content-box-item1">${title}</div>
                    <input id="content-box-item2" placeholder="${placeHolder}"></input>
                    <input id="content-box-item2" type="datetime-local" class="datetime"></input>
                    <button id="content-box-item3" class="btn">예약</button>
                    <button id="content-box-item4" class="btn">취소</button>
                 </div>
            </div>
        </div>`)
    setTimeout(() => {
        const confirmButton = document.querySelector("#content-box-item3");
        const cancelButton = document.querySelector("#content-box-item4");

        if (confirmButton) {
            confirmButton.addEventListener("click", () => {
                const bookedInput = document.querySelector<HTMLInputElement>(".datetime");
                const msgInput = document.querySelector<HTMLInputElement>("#content-box-item2");

                socket.send(JSON.stringify({
                    "type": "booked",
                    "bookedMsg": msgInput!.value,
                    "bookedTime": bookedInput!.value,
                    "projectNo": projectNo,
                    "memberNo": memberNo,
                    "memberName": memberName,
                    "profileImg": profileImg
                }));
                alert$2(main, "green", "white", "전송을 예약 하였습니다.", "2s", 2000);
                const existingModal = document.querySelector("#main-container");
                if (existingModal) {
                    existingModal.remove();
                }

            });
        }

        if (cancelButton) {
            cancelButton.addEventListener("click", () => {
                alert$2(main, "red", "white", "전송을 취소 하였습니다.", "2s", 2000);
                const existingModal = document.querySelector("#main-container");
                if (existingModal) {
                    existingModal.remove();
                }
            });
        }
    }, 10);
}


// 웹소켓
let socket: {
    close: any;
    readyState: number; onopen: (e: MessageEvent) => void; onmessage: (e: MessageEvent) => Promise<void>; onclose: (e: MessageEvent) => void; send: (arg0: string) => void;
};

const connectWebsocket = () => {


    return new Promise<void>((resolve, reject) => {

        socket = new SockJS(`${req}/videoConference`);

        socket.onopen = (e: MessageEvent) => {

            if (socket.readyState === WebSocket.OPEN) {
                socket.send(JSON.stringify({
                    "type": "addSession",
                    "memberNo": memberNo,
                    "projectNo": projectNo,
                }));
            } else {
                console.log('WebSocket 연결이 아직 준비되지 않았습니다.');
            }

            resolve();
            console.log("websocket 연결됨");
        }

        socket.onmessage = async (e: MessageEvent) => {


            const parsedMessage = await JSON.parse(e.data);

            console.log("Received Message:", parsedMessage);

            // 모두가 실행되는 코드
            if (parsedMessage.type === "needMemberKey") {
                socket.send(JSON.stringify({
                    "type": "memberNo",
                    "memberNo": memberNo,
                    "projectNo": projectNo,
                }));
            }

            if (parsedMessage.type === "otherMemberNo") {
                if (parsedMessage.memberNo != memberNo) {
                    otherMemberNoSet.add(parsedMessage.memberNo);
                }
            }

            // 상대방에게서 실행되는 코드
            if (parsedMessage.type === "offer") {

                // map 세팅

                peerConnectionMap.set(parsedMessage.makeAnswerMemberNo, createConnection(parsedMessage.makeAnswerMemberNo));

                peerConnectionMap.get(parsedMessage.makeAnswerMemberNo).setRemoteDescription(new RTCSessionDescription({ type: parsedMessage.type, sdp: parsedMessage.sdp }));


                // answer 보내기

                sendAnswer(peerConnectionMap.get(parsedMessage.makeAnswerMemberNo), parsedMessage.makeAnswerMemberNo);
            }

            if (parsedMessage.type === "answer") {
                peerConnectionMap.get(parsedMessage.setAnswerMemberNo).setRemoteDescription(new RTCSessionDescription({ type: parsedMessage.type, sdp: parsedMessage.sdp }));
            }

            if (parsedMessage.type === "icecandidate") {

                peerConnectionMap.get(parsedMessage.iceSender).addIceCandidate(new RTCIceCandidate({ candidate: parsedMessage.candidate, sdpMLineIndex: parsedMessage.sdpMLineIndex, sdpMid: parsedMessage.sdpMid }));

            }

            if (parsedMessage.type === "chat") {
                if (parsedMessage.profileImg === "" || parsedMessage.profileImg === null) {
                    parsedMessage.profileImg = "/resources/images/common/user.png";
                }
                const content = makeChatBlock(parsedMessage.memberName, parsedMessage.chatContent, parsedMessage.now, parsedMessage.profileImg);
                const tempDiv = document.createElement('div');
                tempDiv.innerHTML = content;

                const chatBlock = tempDiv.firstElementChild!;

                document.querySelector(".chat-itembox")?.insertAdjacentElement("beforeend", chatBlock);
                const chatBox = document.querySelector(".chat-itembox")!;
                chatBox.scrollTop = chatBox.scrollHeight;
            }

            if (parsedMessage.type === "whiteBoard") {
                if (whiteBoard) {

                    whiteBoard.postMessage(parsedMessage[projectNo], "*");

                }
            }

            if (parsedMessage.type === "title") {
                const nowtitle = document.querySelector<HTMLDivElement>("#title-container")!;
                nowtitle.innerHTML = `<b>${parsedMessage.title}</b>`

            }


            if (parsedMessage.type === "exit") {

                peerConnectionMap.delete(parsedMessage.exitMemberNo);

                otherMemberNoSet.delete(parsedMessage.exitMemberNo);

                const video = document.getElementById(parsedMessage.exitMemberNo);
                video?.parentElement?.remove();

                videoSizeHandler();

            }




        }

        socket.onclose = (e: MessageEvent) => {
            reject();
            console.log("websocket 끊김");
        }
    })



}

// 화상 회의

const getMedia = async () => {
    try {
        const initialConstrains = {
            audio: {
                echoCancellation: true,
                noiseSuppression: true
            },
            video: { facingMode: "user" }
        }

        myStream = await navigator.mediaDevices.getUserMedia(initialConstrains);

        // 오디오 추출 후 text 변환
        // extractAudio(myStream);


        let video = document.querySelectorAll("video")[0];


        if (video) {

            let existVideo = document.querySelectorAll("video")[0];
            existVideo.srcObject = myStream;

            existVideo.addEventListener("click", () => {
                existVideo.requestFullscreen();
            });


            otherMemberNoSet.forEach((otherMemberNo) => {
                console.log("재협상중");
                const videoTrack = myStream.getVideoTracks()[0];
                const sender = peerConnectionMap.get(otherMemberNo).getSenders().find((s: any) => s.track.kind === 'video');
                sender.replaceTrack(videoTrack);
                peerConnectionMap.set(otherMemberNo, createConnection(otherMemberNo));
                sendOffer(peerConnectionMap.get(otherMemberNo), otherMemberNo);
            });


        } else {

            console.log("camera video 만들기 실행");

            let videoParent = document.createElement("div") as HTMLElement;
            videoParent.classList.add("videoParent");
            myVideo.appendChild(videoParent);

            let newVideo = document.createElement("video") as HTMLVideoElement;
            newVideo.autoplay = true;
            newVideo.id = memberNo;
            newVideo.srcObject = myStream;
            videoParent.appendChild(newVideo);

            let nameTag = document.createElement("div") as HTMLElement;
            nameTag.id = `${memberNo}$1`;
            nameTag.classList.add("nameTag1");
            nameTag.innerText = memberName;
            videoParent.appendChild(nameTag);

            videoSizeHandler();

            newVideo.addEventListener("click", () => {

                newVideo.requestFullscreen();

            });
        }

    } catch (e: any) {

        console.error("getUserMedia 에러:", e);

        if (e.name === 'NotFoundError' || e.name === 'DevicesNotFoundError' || e.name === 'NotReadableError') {
            
            console.log("카메라가 없어서 카메라 끄고 실행중");

            option1.innerText = "카메라";
            option2.innerText = "화면공유(사용중)";
            state = "display";
            getDisplay();
            changeBtn.removeEventListener("click", handleChangeBtn);

        } else {
            console.log("예상 못한 에러 발생(getUserMedia)", e);
        }
    }
}


// 화면 공유
const getDisplay = async () => {
    try {
        // 화면 공유 시작
        const screenStream = await navigator.mediaDevices.getDisplayMedia({
            video: {
                cursor: "always" // 항상 커서를 표시
            } as any,
            audio: false
        });

        myStream = screenStream;
        let video = document.querySelectorAll("video")[0];


        if (video) {
            video.srcObject = myStream;

            // 비디오 클릭 시 전체화면 전환 이벤트 추가
            video.addEventListener("click", () => {

                video.requestFullscreen();

            });

            //재협상
            otherMemberNoSet.forEach((otherMemberNo) => {
                console.log("재협상중");
                const videoTrack = screenStream.getVideoTracks()[0];
                const sender = peerConnectionMap.get(otherMemberNo).getSenders().find((s: any) => s.track.kind === 'video');
                sender.replaceTrack(videoTrack);
                peerConnectionMap.set(otherMemberNo, createConnection(otherMemberNo));
                sendOffer(peerConnectionMap.get(otherMemberNo), otherMemberNo);
            });

        } else {
            console.log("display video 만들기 실행");

            let videoParent = document.createElement("div") as HTMLElement;
            videoParent.classList.add("videoParent");
            myVideo.appendChild(videoParent);

            let newVideo = document.createElement("video") as HTMLVideoElement;
            newVideo.autoplay = true;
            newVideo.id = memberNo;
            newVideo.srcObject = myStream;
            videoParent.appendChild(newVideo);

            let nameTag = document.createElement("div") as HTMLElement;
            nameTag.id = `${memberNo}$1`;
            nameTag.classList.add("nameTag1");
            nameTag.innerText = memberName;
            videoParent.appendChild(nameTag);

            videoSizeHandler();

            newVideo.addEventListener("click", () => {

                newVideo.requestFullscreen();

            });

        }





    } catch (e) {
        console.log(e);
    }
}


const handleCameraBtn = () => {


    myStream.getVideoTracks()[0].enabled = !(myStream.getVideoTracks()[0].enabled);

    if (camera) {
        cameraBtn.innerHTML = '<span class="material-symbols-outlined">videocam_off</span>';
        camera = false;
        display = false;
    } else {
        cameraBtn.innerHTML = '<span class="material-symbols-outlined">videocam</span>';
        camera = true;
        display = false;
    }

}

const handleMicBtn = () => {
    myStream.getAudioTracks()[0].enabled = !(myStream.getAudioTracks()[0].enabled);
    if (mic) {
        micBtn.innerHTML = '<span class="material-symbols-outlined">mic_off</span>';
        mic = false;
    } else {
        micBtn.innerHTML = '<span class="material-symbols-outlined">mic</span>';
        mic = true;
    }
}

const handleChangeBtn = () => {

    optionBox.classList.toggle("none");

}

const option1btn = () => {

    if (camera) {
        optionBox.classList.toggle("none");
        option1.innerText = "카메라(사용중)";
        option2.innerText = "화면공유";
        state = "camera";
        const screenTrack = myStream.getTracks()[0];
        // 화면 공유 종료
        screenTrack.stop();

        getMedia();


    } else {
        optionBox.classList.toggle("none");
        alert("카메라를 끄고 전환할 수 없습니다.");
    }

}

const option2btn = () => {

    if (camera) {
        optionBox.classList.toggle("none");
        option1.innerText = "카메라";
        option2.innerText = "화면공유(사용중)";
        state = "display";
        getDisplay();
    } else {
        optionBox.classList.toggle("none");
        alert("카메라를 끄고 전환할 수 없습니다.");
    }

}

const byebye = () => {
    window.close();
}

const createConnection = (otherMemberNo: number) => {

    const configuration = {
        iceServers: [
            {
                urls: [
                    "stun:stun.l.google.com:19302"
                ]
            }
        ]
    }

    const myPeerConnection = new RTCPeerConnection(configuration);

    myPeerConnection.addEventListener("icecandidate", (event) => {
        iceHandler(event, otherMemberNo);
    });

    myPeerConnection.addEventListener("track", (event) => {

        trackHandler(event, otherMemberNo);

    });

    if (myStream !== undefined) {
        myStream.getTracks().forEach(track => {
            myPeerConnection.addTrack(track, myStream);
        });
    }


    return myPeerConnection;

}

const trackHandler = (event: any, otherMemberNo: any) => {


    let otherMemberName = "";

    fetch("/video/whatIsMyName", {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({
            "memberNo": otherMemberNo,
            "projectNo": projectNo
        })
    })
        .then(resp => resp.text())
        .then(data => {
            console.log("trackHandler 실행");
            otherMemberName = data;

            if (document.getElementById(`${otherMemberNo}`) === null) {

                let videoParent = document.createElement("div") as HTMLElement;
                videoParent.classList.add("videoParent");
                myVideo.appendChild(videoParent);

                const video = document.createElement('video');
                video.height = 270;
                video.width = 270;
                video.autoplay = true;
                video.id = otherMemberNo;
                // streams[0]이 있는지 확인
                if (event.streams && event.streams[0]) {
                    video.srcObject = event.streams[0];  // 정상적인 스트림 할당
                } else {
                    // 빈 스트림 할당
                    const emptyStream = new MediaStream();
                    video.srcObject = emptyStream;  // 빈 스트림을 비디오에 할당
                }
                video.addEventListener("click", () => {
                    video.requestFullscreen();
                });
                videoParent.appendChild(video);

                let nameTag = document.createElement("div") as HTMLElement;
                nameTag.id = `${otherMemberNo}$1`;
                nameTag.classList.add("nameTag2");
                nameTag.innerText = otherMemberName;
                videoParent.appendChild(nameTag);

            } else {
                const video = document.getElementById(`${otherMemberNo}`) as HTMLVideoElement;
                video.srcObject = event.streams[0];
            }

            videoSizeHandler();

        })
        .catch(e => {
            console.log(e);
        });



}

const iceHandler = (event: any, targetNo: any) => {
    console.log("ICE실행");

    if (event.candidate) {

        socket.send(JSON.stringify({
            "type": "icecandidate",
            "body": event.candidate,
            "targetNo": targetNo,
            "iceSender": memberNo,
            "projectNo": projectNo,
        }));
    }

}


const setLocal = (myPeerConnection: RTCPeerConnection, offerOrAnswer: any) => {
    myPeerConnection.setLocalDescription(offerOrAnswer);
}

const needMemberKey = () => {

    socket.send(JSON.stringify({
        "type": "needMemberKey",
        "projectNo": projectNo,
    }));
}

const sendOffer = (myPeerConnection: RTCPeerConnection, targetNo: number) => {

    myPeerConnection.createOffer().then((offer: any) => {

        setLocal(myPeerConnection, offer);

        socket.send(JSON.stringify({
            "type": "offer",
            "body": offer,
            "targetNo": targetNo,
            "makeAnswerMemberNo": memberNo,
            "projectNo": projectNo,
        }));

        console.log("send Offer");
    })
}

const sendAnswer = (myPeerConnection: RTCPeerConnection, targetNo: number) => {

    myPeerConnection.createAnswer().then((answer: any) => {

        setLocal(myPeerConnection, answer);

        socket.send(JSON.stringify({
            "type": "answer",
            "body": answer,
            "targetNo": targetNo,
            "setAnswerMemberNo": memberNo,
            "projectNo": projectNo,
        }));

        console.log("send Answer");
    })
}

const roomlimit = () => {
    if (otherMemberNoSet.size > 3) {

        socket.close();
        alert$2(main, "red", "white", "화상회의 인원이 초과 되었습니다.", "2s", 2000);
        setTimeout(() => {
            byebye();
        }, 2000);
    }

}

const sendChat = () => {

    if (chatInput.value.startsWith("/")) {
        console.log("문자열은 '/'로 시작합니다.");

        let str = chatInput.value.slice(1);

        if (str.startsWith("prompt")) {
            let prompt$1 = str.slice(6)+"50토큰이내로 알려줘";
            chatInput.value = "";
            fetch("/video/prompt", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify({
                    "prompt": prompt$1
                })
            })
                .then(resp => resp.text())
                .then(data => {

                    const content = makeChatBlock("bot", data, "나에게만 보임", "/resources/images/common/robot.png");

                    insertChatBlock(content);

                })
                .catch(e => {
                    console.log("프롬프트 전송 실패 : ", e);
                })

            console.log("prompt 실행");

        } else if (str.startsWith("?")) {

            const content = makeChatBlock("bot", "/prompt '질문' : bot에게 질문", "나에게만 보임", "/resources/images/common/robot.png");

            insertChatBlock(content);
        } else {

            const content = makeChatBlock("bot", "올바른 명령어를 입력해주세요.", "나에게만 보임", "/resources/images/common/robot.png");

            insertChatBlock(content);
        }



    } else {
        // console.log("문자열은 '/'로 시작하지 않습니다.");
        socket.send(JSON.stringify({
            "type": "chat",
            "chatContent": chatInput.value,
            "memberName": memberName,
            "memberNo": memberNo,
            "projectNo": projectNo,
            "profileImg": profileImg
        }))


        console.log("send 실행");
        chatInput.value = "";
    }



}

const makeChatBlock = (chatName: any, chatContent: any, now: any, profileImg: any) => {



    return `<div class="chat-block">
            <span class="today">@${now}</span>
            <div class="chat-item">
                <img src="${profileImg}" class="chat-prof-img">
                <div class="chat-id">${chatName}</div>
                <div class="chat-content">${chatContent}</div>
            </div>
        </div>`

}

const videoSizeHandler = () => {

    const video = document.querySelectorAll("video");

    if (otherMemberNoSet.size === 0) {

        Array.from(video).forEach(item => {
            item.height = 550;
            item.width = 550;
            const tag = item.nextElementSibling!;
            tag.classList.remove("nameTag2");
            tag.classList.add("nameTag1");
        })
    }

    if (otherMemberNoSet.size === 1) {
        Array.from(video).forEach(item => {
            item.height = 270;
            item.width = 270;
            const tag = item.nextElementSibling!;
            tag.classList.remove("nameTag1");
            tag.classList.add("nameTag2");
        })
    }

    if (otherMemberNoSet.size === 2) {
        Array.from(video).forEach(item => {
            item.height = 270;
            item.width = 270;
            const tag = item.nextElementSibling!;
            tag.classList.remove("nameTag1");
            tag.classList.add("nameTag2");
        })
    }

    if (otherMemberNoSet.size === 3) {
        Array.from(video).forEach(item => {
            item.height = 270;
            item.width = 270;
            const tag = item.nextElementSibling!;
            tag.classList.remove("nameTag1");
            tag.classList.add("nameTag2");
        })
    }
}


// AudioStream 추출 - 미완성
const extractAudio = (myStream: MediaStream) => {

    const audioTracks = myStream.getAudioTracks();
    console.log('WebRTC 오디오 트랙:', audioTracks);

    const recognition = new ((window as any).SpeechRecognition || (window as any).webkitSpeechRecognition)();
    recognition.lang = 'ko-KR';  // 한국어 설정
    recognition.interimResults = true;  // 중간 결과 포함

    recognition.onstart = () => {
        console.log('음성 인식 시작');
    };

    recognition.onresult = (event: { results: { transcript: any; }[][]; }) => {
        const transcript = event.results[0][0].transcript;  // 인식된 텍스트
        console.log('인식된 텍스트:', transcript);
    };

    recognition.onerror = (event: { error: any; }) => {
        console.error('음성 인식 에러:', event.error);
    };

    recognition.onend = () => {
        console.log('음성 인식 종료');
    };

    recognition.start();


}


const openBoard = () => {

    whiteBoard = window.open(`${req}/resources/popup/whiteBoard.jsp?memberNo=${memberNo}&projectNo=${projectNo}`, "whiteBoard", "width=600,height=750");


}

const insertChatBlock = (content: any) => {

    const tempDiv = document.createElement('div');
    tempDiv.innerHTML = content;

    const chatBlock = tempDiv.firstElementChild!;

    document.querySelector(".chat-itembox")?.insertAdjacentElement("beforeend", chatBlock);
    const chatBox = document.querySelector(".chat-itembox")!;
    chatInput.value = "";
    chatBox.scrollTop = chatBox.scrollHeight;
}

const pushEnter = (e: any) => {
    if (e.key === 'Enter') {
        e.preventDefault();
        sendChat();
    }
}

const alert$2 = (block: HTMLElement, color: any, fontColor: any, content: any, duration: any, time: any) => {

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
      <div style="position: fixed; top: 0; left: 0; bottom: 0; right: 0; background: rgba(0, 0, 0, 0.8); z-index: 99; backdrop-filter: blur(2px); display: flex; align-items: center; justify-content: center;">
        <div style="position:absolute; top : 50px; left: 100px; background:${color}; border-radius:10px; width:800px; height:100px; animation: fadeInDown 0.3s; display: flex; align-items: center; justify-content: center;">
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

const limitAndNegotiation = () => {
    roomlimit();

    otherMemberNoSet.forEach((otherMemberNo) => {

        if (!peerConnectionMap.has(otherMemberNo)) {

            peerConnectionMap.set(otherMemberNo, createConnection(otherMemberNo));

            sendOffer(peerConnectionMap.get(otherMemberNo), otherMemberNo);

        }

    });
}

const startVideoConference = async () => {

    // 소켓을 연결한다.
    await connectWebsocket();

    // 화면을 얻어온다.
    await getMedia();

    // signaling server에 신호를 보내 otherMemberList를 채운다.
    await needMemberKey();


    // 방의 인원을 select해오고, 인원이 맞으면 해당 코드 실행
    setTimeout(() => {
        // 해당 방의 현재인원을 검색해서, 4명이 넘는다면 창을 끄고 종료시킨다.(경고 모달 출력)
        roomlimit();

        // 현재 방에 있는 인원에게 협상을 요청한다.
        otherMemberNoSet.forEach((otherMemberNo) => {

            if (!peerConnectionMap.has(otherMemberNo)) {

                peerConnectionMap.set(otherMemberNo, createConnection(otherMemberNo));

                sendOffer(peerConnectionMap.get(otherMemberNo), otherMemberNo);

            }

        });

    }, 2000);

    // ** await을 하면 이벤트가 끝나기전에 실행되버린다**
    // await limitAndNegotiation();

};



option1.addEventListener("click", option1btn);
option2.addEventListener("click", option2btn);
cameraBtn.addEventListener("click", handleCameraBtn);
micBtn.addEventListener("click", handleMicBtn);
changeBtn.addEventListener("click", handleChangeBtn);
exitBtn.addEventListener("click", byebye);
chatBtn.addEventListener("click", sendChat);
boardBtn.addEventListener("click", openBoard);
chatInput.addEventListener("keydown", pushEnter);

window.addEventListener('message', (e) => {

    // whiteBoard 창에서 보내는 메시지만 처리
    if (e.source === whiteBoard) {
        console.log('Received message from whiteBoard:', e.data);

        // 서버로 메시지 전송
        socket.send(JSON.stringify({
            "type": "whiteBoard",
            "draw": e.data,
            "projectNo": projectNo,
            "memberNo": memberNo
        }));
    }

    if (e.data.type === "popup") {
        profileImg = e.data.profileImg;
    }

});

startVideoConference();