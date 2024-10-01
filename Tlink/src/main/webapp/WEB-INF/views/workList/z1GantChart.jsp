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
        <jsp:include page="/WEB-INF/views/common/side.jsp"/>



        


        <div>
          <jsp:include page="/WEB-INF/views/workList/z0Box.jsp" />
        
          <div style="display: flex;">
            <section style="width:1200px;">
              
              <div id="chart_div"></div>

            </section>


            <jsp:include page="/WEB-INF/views/workList/z1z0List.jsp" />


          </div>

        </div>
    </main>





 





</body>

</html>

<style>
  

</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script src="/resources/js/work/udf.js"></script>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
google.charts.load('current', {'packages':['gantt']});
google.charts.setOnLoadCallback(drawChart);


function percent(createDt,dueDt){ const createDate=new Date(createDt); const dueDate=new Date(dueDt); const sysDate=new Date(); return (sysDate-createDate)/(dueDate-createDate)*100;}

function drawChart() {

  var data = new google.visualization.DataTable();
  data.addColumn('string', 'Task ID');
  data.addColumn('string', 'Task Name');
  data.addColumn('string', 'Resource');
  data.addColumn('date', 'Start Date');
  data.addColumn('date', 'End Date');
  data.addColumn('number', 'Duration');
  data.addColumn('number', 'Percent Complete');
  data.addColumn('string', 'Dependencies');


  data.addRows([
    <c:forEach var="work" items="${wList}">
      ['${work.workNo}',  `${work.workTitle}`, '1',  new Date(`${work.createDate}`),    new Date(`${work.dueDate}`),  null, percent(`${work.createDate}`, `${work.dueDate}`), 
        <c:if test="${work.parentNo==0}">null</c:if>
        <c:if test="${work.parentNo!=0}">`${work.parentNo}`</c:if>
      ],
    </c:forEach>
  ]);


  let length=15; //개수(길이)
  var options = {height: (length+1)*42, };
  var chart = new google.visualization.Gantt(document.getElementById('chart_div'));
  chart.draw(data, options);

}





</script>

