<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}"/>


        <nav class="nav">
            <ul>
                <li><a href="/workList/gantChart?projectNo=${projectNo}"  
                        <c:if test="${path=='/workList/gantChart' || path=='/workList/sankeyChart' || path=='/workList/treeChart'}"> style="background-color: #540D6E; color:white;" </c:if> 
                    >간트차트</a></li>
                <li><a href="/workList/workChart?projectNo=${projectNo}"
                        <c:if test="${path=='/workList/workChart' || path=='/workList/pieChart' || path=='/workList/lineChart'}"> style="background-color: #540D6E; color:white;" </c:if> 
                    >작업차트</a></li>
                <li><a href="/workList/table?projectNo=${projectNo}"
                        <c:if test="${path=='/workList/table'}"> style="background-color: #540D6E; color:white;" </c:if> 
                    >표</a></li>
                <li><a href="/workList/mywork?projectNo=${projectNo}"
                        <c:if test="${path=='/workList/mywork'}"> style="background-color: #540D6E; color:white;" </c:if> 
                    >내 작업</a></li>
                <li><a href="/workList/list?projectNo=${projectNo}"
                        <c:if test="${path=='/workList/list'}"> style="background-color: #540D6E; color:white;" </c:if> 
                    >리스트</a></li>
                <li><a href="/workList/managerBy?projectNo=${projectNo}"
                        <c:if test="${path=='/workList/managerBy'}"> style="background-color: #540D6E; color:white;" </c:if> 
                    >담당자별</a></li>
                <li><a href="/workList/projectBy?projectNo=${projectNo}"
                        <c:if test="${path=='/workList/projectBy'}"> style="background-color: #540D6E; color:white;" </c:if> 
                    >프로젝트별</a></li>
                <li><a href="/workList/stateBy?projectNo=${projectNo}"
                        <c:if test="${path=='/workList/stateBy'}"> style="background-color: #540D6E; color:white;" </c:if> 
                    >상태별</a></li>
                <li class="drop">
                    <span style="font-size: 10px; font-weight: bold;">●</span>
                    <ul>
                        <li><span style="color:#540D6E;">●</span>#540D6E</li>
                        <li><span style="color:#FFD700;">●</span>#FFD700</li>
                        <li><span style="color:#FFFFFF;">●</span>#FFFFFF</li>
                        <li><span style="color:#3B5998;">●</span>#3B5998</li>
                        <li><span style="color:#00BFFF;">●</span>#00BFFF</li>
                        <li><span style="color:#FF69B4;">●</span>#FF69B4</li>
                        <li><span style="color:#D3D3D3;">●</span>#D3D3D3</li>
                        <li><span style="color:#FFC0CB;">●</span>#FFC0CB</li>
                        <li><span style="color:#F5F5DC;">●</span>#F5F5DC</li>
                        <li><span style="color:#8FBC8F;">●</span>#8FBC8F</li>
                        <li><span style="color:#E0FFFF;">●</span>#E0FFFF</li>
                        <li><span style="color:#FF4500;">●</span>#FF4500</li>
                        <li><span style="color:#A52A2A;">●</span>#A52A2A</li>
                        <li><span style="color:#F4A460;">●</span>#F4A460</li>
                        <li><span style="color:#98FB98;">●</span>#98FB98</li>
                    </ul>
                </li>

            </ul>
            <ul>
                
            </ul>


        </nav>



        <style>
            * {
                padding: 0;
                margin: 0;
            }



            .nav {
                display: flex;

                background-color: white;



            }

            .nav>ul {
                display: flex;
                align-items: center;
                list-style: none;
                height: 100%;
                border-bottom: 2px solid black;
            }

            .nav li {
                width: 150px;
            }

            .nav a {
                text-decoration: none;
                color: black;
                font-size: 18px;
                font-weight: bold;
                padding: 11px 0;
                display: block;
                text-align: center;
                border-radius: 5px;

                transition-duration: 0.1s;
                height: 100%;
            }


            .nav a:hover {
                color: white;
                background-color: #540D6E;
            }

            .nav ul ul {
                background-color: red;
                list-style-type: none;
                display: flex;
                font-size: 10px;
            }

            .nav ul ul li {
                width: 70px;
                text-align: center;
                cursor: pointer;
                color: white;
                padding: 3px;
            }
        </style>

        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js"
            integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>


        <script>
            $(`.drop`).attr("style", `position: relative; `);
            $(`.drop ul`).attr("style", `display: none;`);
            $(`.drop`).hover(function () { $(`.drop ul`).attr("style", `display: block; position: absolute; z-index: 1; margin: 0; background-color: black; list-style-type: none;`) }, function () { $(`.drop ul`).attr("style", `display: none;`) });

            $(`.drop li`).on("click", function () {
                $(`.nav a`).attr("style", `background-color: \${$(this).text().slice(1)}`)
            })


        </script>