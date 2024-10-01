<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Todo</title>


    <link rel="stylesheet" href="/resources/css/work/common.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

    
</head>
<body>
    

    <main style="display: flex">
        <jsp:include page="/WEB-INF/views/common/side.jsp" />


        <div>



            <table class="table">
                <caption><h1>Todo List</h1></caption>
                <thead>
                    <tr>
                        <th>작업 전</th>
                        <th>작업 중</th>
                        <th>작업 후</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <span class="todoStateNavigator" hidden>0</span>
                            <section></section>
                            <span class="insert">+새로만들기</span>
                        </td>
                            
                        <td>
                            <span class="todoStateNavigator" hidden>1</span>
                            <section></section>
                            <span class="insert">+새로만들기</span>
                        </td>

                        <td>
                            <span class="todoStateNavigator" hidden>2</span>
                            <section></section>
                            <span class="insert">+새로만들기</span>
                        </td>


                    </tr>


                </tbody>
            </table>


            <span class="updateNavigator" hidden></span>



        </div>
    </main>






</body>
</html>


<style>
    
    table{
        border-collapse: separate;
        border-spacing: 100px 10px;
    }

    td{
        vertical-align: top;
        width: 300px;
    }
    tr{
        border:1px solid black;
    }



    .deleteTodo{
        font-size: 15px;
    }

    .table section{
        min-height: 1px;
    }

    .insert, .deleteTodo{
        cursor: pointer;
    }

</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script src="/resources/js/work/udf.js"></script>
<script>

    const projectNo_=${projectNo};
    const userNo_   =${loginUser.userNo};




    function selectTodo(){
        
        console.log( userNo_ );
        const data={ 
            "userNo"      : userNo_, 
            "projectNo"   : projectNo_, 
        };
        fetch("/todo/tList", {
                method: "POST",
                headers: {"Content-Type" : "application/json"},
                body: JSON.stringify(data)
            }
        )
        .then (rep => rep.json())
        .then (res => { 
            const arr=res;

            for(let todo of arr){
                console.log(todo.todoState);
                for(let i=0; i<3 ; i++){
                    if(todo.todoState==i){
                        $(`.table section`).eq(i).append(
                            `<details>
                                <summary>
                                    <span class="todoNo" hidden   >\${todo.todoNo}</span>
                                    <span class="todoTitle"           >\${todo.todoTitle}</span>
                                    <span class="todoState" hidden>\${todo.todoState}</span>
                                    <span class="material-symbols-outlined deleteTodo">event_busy</span>
                                </summary>
                                <span class="content">\${todo.todoContent}</span> 
                            </details>`
                        );
                    }
                }



            }

        })
        .catch(err => console.log(err))

    }
    selectTodo();



</script>


<script>

//     $(document).on("mouseover",'.title', function(){ $('.title').contentEditable() } ) ;
//     $(document).on("mouseover",'.content', function(){ $('.content').contentEditable() } ) ;



    const sortElement=`.table section`;
    $(sortElement).sortable({
        connectWith: sortElement,
        cursor: "move",
        delay: 150,
        distance: 5,
        dropOnEmpty: true,
        cancel: '[contenteditable]',

        start:  function(event, ui){ 
            console.log("drag : " + (ui.item.index())); 
            updateOn()
        },
        change: function(event, ui){ 
            $(this).attr("style",`background-color: #eee; font-weight: bold;`); 
        },
        stop:   function(event, ui){ 
            console.log("drop : " + (ui.item.index()));  
            $(sortElement).removeAttr("style"); 

            const todoNo=$(ui.item).find(`.todoNo`).text();
            const todoState=$(ui.item).parents(`td`).find(`.todoStateNavigator`).text();
            const data={
                "todoNo"         : todoNo, 
                "todoState"      : todoState, 
                "projectNo"      : projectNo, 
            };

            console.log(data);

            fetch("/todoList/update/todoState", { method: "PUT", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data)}).then(rep => rep.text())
            .then(res => { res!=0 ?  updateDone()  : alert("수정실패") ; }).catch(err => console.log(err))

        }, 

    });


    for(let i=0; i<3; i++){
        $(`.insert`).eq(i).on("click", function(e){

            const todoState=$(this).parents(`td`).find(`.todoStateNavigator`).text();
            console.log( projectNo );
            console.log( todoState );
            const data={ 
                "userNo"         : userNo_, 
                "projectNo"      : projectNo_, 
                "todoState"      : todoState, 
            };
            fetch("/todo", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
            .then (rep => rep.json())
            .then (res => { 
                console.log(res); 
                const todo=res;
                todo.todoNo!=0 ?  alert("성공하였습니다.") : alert("실패하였습니다."); 
                if(todo.todoNo!=0){ 
                    
                    $(this).parents(`td`).find(`section`).append(
                        `<details>
                            <summary>
                                <span class="todoNo" hidden   >\${todo.todoNo}</span>
                                <span class="todoTitle" contenteditable="true">\${todo.todoTitle}</span>
                                <span class="todoState" hidden>\${todo.todoState}</span>
                                <span class="material-symbols-outlined deleteTodo">event_busy</span>
                            </summary>
                            <span class="content">\${todo.todoContent}</span> 
                        </details>`
                    );

            }})
            .catch(err => console.log(err))

        })
    }


//     $(document).on("click", `.deleteTodo` ,function(){
//         if(confirm("삭제하시겠습니까??")
//         ){
//             $(this).parents('details').remove();
//         }

//         //추후 -> 비동기 추가
//     })


    



</script>

<script>
    function alertResult(res){ res==1 ?  alert("성공하였습니다.") : alert("실패하였습니다.") }

    const parentElement=`details`; //삭제상위
    $(document).on("click", `.deleteTodo` ,function(){
        if(confirm("삭제하시겠습니까??")){
            const todoNo=$(this).pFind(parentElement, `.todoNo`).text();
            const data={"todoNo"      : todoNo, };
            fetch("/todo/detail", { method: "DELETE", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
            .then (rep => rep.text())
            .then (res => { alertResult(res);  if(res==1){ $(this).parents(parentElement).remove(); } })
            .catch(err => console.log(err))
        }    
    })






</script>

<script>

const updateParent =`details`;  //수정상위
$(document).on("mousedown",`.todoTitle`, function(){
    $(this).contentEditable();  
})

function updateOn(){ $(`.updateNavigator`).attr("style","color: red;").text("●수정중").toggle("slide", 400,  function(){ $(this).removeAttr("hidden") }); }
function updateDone(){$(`.updateNavigator`).attr("style","color: blue;").text("●수정완료"); setTimeout(function() { $(`.updateNavigator`).toggle(400, function(){ $(this).prop("hidden", true); $(this).removeAttr("style")});  }, 500);}


$(document).on("focusin",  `.todoTitle`,  function(){updateOn()});
$(document).on("focusout", `.todoTitle`, function(){
    const todoNo=$(this).parents(updateParent).find(`.todoNo`).text();
    const data={
        "todoNo"         : todoNo, 
        "todoTitle"      : $(this).text(), 
        "projectNo"      : projectNo, 
    };
    fetch("/todo/update/todoTitle", { method: "PUT", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data)}).then (rep => rep.text())
    .then(res => { res!=0 ?  updateDone() : alert("수정실패") ; }).catch(err => console.log(err))
})



</script>