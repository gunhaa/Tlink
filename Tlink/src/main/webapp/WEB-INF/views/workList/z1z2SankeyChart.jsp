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
        
          <div style="display: flex;">
            <section style="width:1200px;">
              
               <div id="svg-sankey"></div>






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

<script src="https://cdn.jsdelivr.net/npm/apexsankey"></script>
<script>


const data = {
        nodes: [
          {id: 'Applications', title: 'Applications'},
          {id: 'Accepted', title: 'Accepted'},
          {id: 'Rejected', title: 'Rejected'},
          {id: 'In Progress', title: 'In Progress'},
          {id: 'Software Engineering', title: 'Software Engineering'},
          {id: 'Data Science', title: 'Data Science'},
          {id: 'Marketing', title: 'Marketing'},
          {id: 'Sales', title: 'Sales'},
          {id: 'HR', title: 'HR'},
          {id: 'Finance', title: 'Finance'},
          {id: 'Internship', title: 'Internship'},
          {id: 'Junior', title: 'Junior'},
          {id: 'Mid-level', title: 'Mid-level'},
          {id: 'Senior', title: 'Senior'},
          {id: 'Entry Level', title: 'Entry Level'},
          {id: 'Full-time', title: 'Full-time'},
          {id: 'Part-time', title: 'Part-time'},
        ],
        edges: [
          {source: 'Applications', target: 'Accepted', value: 10},
          {source: 'Applications', target: 'Rejected', value: 15},
          {source: 'Applications', target: 'In Progress', value: 10},
          {source: 'Accepted', target: 'Software Engineering', value: 4},
          {source: 'Accepted', target: 'Data Science', value: 2},
          {source: 'Accepted', target: 'Marketing', value: 1},
          {source: 'Accepted', target: 'Sales', value: 1},
          {source: 'Accepted', target: 'HR', value: 1},
          {source: 'Accepted', target: 'Finance', value: 1},
          {source: 'Rejected', target: 'Software Engineering', value: 5},
          {source: 'Rejected', target: 'Data Science', value: 3},
          {source: 'Rejected', target: 'Marketing', value: 2},
          {source: 'Rejected', target: 'Sales', value: 2},
          {source: 'Rejected', target: 'HR', value: 2},
          {source: 'Rejected', target: 'Finance', value: 1},
          {source: 'In Progress', target: 'Software Engineering', value: 3},
          {source: 'In Progress', target: 'Data Science', value: 2},
          {source: 'In Progress', target: 'Marketing', value: 2},
          {source: 'In Progress', target: 'Sales', value: 1},
          {source: 'In Progress', target: 'HR', value: 1},
          {source: 'In Progress', target: 'Finance', value: 1},
          {source: 'Software Engineering', target: 'Internship', value: 1},
          {source: 'Software Engineering', target: 'Junior', value: 1},
          {source: 'Software Engineering', target: 'Mid-level', value: 1},
          {source: 'Software Engineering', target: 'Senior', value: 1},
          {source: 'Software Engineering', target: 'Entry Level', value: 1},
          {source: 'Data Science', target: 'Internship', value: 1},
          {source: 'Data Science', target: 'Junior', value: 1},
          {source: 'Data Science', target: 'Mid-level', value: 1},
          {source: 'Data Science', target: 'Senior', value: 1},
          {source: 'Data Science', target: 'Entry Level', value: 1},
          {source: 'Marketing', target: 'Internship', value: 1},
          {source: 'Marketing', target: 'Junior', value: 1},
          {source: 'Marketing', target: 'Mid-level', value: 1},
          {source: 'Marketing', target: 'Senior', value: 1},
          {source: 'Marketing', target: 'Entry Level', value: 1},
          {source: 'Sales', target: 'Internship', value: 1},
          {source: 'Sales', target: 'Junior', value: 1},
          {source: 'Sales', target: 'Mid-level', value: 1},
          {source: 'Sales', target: 'Senior', value: 1},
          {source: 'Sales', target: 'Entry Level', value: 1},
          {source: 'HR', target: 'Internship', value: 1},
          {source: 'HR', target: 'Junior', value: 1},
          {source: 'HR', target: 'Mid-level', value: 1},
          {source: 'HR', target: 'Senior', value: 1},
          {source: 'HR', target: 'Entry Level', value: 1},
          {source: 'Finance', target: 'Internship', value: 1},
          {source: 'Finance', target: 'Junior', value: 1},
          {source: 'Finance', target: 'Mid-level', value: 1},
          {source: 'Finance', target: 'Senior', value: 1},
          {source: 'Finance', target: 'Entry Level', value: 1},
          {source: 'Internship', target: 'Full-time', value: 1},
          {source: 'Internship', target: 'Part-time', value: 1},
          {source: 'Junior', target: 'Full-time', value: 1},
          {source: 'Junior', target: 'Part-time', value: 1},
          {source: 'Mid-level', target: 'Full-time', value: 1},
          {source: 'Mid-level', target: 'Part-time', value: 1},
          {source: 'Senior', target: 'Full-time', value: 1},
          {source: 'Senior', target: 'Part-time', value: 1},
          {source: 'Entry Level', target: 'Full-time', value: 1},
          {source: 'Entry Level', target: 'Part-time', value: 1},
        ],
      };
      const graphOptions = {
        width: 1200,
        fontFamily: 'Quicksand, sans-serif',
        fontWeight: 600,
        nodeWidth: 5,
        nodeBorderWidth: 2,
        nodeBorderColor: '#111',
        edgeGradientFill: false,
      };
      const s = new ApexSankey(document.getElementById('svg-sankey'), graphOptions);
      s.render(data);

</script>