<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


${map}


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Workspace</title>

    <link rel="stylesheet" href="/resources/css/work/common.css">
    <link rel="stylesheet"href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link rel="shortcut icon" href="#">
    <style>
        .listBox{ width: 1200px; }

        details { padding: 3px; transition-duration: 1s; }
        .listBox .title{ transition-duration: 1s; transform: translateX(0px); padding: 5px; }
        .listBox details[open] .title { border-bottom: 1px solid black; transform: translateX(5px); padding-right: 900px; }


        .count {
            border-radius: 100%;
            color: #ccc;
            margin-left: 3px;
            padding: 3px;
            font-size: 10px;

            display: inline-block;
            width: 0px;
            height: 0px;
            text-align: center;

            position: absolute;
            top: -6.5px;
            left: 0px;
        }
        .count:hover {
            font-weight: bold;
            transition-duration: 1s;
            animation: move 2s ease-in infinite;
        }


        @keyframes move {
            0% {}

            25% {
                color: black;
                filter: drop-shadow(3px 3px 1px black);
                transform: translateX(1px) rotateY(30deg);
            }

            50% {
                color: #ddd;
                filter: drop-shadow(0px 0px 0px black);
                transform: translateX(0px) rotateY(0deg);
            }

        }



        summary {
            position: relative;
            font-size: 16px;

        }


        .title {
            display: inline-block;
            min-width: 10px;
            min-height: 10px;
        }





        .tbBox {
            padding: 50px;
        }

        .tbBox table{
            background-color: transparent;
            color: black;
        }

        .tbBox td {
            text-align: center;
            width: 150px;
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




        .btnBox{ min-width: 120px; padding: 10px; display: flex; }
        .btnBox button{ min-width: 50px; height: 50px; border-radius: 100%; 
            display: flex; justify-content: center; align-items: center;
            border: none;
            color:black;
            background-color: transparent;
            font-weight: bold;
        }

    </style>





</head>

<body>


    <main style="display: flex">
        <jsp:include page="/WEB-INF/views/common/side.jsp" />

        <div>
            <jsp:include page="/WEB-INF/views/workList/z0Box.jsp" />
        
                <div style="display:flex;">

                    <section class="listBox"></section>
            
                    <jsp:include page="/WEB-INF/views/workList/z0z0BtnBox.jsp" />

                </div>

        </div>
    </main>


    





</body>

</html>            
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>


<script>
    const projectNo_=${projectNo};


    function selectManagerBy(){
        
        console.log( projectNo_ );
        const data={ "projectNo"      : projectNo_, };
        fetch("/workList/managerBy/mList", {
                method: "POST",
                headers: {"Content-Type" : "application/json"},
                body: JSON.stringify(data)
            }
        )
        .then (rep => rep.json())
        .then (res => { 
            const obj=res;

            for(let key in obj){
                const arr=obj[key];

                    $(`.listBox`).append(
                        `<details>
                            <summary>
                                <span class="count workManager">\${key}</span>
                                <span class="title">\${arr[0].workManagerName}</span>
                            </summary>
                            <div class="tbBox">
                                <table>
                                    <tbody>
                                        <tr>
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
                                                <span class="material-symbols-outlined">radio_button_checked</span>
                                                <span>프로젝트</span>
                                            </th>
                                            <th>
                                                <span class="material-symbols-outlined">arrow_outward</span>
                                                <span>상위작업</span>
                                            </th>
            
                                        </tr>
            



                                    </tbody>
            
                                </table>
            
                            </div>
            
                        </details>`

                    );

                for(let ele of arr){
                    const work=ele;
                    console.log(work);
                    console.log(work.parentName);
                    console.log(work.parentName=='null');
                    console.log(work.parentName==null);

                    $(`.tbBox tbody:last`).append(
                        `<tr>
                            <td class="workTitle" contenteditable="true">\${work.workTitle}</td>
                            <td><span><input class="dueDate" type="date" value="\${work.dueDate}"></span></td>
                            <td>
                                <select class="workState" name="" id="">
                                    <option value="0" \${work.workState==2 ? 'selected' : '' } >시작 전</option>
                                    <option value="1" \${work.workState==2 ? 'selected' : '' } >진행 중</option>
                                    <option value="2" \${work.workState==2 ? 'selected' : '' } >완료 후</option>
                                </select>
                            </td>
                            <td>
                                <select class="workPriority" name="" id="">
                                    <option value="0" \${work.workPriority==0 ? 'selected' : '' } >낮음</option>
                                    <option value="1" \${work.workPriority==1 ? 'selected' : '' } >중간</option>
                                    <option value="2" \${work.workPriority==2 ? 'selected' : '' } >높음</option>
                                </select>
                            </td>
                            <td>
                                <span class="projectNo" hidden>\${work.projectNo}</span>
                                <span>\${work.projectName}</span>
                            </td>
                            <td>
                                <span class="parentNo" hidden>\${work.parentNo}</span>
                                <span>\${ work.parentName==null ? '없음' : work.parentName }</span>
                            </td>
                        </tr>`

                    );


                    


                            
                }


            }



        })
        .catch(err => console.log(err))

    }
    selectManagerBy();


    
    
    $(document).on("mouseover",`.title`, function(e){ 
        spread(this); 
    });

    $('.removeEffect').on("click", function(){ 
        alert(1);
        $(document).off("mouseover",`.title`); 
    })


</script>
