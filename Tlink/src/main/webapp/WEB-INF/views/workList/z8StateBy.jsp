<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>





<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Workspace</title>

    <link rel="stylesheet" href="/resources/css/work/common.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
</head>
<body>


    <main style="display: flex">
        <jsp:include page="/WEB-INF/views/common/side.jsp" />

        <div>
            <jsp:include page="/WEB-INF/views/workList/z0Box.jsp" />
        
          


            <table class="table">
                <tbody>
                    <tr>
                        <th><span class="material-symbols-outlined">
                            pending
                            </span>시작 전</th>
                        <th><span class="material-symbols-outlined">
                            arrow_circle_right
                            </span>진행 중</th>
                        <th><span class="material-symbols-outlined">
                            pause_circle
                            </span>완료 후</th>
                    </tr>
                    <tr>
                        <td>
                            <span class="workStateNavigator" hidden>0</span>
                            <ul>
                                <c:forEach var="work" items="${wList}">
                                    <c:if test="${work.workState==0}">
                                        <li>
                                            <span class="workNo" hidden>${work.workNo}</span>
                                            <a href="/workSheet?workNo=${work.workNo}&projectNo=${projectNo}"><span class="material-symbols-outlined">draft</span></a>
                                            <span class="workTitle">${work.workTitle}</span>
                                            <span class="material-symbols-outlined deleteWork">close</span>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>                                


                            <span class="insert">+새로만들기</span>
                        </td>
                            
                        <td>
                            <span class="workStateNavigator" hidden>1</span>
                            <ul>
                                <c:forEach var="work" items="${wList}">
                                    <c:if test="${work.workState==1}">
                                        
                                        <li>
                                            <span class="workNo" hidden>${work.workNo}</span>
                                            <a href="/workSheet?workNo=${work.workNo}&projectNo=${projectNo}"><span class="material-symbols-outlined">draft</span></a>
                                            <span class="workTitle">${work.workTitle}</span>
                                            <span class="material-symbols-outlined deleteWork">close</span>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>                                


                            <span class="insert">+새로만들기</span>
                        </td>

                        <td>
                            <span class="workStateNavigator" hidden>2</span>
                            <ul>
                                <c:forEach var="work" items="${wList}">
                                    <c:if test="${work.workState==2}">
                                        
                                        <li>
                                            <span class="workNo" hidden>${work.workNo}</span>
                                            <a href="/workSheet?workNo=${work.workNo}&projectNo=${projectNo}"><span class="material-symbols-outlined">draft</span></a>
                                            <span class="workTitle">${work.workTitle}</span>
                                            <span class="material-symbols-outlined deleteWork">close</span>
                                        </li>
                                                                    
                                    </c:if>
                                </c:forEach>
                            </ul> 

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

    .table{
        /* border-collapse: collapse; */
        border-collapse: separate;
        border-spacing: 10px 10px;
    }

    .table th span{
        vertical-align: bottom;
        margin: 0 3px 0 0;

        height: 23px;
    }

    .table td{
        vertical-align: top;
        
    }
    .table tr{
        border:1px solid black;
    }

    .table ul{
        padding: 10px;
        list-style-type: none;
        display: flex;
        align-items: flex-start;
        flex-direction: column;


        width: 320px;
        min-height: 1px;
    }
    .table li{
        padding: 5px;
        border-radius: 3px;
        height: 35px;
        width: 300px;

        box-shadow: 1px 1px 1.5px #ddd;

        position: relative;
    }





    .deleteWork{
        position:absolute;
        top: 3px;
        right:3px;
        font-size: 15px;

        color:#eee;

    }

    .insert, .deleteWork{
        cursor: pointer;
    }


</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script src="/resources/js/work/udf.js"></script>
<script src="/resources/js/work/common.js"></script>
<script src="/resources/js/work/update.js"></script>
<%-- <script src="/resources/js/work/stateByUpdate.js"></script>
 --%>
<script>
    const projectNo_=${projectNo};
    const parentElement=`li`; //삭제상위
    const updateParent=`li`;  //수정상위
    $(`.workTitle`).contentEditable();

    function alertResult(res){ res==1 ?  alert("성공하였습니다.") : alert("실패하였습니다.") }



    const sortElement=`.table ul`;
    $(sortElement).sortable({
        connectWith: sortElement,
        cursor: "move",
        delay: 150,
        distance: 5,
        dropOnEmpty: true,
        cancel: '[contenteditable]',

        start:  function(event, ui){ console.log("drag : " + (ui.item.index())); updateOn()},
        change: function(event, ui){ $(this).attr("style",`background-color: #eee; font-weight: bold;`); },
        stop:   function(event, ui){ console.log("drop : " + (ui.item.index()));  $(sortElement).removeAttr("style"); 

            const workNo=$(ui.item).find(`.workNo`).text();
            const workState=$(ui.item).parents(`td`).find(`.workStateNavigator`).text();
            const data={
                "workNo"         : workNo, 
                "workState"      : workState, 
                "projectNo"      : projectNo_, 
            };
            fetch("/workList/table/update/workState", { method: "PUT", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data)}).then (rep => rep.text())
            .then(res => { res!=0 ?  updateDone()  : alert("수정실패") ; }).catch(err => console.log(err))

        },


    });

    
    for(let i=0; i<3; i++){
        $(`.insert`).eq(i).on("click", function(e){
            const workState=$(this).parents(`td`).find(`.workStateNavigator`).text();
            console.log( projectNo );
            console.log( workState );
            const data={ 
                "projectNo"      : projectNo_, 
                "workState"      : workState, 
                };
            fetch("/workList/stateBy", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
            .then (rep => rep.json())
            .then (res => { 
                const work=res;
                work.workNo!=0 ?  alert("성공하였습니다.") : alert("실패하였습니다."); 
                if(work.workNo!=0){ 
                    
                $(this).parents(`td`).find(`ul`).append(`<li>
                        <span class="workNo" hidden>\${work.workNo}</span>
                        <a href="/workSheet?workNo=\${work.workNo}&projectNo=\${projectNo}"><span class="material-symbols-outlined">draft</span></a>
                        <span class="workTitle" contenteditable="true">\${work.workTitle}</span>
                        <span class="material-symbols-outlined deleteWork">close</span>
                    </li>`)

             }})
            .catch(err => console.log(err))


        })
       
    }


    



    



</script>