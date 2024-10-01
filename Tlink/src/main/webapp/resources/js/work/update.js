function updateOn(){ $(`.updateNavigator`).attr("style","color: red;").text("●수정중").toggle("slide", 400,  function(){ $(this).removeAttr("hidden") }); }
function updateDone(){$(`.updateNavigator`).attr("style","color: blue;").text("●수정완료"); setTimeout(function() { $(`.updateNavigator`).toggle(400, function(){ $(this).prop("hidden", true); $(this).removeAttr("style")});  }, 500);}


$(document).on("focusin", `.workTitle`,    function(){updateOn()})
$(document).on("focusin", `.dueDate`,      function(){updateOn()})
$(document).on("focusin", `.workState`,    function(){updateOn()})
$(document).on("focusin", `.workPriority`, function(){updateOn()})
$(document).on("focusin", `.workManager`,  function(){updateOn()})
$(document).on("focusin", `.parentNo`,     function(){updateOn()})



$(document).on("focusout", `.workTitle`, function(){
    const workNo=$(this).parents(updateParent).find(`.workNo`).text();
    const data={
        "workNo"         : workNo, 
        "workTitle"      : $(this).text(), 
        "projectNo"      : projectNo, 
    };
    fetch("/workList/table/update/workTitle", { method: "PUT", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data)}).then (rep => rep.text())
    .then(res => { res!=0 ?  updateDone() : alert("수정실패") ; }).catch(err => console.log(err))
})

$(document).on("focusout", `.dueDate`, function(){
    const workNo=$(this).parents(updateParent).find(`.workNo`).text();
    const data={
        "workNo"         : workNo, 
        "dueDate"        : $(this).val(), 
        "projectNo"      : projectNo, 
    };
    fetch("/workList/table/update/dueDate", { method: "PUT", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data)}).then (rep => rep.text())
    .then(res => { res!=0 ?  updateDone()  : alert("수정실패") ; }).catch(err => console.log(err))
})
$(document).on("focusout", `.workState`, function(){
    const workNo=$(this).parents(updateParent).find(`.workNo`).text();
    const data={
        "workNo"         : workNo, 
        "workState"      : $(this).val(), 
        "projectNo"      : projectNo, 
    };
    fetch("/workList/table/update/workState", { method: "PUT", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data)}).then (rep => rep.text())
    .then(res => { res!=0 ?  updateDone()  : alert("수정실패") ; }).catch(err => console.log(err))
})
$(document).on("focusout", `.workPriority`, function(){
    const workNo=$(this).parents(updateParent).find(`.workNo`).text();
    const data={
        "workNo"         : workNo, 
        "workPriority"   : $(this).val(), 
        "projectNo"      : projectNo, 
    };
    fetch("/workList/table/update/workPriority", { method: "PUT", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data)}).then (rep => rep.text())
    .then(res => { res!=0 ?  updateDone()  : alert("수정실패") ; }).catch(err => console.log(err))
})
$(document).on("focusout", `.workManager`, function(){
    const workNo=$(this).parents(updateParent).find(`.workNo`).text();
    const data={
        "workNo"         : workNo, 
        "workManager"    : $(this).val(), 
        "projectNo"      : projectNo, 
    };
    fetch("/workList/table/update/workManager", { method: "PUT", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data)}).then (rep => rep.text())
    .then(res => { res!=0 ?  updateDone()  : alert("수정실패") ; }).catch(err => console.log(err))
})
$(document).on("focusout", `.parentNo`, function(){
    const workNo=$(this).parents(updateParent).find(`.workNo`).text();
    const data={
        "workNo"         : workNo, 
        "parentNo"       : $(this).val(), 
        "projectNo"      : projectNo, 
    };
    fetch("/workList/table/update/parentNo", { method: "PUT", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data)}).then (rep => rep.text())
    .then(res => { res!=0 ?  updateDone()  : alert("수정실패") ; }).catch(err => console.log(err))
})

