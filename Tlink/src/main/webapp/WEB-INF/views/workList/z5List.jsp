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


    .listBox{
        width: 1200px;
    }

    details{ 
        padding: 3px; 
    }

    .deleteWork{
        cursor: grab;
    }

    

    




</style>





</head>
<body>
    

    <main style="display: flex">
        <jsp:include page="/WEB-INF/views/common/side.jsp" />

        <div>
            <jsp:include page="/WEB-INF/views/workList/z0Box.jsp" />
        

            <div style="display:flex;">

                <div>
                    <section class="listBox"></section>
                    <span class="updateNavigator" hidden></span>
                </div>
                
                <jsp:include page="/WEB-INF/views/workList/z0z0BtnBox.jsp" />

            </div>
 
                   
        </div>
    </main>

    


  
        











    



<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script src="/resources/js/work/udf.js"></script>
<script>
    const projectNo_=${projectNo};
    const parentElement=`details`;   //삭제상위
    const updateParent =`details`;    //수정상위
</script>
<script src="/resources/js/work/list.js"></script>
<script src="/resources/js/work/common.js"></script>
<script src="/resources/js/work/update.js"></script>

<script>
   
    function update(ele){ $(ele).on("mousedown", function(){ $(this).attr("contenteditable", "true"); }).on("focusout", function(){ $(this).removeAttr("contenteditable"); })} //수정함수
    update($('.title'));

 


    


    











</script>
    
</body>
</html>





