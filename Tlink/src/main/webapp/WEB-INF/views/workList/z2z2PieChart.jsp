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
        
            <div style="display: flex; justify-content: space-between;">


              <section class="workChartBox">
             
                <div style="display: flex; justify-content: space-evenly;">
                  <div>
                    <div id="chart2"></div>
                    <div style="display: flex;">
                      <div id="chart4"></div>
                      <div id="chart4-1"></div>
                    </div>
                  </div>
                  <div id="chart3"></div>
                </div>

                <div style="display: flex; justify-content: space-evenly;">
                  <div id="chart5"></div>
                  <div id="chart6"></div>
                </div>

              </section>


              <jsp:include page="/WEB-INF/views/workList/z2z0List.jsp" />
             

            </div>
            
        </div>
    </main>


 





</body>

</html>

<style>
  .chartList{
    list-style-type: none;
  }
  .chartList li{
    width: 150px;
    text-align: center;
  }

  
  .chartList a {
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
  
  .chartList a:hover {
      color: white;
      background-color: #3B5998;
  }

  .workChartBox{
     width: 1200px;
  }


</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script src="/resources/js/work/udf.js"></script>

<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script>
  const projectNo_=${projectNo};
</script>
<script src="/resources/js/work/workChart2Pie.js"></script>

