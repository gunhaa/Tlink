function alertResult(res){ res==1 ?  alert("성공하였습니다.") : alert("실패하였습니다.") }


$(document).on("click", `.deleteWork` ,function(){
    if(confirm("삭제하시겠습니까??")){
        const workNo=$(this).pFind(parentElement, `.workNo`).text();
        const data={"workNo"      : workNo, };
        fetch("/workSheet/detail", { method: "DELETE", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
        .then (rep => rep.text())
        .then (res => { alertResult(res);  if(res==1){ $(this).parents(parentElement).remove(); } })
        .catch(err => console.log(err))
    }    
})