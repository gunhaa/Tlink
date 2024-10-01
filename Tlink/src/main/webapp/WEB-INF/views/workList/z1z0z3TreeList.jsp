<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<nav class="treeBtnBox">
  
  <div>
    <div style="background-color: #540D6E"></div>
    <div><button id="layoutTop">Top<br>↓</button></div>
    <div></div>
  </div>

  <div>
    <div><button id="layoutLeft">→<br>Left</button></div>
    <div><button id="fitScreen">□<br>Fit</button></div>
    <div><button id="layoutRight">←<br>Right</button></div>
  </div>

  <div>
    <div></div>
    <div><button id="layoutBottom">↑ Bottom </button></div>
    <div></div>
  </div>
  

</nav>

    

<style>
.chartList{
    list-style-type: none;
  }
  .chartList li{
    width: 150px;
    font-size: 18px;
    font-weight: bold;

}
  .chartList li:has(span){
    padding: 10px;
  }


  
  .chartList a{
      text-decoration: none;
      color: black;
      font-size: 18px;
      font-weight: bold;
      padding: 10px;
      display: block;
      text-align: left;
      border-radius: 5px;

      transition-duration: 0.1s;
      height: 100%;
      width:100%;
  }
  
  .chartList a:hover {
      color: white;
      background-color: #3B5998;
  }



  .treeBtnBox{
    width: 300px;
    height: 300px;
    display: flex;
    flex-direction: column;
  }
  .treeBtnBox>div{
    display: flex;
    
  }
  .treeBtnBox>div>div{
    width: 50px;
    height: 50px;
  }
  .treeBtnBox>div>div button{
    width: 100%;
    height: 100%;
    padding: 0;
    background-color: transparent;
    border: none;
    box-shadow: 3px 3px 3px black;
  }
  .treeBtnBox>div>div button:hover{
    background-color: #F4A460;
  }
        

  



</style>
