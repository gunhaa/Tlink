"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
const canvas = document.querySelector("#whiteboard");
const ctx = canvas.getContext('2d');
let drawing = false;
const drawData = [];
const arrXY = [];
let whiteMemberNo = new URLSearchParams(location.search).get("memberNo");
let whiteProjectNo = new URLSearchParams(location.search).get("projectNo");
let currentColor = "#000000";
canvas.addEventListener('mousedown', (e) => {
    drawing = true;
    const startX = e.clientX - canvas.offsetLeft;
    const startY = e.clientY - canvas.offsetTop;
    drawData.push({ drawtype: 'start', x: startX, y: startY, color: currentColor });
    ctx.beginPath();
    ctx.moveTo(startX, startY);
    ctx.strokeStyle = currentColor;
});
canvas.addEventListener('mouseup', () => __awaiter(void 0, void 0, void 0, function* () {
    if (drawing) {
        drawing = false;
        drawData.push({ drawtype: 'end' });
        if (arrXY.length < 30) {
            drawData.push({ drawtype: 'draw', "xy": arrXY, color: currentColor });
            window.opener.postMessage(getDrawDataAsJson(), '*');
            drawData.length = 0;
            arrXY.length = 0;
        }
        else {
            for (let i = 0; i < arrXY.length; i += 30) {
                const chunk = arrXY.slice(i, i + 30);
                drawData.push({ drawtype: 'draw', "xy": chunk, color: currentColor });
                yield window.opener.postMessage(getDrawDataAsJson(), '*');
            }
            drawData.length = 0;
            arrXY.length = 0;
        }
        // console.log(getDrawDataAsJson());
    }
}));
canvas.addEventListener('mousemove', (e) => {
    if (drawing) {
        const x = e.clientX - canvas.offsetLeft;
        const y = e.clientY - canvas.offsetTop;
        arrXY.push({ x, y });
        // drawData.push({ drawtype: 'draw', x, y });
        ctx.lineTo(x, y);
        ctx.strokeStyle = currentColor;
        ctx.stroke();
    }
});
const getDrawDataAsJson = () => {
    return JSON.stringify(drawData);
};
const drawFromData = (drawdata) => {
    drawdata.forEach((item) => {
        if (item.drawtype === 'start') {
            ctx.beginPath();
            ctx.moveTo(item.x, item.y);
            ctx.strokeStyle = item.color;
        }
        if (item.drawtype === 'draw') {
            ctx.strokeStyle = item.color;
            item.xy.forEach((item) => {
                ctx.lineTo(item.x, item.y);
                ctx.stroke();
            });
        }
        if (item.drawtype === 'end') {
            ctx.closePath();
        }
    });
};
const projectDrawStatus = () => {
    fetch("/video/projectDrawStatus", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            "projectNo": whiteProjectNo
        })
    })
        .then(resp => resp.text())
        .then(data => {
        // console.log("Raw : ", data);
        // console.log("Raw Type : ", typeof data);
        if (data) { // data가 null이거나 빈 문자열이 아닐 때만 처리
            try {
                let result = JSON.parse(data);
                console.log("fetch 결과", result);
                console.log("result 타입:", typeof result);
                // let result2 = JSON.parse(result);
                // console.log("fetch 결과2", result2);
                // console.log("result 타입2:", typeof result2);
                // result가 null이거나 유효한 데이터일 때만 drawFromData 호출
                if (result !== null) {
                    drawFromData(result);
                }
                else {
                    console.log("result가 null");
                }
            }
            catch (error) {
                console.error("JSON 파싱 오류:", error);
            }
        }
        else {
            console.log("데이터가 null 또는 빈 값");
        }
    });
};
// 팝업 창에서 데이터 수신
window.addEventListener('message', (e) => {
    try {
        let result = JSON.parse(e.data);
        drawFromData(result);
    }
    catch (e) {
        console.log("parsing error :", e);
        ctx.clearRect(0, 0, canvas.width, canvas.height);
    }
});
window.addEventListener("DOMContentLoaded", (e) => {
    projectDrawStatus();
});
// document.querySelector("#penBtn")!.addEventListener("click", e=>{
//     let inputColor = document.querySelector<HTMLInputElement>(".btn2")!.value ;
//     currentColor = inputColor;
// });
document.querySelector(".btn2").addEventListener("change", e => {
    let inputColor = document.querySelector(".btn2").value;
    currentColor = inputColor;
});
// document.querySelector("#blackPen")!.addEventListener("click", e=>{
//     currentColor = "#000000";
// });
// document.querySelector("#bluePen")!.addEventListener("click", e=>{
//     currentColor = "#0000FF";
// });
// document.querySelector("#redPen")!.addEventListener("click", e=>{
//     currentColor = "#FF0000";
// });
document.querySelector("#erase").addEventListener("click", e => {
    console.log("전송되는 projectNo : ", whiteProjectNo);
    fetch("/video/erase", {
        method: "POST",
        headers: {
            "Content-type": "application/json"
        },
        body: JSON.stringify({
            "projectNo": whiteProjectNo
        })
    })
        .then(resp => resp.text())
        .then(data => {
        console.log("data :", data);
        console.log("data typeof :", typeof data);
        console.log("data length :", data.length);
        if (data.trim().length === 0) {
            console.log("삭제 성공 map의 data : ", data);
            ctx.clearRect(0, 0, canvas.width, canvas.height);
        }
    })
        .catch(e => {
        console.log("erase 에러 발생 ", e);
    });
});
document.querySelector("#save").addEventListener("click", e => {
    const dataURL = canvas.toDataURL("image/png");
    const link = document.createElement("a");
    link.href = dataURL;
    link.download = 'whiteBoard.png';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
});
//# sourceMappingURL=whiteBoard.js.map