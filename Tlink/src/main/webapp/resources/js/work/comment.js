



$(`.commentInsert`).on("click", function(){
    const commentCon=$(`.commentInsertContent`).text();
    const data={ 
        "commentCon"  : commentCon, 
        "workNo"      : workNo, 
        "userNo"      : userNo
    };
    fetch("/commentWork", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
    .then (rep => rep.json())
    .then (res => { console.log(res); 
        $(`.commentList`).html("");
        selectComment();
    })
    .catch(err => console.log(err))
        
})





$(document).on("click", `.commentDelete`, function(){
    if(confirm("삭제하시겠습니까??")){
        const commentNo=$(this).pFind(`section`,`.commentNo`).text();
        console.log(commentNo);
    
        const data={
            "commentNo"  : commentNo, 
        };
        fetch("/commentWork", { method: "DELETE", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
        .then (rep => rep.json())
        .then (res => {
            console.log(res);
            $(`.commentList`).html("");
            selectComment();
        })
        .catch(err => console.log(err))
    }
    return;        
})



function selectComment(){
    
    const data={ 
        "workNo"      : workNo, 
    };
    fetch("/commentWork/select", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
    .then (rep => rep.json())
    .then (res => {
        console.log(res);
        const arr=res;
        for(let comment of arr){
     
            $(`.commentList`).append(
                `<section>
                    <span class="material-symbols-outlined">person_pin_circle</span>
                    <span class="commentNo" hidden>${comment.commentNo}</span>
                    <span class="userNo" hidden>${comment.userNo}</span>
                    <span>${comment.userName}</span>
                    ${userNo==comment.userNo ? '<sup class="commentDelete">x</sup>' : ''}
                    <h6 class="commentContent" ${userNo==comment.userNo ? 'contenteditable="true"' : ''}>${comment.commentCon}</h6>
                </section>`
            );

        }
    })
    .catch(err => console.log(err))
        
}
selectComment();




$(document).on("focusout", `.commentContent`, function(){
    const commentNo=$(this).pf(`section`,`.commentNo`).text();
    const commentCon=$(this).text();
    const data={ 
        "commentNo"  : commentNo, 
        "commentCon" : commentCon 
    };
    fetch("/commentWork", { method: "PUT", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
    .then (rep => rep.json())
    .then (res => { 
        console.log(res); 
        $(`.commentList`).html("");
        selectComment();
    })
    .catch(err => console.log(err))
        
})