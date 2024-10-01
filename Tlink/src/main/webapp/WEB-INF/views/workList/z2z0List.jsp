<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}"/>

    <section>
      <ul class="chartList">
        <li><a href="/workList/workChart?projectNo=${projectNo}"
                <c:if test="${path=='/workList/workChart'}"> style="background-color: #3B5998; color:white;" </c:if> 
        >Bar Chart</a></li>
        <li><a href="/workList/pieChart?projectNo=${projectNo}"
                <c:if test="${path=='/workList/pieChart'}"> style="background-color: #3B5998; color:white;" </c:if> 
        >Pie Chart</a></li>
        <li><a href="/workList/lineChart?projectNo=${projectNo}"
                <c:if test="${path=='/workList/lineChart'}"> style="background-color: #3B5998; color:white;" </c:if> 
        >Line Chart</a></li>
      </ul>
    </section>


<style>
  *{box-sizing: border-box;}
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



</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script src="../udf.js"></script>

