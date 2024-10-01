
function selectList(){

    const data={ 
        "projectNo"      : projectNo_, 
    };
    fetch("/workList/list", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
    .then (rep => rep.json())
    .then (res => {
        console.log(res);
        const arr=res;
        for(let work of arr){
            console.log(work);

            $(`.listBox`).append(
            `
            ${work.level==1 ? '<hr>': ''}
            <details style="padding: 3px 3px 3px ${(work.level-1)*20}px;">
                <summary>
                        <span class="workNo" hidden>${work.workNo}</span>
                        <span class="workTitle" contenteditable="true">${work.workTitle}</span>
                        <a href="/workSheet?workNo=${work.workNo}&projectNo=${projectNo}"><sub class="material-symbols-outlined" style="font-size:20px;">draft</sub></a>
                </summary>
                <section style="transform: scale(0.8); transform-origin: left; display:flex; align-items:center; padding: 0 0 0 20px; ">

                    <div>
                        
                        <span class="material-symbols-outlined">calendar_today</span>
                        <input class="dueDate" type="date" value="${work.dueDate}">
                    </div>

                    <div>
                        <span class="material-symbols-outlined">trending_up</span>
                        <select class="workState" name="" id="">
                        <option value="0" ${work.workState==0 ? 'selected' :  null }">시작 전</option>
                        <option value="1" ${work.workState==1 ? 'selected' :  null }">진행 중</option>
                        <option value="2" ${work.workState==2 ? 'selected' :  null }">완료 후</option>
                        </select>
                    </div>

                    <div>
                        <span class="material-symbols-outlined">cake</span>
                        <select class="workPriority" name="" id="">
                            <option value="0" ${work.workPriority==0 ? 'selected' :  null }">낮음</option>
                            <option value="1" ${work.workPriority==1 ? 'selected' :  null }">중간</option>
                            <option value="2" ${work.workPriority==2 ? 'selected' :  null }">높음</option>
                        </select>
                    </div>

                    <div>
                        <span class="material-symbols-outlined">person</span>
                        <span class="workManager" hidden>${work.workManager}</span>
                        <span>${work.workManagerName}</span>
                    </div>

                    <div>
                        <span class="material-symbols-outlined">arrow_outward</span>
                        <span class="parentNo" hidden>${work.parentNo}</span>
                        <span>${work.parentName==null ? '없음' : work.parentName}</span>
                    </div>

                    <div>
                        <sup class="material-symbols-outlined deleteWork" style="font-size:13px;">disabled_by_default</sup>
                    </div>
                </section>    
            </details>
            
            `
            );



        }
    })
    .catch(err => console.log(err))
        
}
selectList();

