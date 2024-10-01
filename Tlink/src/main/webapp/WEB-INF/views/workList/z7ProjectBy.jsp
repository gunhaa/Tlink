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
    <link rel="shortcut icon" href="#">
    <style>

        .tbBox table{
            width: 100%;
        }
        .tbBox select,.tbBox input{
            width: 100%;
            border: none;
            background-color: transparent;
            text-align: center;
        }
        .tbBox td{
            text-align: center;
            width:150px;
        }




        .title {
            display: inline-block;
            min-width: 10px;
            min-height: 10px;
        }



        .bntBox {
            width: 120px;
            padding: 10px;
            display: flex;

        }

        .bntBox button {
            width: 50px;
            height: 50px;
            border-radius: 100%;
            display: flex;
            justify-content: center;
            align-items: center;

            border: none;

            color: black;
            background-color: transparent;
        }



        .listBox{
            width: 1200px;
        }

        .listBox section{
            width: 750px;
        }
        

        .listBox section nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-weight: bold;
            padding: 3px;
            border: 1px solid #ddd;
        }

        .listBox section article {
            background-color: #eee;
        }

        .listBox section button {
            border: none;
            background-color: transparent;
            font-weight: bold;
        }

        .listBox section button .material-symbols-outlined {
            font-weight: bold;
        }
    </style>

    <style>
        .btnBox{ min-width: 120px; 
            padding: 10px;
            display: flex; 
            flex-direction: column;
        }
        .btnBox button{ min-width: 50px; height: 50px; border-radius: 5px; display: flex; justify-content: center; align-items: center;
            border: none;
            background-color: white;
            color:black;
            font-weight: bold;
        }
        .btnBox button:hover{
            filter: invert(100%);
        }
    </style>





</head>
<body>
    


    <main style="display: flex">
        <jsp:include page="/WEB-INF/views/common/side.jsp" />

        <div>
            <jsp:include page="/WEB-INF/views/workList/z0Box.jsp" />
        
          

            <div style="display:flex;">
                <div class="listBox">

                    <%-- <section>
                        <nav>
                            <span class="title">프로젝트1</span>
                            <button><span class="material-symbols-outlined">add</span></button>
                        </nav>
                        <article class="tbBox">
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
                                            <span class="material-symbols-outlined">person</span>
                                            <span>담당자</span>
                                        </th>
                                    </tr>
            
                                    <tr>
                                        <td class="workName"></td>
                                        <td><span><input class="dueDate" type="date" value="2018-12-31"></span></td>
                                        <td>
                                            <select class="workState" name="" id="">
                                                <option value="0">시작 전</option>
                                                <option value="1">진행 중</option>
                                                <option value="2">완료 후</option>
                                            </select>
                                        </td>
                                        <td>
                                            <select class="workPriority" name="" id="">
                                                <option value="0">낮음</option>
                                                <option value="1">중간</option>
                                                <option value="2">높음</option>
                                            </select>
                                        </td>
                                        <td class="workManager">
                                            <select name="" id="">
                                                <option value="">김길동</option>
                                                <option value="">이길동</option>
                                                <option value="">박길동</option>
                                            </select>
                                        </td>
                                    </tr>
                                </tbody>
            
                            </table>
            
                        </article>
                    </section>
            
        
        
                    <section>
                        <nav>
                            <span class="title">프로젝트1</span>
                            <button><span class="material-symbols-outlined">add</span></button>
                        </nav>
                        <article class="tbBox">
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
                                            <span class="material-symbols-outlined">person</span>
                                            <span>담당자</span>
                                        </th>
                                    </tr>
            
                                    <tr>
                                        <td class="workName"></td>
                                        <td><span><input class="dueDate" type="date" value="2018-12-31"></span></td>
                                        <td>
                                            <select class="workState" name="" id="">
                                                <option value="0">시작 전</option>
                                                <option value="1">진행 중</option>
                                                <option value="2">완료 후</option>
                                            </select>
                                        </td>
                                        <td>
                                            <select class="workPriority" name="" id="">
                                                <option value="0">낮음</option>
                                                <option value="1">중간</option>
                                                <option value="2">높음</option>
                                            </select>
                                        </td>
                                        <td class="workManager">
                                            <select name="" id="">
                                                <option value="">김길동</option>
                                                <option value="">이길동</option>
                                                <option value="">박길동</option>
                                            </select>
                                        </td>
                                    </tr>
                                </tbody>
            
                            </table>
            
                        </article>
                    </section> --%>
                    
                </div>




                <jsp:include page="/WEB-INF/views/workList/z0z0BtnBox.jsp" />




            </div>


        </div>
    </main>






   



    <%-- <section class="bntBox">
        <button class="dis"><span class="material-symbols-outlined">disabled_by_default</span></button>
        <button class="ena"><span class="material-symbols-outlined">add_circle</span></button>
    </section> --%>


    
</body>
</html>





<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js"
    integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script src="/resources/js/work/udf.js"></script>

<script>
    $('.title').contentEditable();
    $('td').contentEditable();


    $(document).on("click", `.listBox section button span`, function () {
        $(this).toggleStyle(`transition-duration: 1s; transform: rotate(180deg);`,`transition-duration: 1s;`);
        $(this).toggleText(`remove`,`add`);
        $(this).parents("nav").next().slideToggle();
    })

</script>


<script>
    
    const userNo_=${loginUser.userNo};

    function selectManagerBy(){
        
        console.log( userNo_ );
        const data={ "userNo"      : userNo_, };
        fetch("/workList/projectBy/pList", {
                method: "POST",
                headers: {"Content-Type" : "application/json"},
                body: JSON.stringify(data)
            }
        )
        .then (rep => rep.json())
        .then (res => { 
            console.log(res);


            const obj=res;

            for(let key in obj){
                const arr=obj[key];



                $(`.listBox`).append(
                    `<section>
                        <nav>
                            <span class="projectNo" hidden>\${arr[0].projectNo}</span>
                            <span>\${arr[0].projectName}</span>
                            <button><span class="material-symbols-outlined">add</span></button>
                        </nav>
                        <article class="tbBox">
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
                                            <span class="material-symbols-outlined">person</span>
                                            <span>담당자</span>
                                        </th>
                                        <th>
                                            <span class="material-symbols-outlined">arrow_outward</span>
                                            <span>상위작업</span>
                                        </th>
                                    </tr>
            
        
                                </tbody>
            
                            </table>
            
                        </article>
                    </section>`
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
                                <span class="workManager" hidden>\${work.workManager}</span>
                                <span>\${work.workManagerName}</span>
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

</script>