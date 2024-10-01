<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:forEach var="work" items="${wList}">
    <c:set var="projectTitle" value="${work.projectName}"/>
</c:forEach>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" href="/resources/css/work/common.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    
    <link rel="shortcut icon" href="#">






</head>
<body>
    
    <main style="display: flex">
        <jsp:include page="/WEB-INF/views/common/side.jsp" />

        <div>
            <jsp:include page="/WEB-INF/views/workList/z0Box.jsp" />
        


              

            <section class="tbCon">
                <span class="tgBtn">▶</span>
                <span style="font-weight: bold;">${projectTitle}</span>
                

                <div class="tbBox">
                    <table>
                        <thead>
                            <tr class="col">
                                <th>
                                   <span style="visibility:hidden;" class="material-symbols-outlined">draft</span>
                                </th>
                                <th>
                                    <span class="material-symbols-outlined">description</span>
                                    <span>작업이름</span>
                                </th>
                                <th>
                                    <span class="material-symbols-outlined">calendar_today</span>
                                    <span>마감일</span>
                                </th>
                                <th>
                                    <span class="material-symbols-outlined">trending_up</span>
                                    <span>상태</span>
                                </th>
                                <th>
                                    <span class="material-symbols-outlined">cake</span>
                                    <span>우선순위</span>
                                </th>
                                <th>
                                    <span class="material-symbols-outlined">person</span>
                                    <span>담당자</span>
                                </th>
                                <th>
                                    <span class="material-symbols-outlined">radio_button_checked</span>
                                    <span>프로젝트</span>
                                </th>
                                <th>
                                    <span class="material-symbols-outlined">arrow_outward</span>
                                    <span>상위작업</span>
                                </th>
                                <th>
                                    <span class="material-symbols-outlined">close_small</span>
                                </th>
                            </tr>
                        </thead>


                        <tbody class="row">
                            <c:forEach var="work" items="${wList}">
                                <tr>
                                    <td>
                                        <span class="workNo" hidden>${work.workNo}</span>
                                        <a href="/workSheet?workNo=${work.workNo}&projectNo=${projectNo}"><span class="material-symbols-outlined">draft</span></a>
                                    </td>
                                    <td class="workTitle" contenteditable="true">${work.workTitle}</td>
                                    <td ><span><input class="dueDate" type="date" value="${work.dueDate}"></span></td>
                                    <td>
                                        <select class="workState" name="" id="">
                                            <option value="0" <c:if test="${work.workState==0}">selected</c:if> >시작 전</option>
                                            <option value="1" <c:if test="${work.workState==1}">selected</c:if> >진행 중</option>
                                            <option value="2" <c:if test="${work.workState==2}">selected</c:if> >완료 후</option>
                                        </select>
                                    </td>
                                    <td>
                                        <select class="workPriority" name="" id="">
                                            <option value="0"  <c:if test="${work.workPriority==0}">selected</c:if> >낮음</option>
                                            <option value="1"  <c:if test="${work.workPriority==1}">selected</c:if> >중간</option>
                                            <option value="2"  <c:if test="${work.workPriority==2}">selected</c:if> >높음</option>
                                        </select>
                                    </td>
                                    <td>
                                        <select class="workManager">

                                            <c:forEach var="user" items="${mList}">
                                                <option value="${user.userNo}" <c:if test="${work.workManager==user.userNo}">selected</c:if> >${user.userName}</option>
                                            </c:forEach>

                                        </select>
                                    </td>
                                    <td>${work.projectName}</td>
                                    <td>
                                        <select class="parentNo">
                                            <option value=""                     <c:if test="${work.parentNo==0}">selected</c:if> >없음</option>
                                            <c:forEach var="parentWork" items="${pList}">
                                                <c:if test="${parentWork.workNo!=work.workNo}">
                                                    <option value="${parentWork.workNo}" <c:if test="${work.parentNo==parentWork.workNo}">selected</c:if> >${parentWork.workTitle}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </td>
                                    
                                    <td >
                                        <span class="material-symbols-outlined deleteWork">disabled_by_default</span>
                                    </td>
                                </tr>


                            </c:forEach>
                           
                            



                            
                        </tbody>

                        <tfoot>
                            <tr>
                                <td class="" colspan="9" >
                                    <span class="material-symbols-outlined insertWork" >add_circle</span>
                                    
                                </td>
                            </tr>

                        </tfoot>
                    </table><br>

                    <span class="updateNavigator" hidden></span>
                   


                </div>
            </section>
        </div>
    </main>

</body>
</html>




<style>


    .tbCon {
        margin: 20px 0 0 10px;

    }

    .tbCon table{
        /* width: 1400px; */
    }


    .tbCon th, 
    .tbCon td {
        padding: 10px;
 
        color: black;
    }

    .tbCon th { border-bottom: 1px solid #ccc; }

    .tbBox{
        margin-top: 20px;
    }

    .tbBox table {
        background-color: transparent;
        color: black;
        border-radius: 10px;
        box-shadow: 3px 3px 5px black;
    }

    .tbBox td {
        text-align: center;
        border-bottom: 1px solid #eee;
    }

    .tbBox td:hover {
        background-color: rgba(255, 255, 255, 0.1);
    }

    .tbBox select,
    .tbBox input {
        border: none;
        border-left: 1px solid rgba(255, 255, 255, 0.1);
        width: 100%;
        height: 100%;
        color: black;
        background-color: transparent;
        outline: none;
        padding: 10px;
    }

    .tbBox option {
        background-color: black;
        color: white;
        font-weight: bold;
    }


    .insertWork, .deleteWork{
        color: rgba(0, 0, 0, 0.05);
        cursor: pointer;
    }

</style>


<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script src="/resources/js/work/udf.js"></script>
<script src="/resources/js/work/common.js"></script>
<script src="/resources/js/work/update.js"></script>
<script>
    const projectNo_=${projectNo};
    const userNo_   =${loginUser.userNo};
    const parentElement=`tr`;   //삭제상위
    const updateParent=`tr`;    //수정상위

    let optionSum="";
    function pListUpdate(){
        const data={ "projectNo" : ${projectNo}, };
        fetch("/workList/table/pList", {
                method: "POST",
                headers: {"Content-Type" : "application/json"},
                body: JSON.stringify(data)
            }
        )
        .then (rep => rep.json())
        .then (pList => {
            for(let work of pList ){optionSum=`<option value="\${work.workNo}">\${work.workTitle}</option>`}
        })
        .catch(err => console.log(err))
    }




    $(`.insertWork`).on("click", function () {

        const data={ 
            "projectNo"   : projectNo_, 
            "userNo"      : userNo_, 
        };
        fetch("/workList/table", { method: "POST", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data) })
        .then (rep => rep.text())
        .then (res => { console.log(res); res!=0 ?  alert("성공하였습니다.") : alert("실패하였습니다."); if(res!=0){ window.location.reload(); }})
        .catch(err => console.log(err))


    })



    $('.tgBtn').on("click", function () { $('.tbBox').slideToggle(); $(this).toggleTextRotate90();})
   

</script>
    
