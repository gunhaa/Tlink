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
              
              <div id="svg-tree"></div>



         


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
<script src="https://cdn.jsdelivr.net/npm/apextree"></script>



<script>
   const data = {
        id: 'Lucas_Alex',
        data: {
          name: 'Lucas Alex',
          imageURL: 'https://i.pravatar.cc/300?img=68',
        },
        options: {
          nodeBGColor: '#94ddff',
        },
        children: [
          {
            id: 'Alex_Lee',
            data: {
              name: 'Alex Lee',
              imageURL: 'https://i.pravatar.cc/300?img=69',
            },
            options: {
              nodeBGColor: '#ffc7c2',
            },
            children: [
              {
                id: 'Mia_Patel',
                data: {
                  name: 'Mia Patel',
                  imageURL: 'https://i.pravatar.cc/300?img=49',
                },
                options: {
                  nodeBGColor: '#e3c2ff',
                },
              },
              {
                id: 'Ryan_Clark',
                data: {
                  name: 'Ryan Clark',
                  imageURL: 'https://i.pravatar.cc/300?img=13',
                },
                options: {
                  nodeBGColor: '#e3c2ff',
                },
              },
              {
                id: 'Zoe_Wang',
                data: {
                  name: 'Zoe Wang',
                  imageURL: 'https://i.pravatar.cc/300?img=54',
                },
                options: {
                  nodeBGColor: '#e3c2ff',
                },
              },
            ],
          },
          {
            id: 'Leo_Kim',
            data: {
              name: 'Leo Kim',
              imageURL: 'https://i.pravatar.cc/300?img=43',
            },
            options: {
              nodeBGColor: '#ffc7c2',
            },
            children: [
              {
                id: 'Ava_Jones',
                data: {
                  name: 'Ava Jones',
                  imageURL: 'https://i.pravatar.cc/300?img=51',
                },
                options: {
                  nodeBGColor: '#d2edc5',
                },
              },
              {
                id: 'Maya_Gupta',
                data: {
                  name: 'Maya Gupta',
                  imageURL: 'https://i.pravatar.cc/300?img=45',
                },
                options: {
                  nodeBGColor: '#d2edc5',
                },
              },
            ],
          },

          {
            id: 'Lily_Chen',
            data: {
              name: 'Lily Chen',
              imageURL: 'https://i.pravatar.cc/300?img=52',
            },
            options: {
              nodeBGColor: '#ffc7c2',
            },
            children: [
              {
                id: 'Jake_Scott',
                data: {
                  name: 'Jake Scott',
                  imageURL: 'https://i.pravatar.cc/300?img=65',
                },
                options: {
                  nodeBGColor: '#e9f08f',
                },
              },
            ],
          },
          {
            id: 'Max_Ruiz',
            data: {
              name: 'Max Ruiz',
              imageURL: 'https://i.pravatar.cc/300?img=50',
            },
            options: {
              nodeBGColor: '#ffc7c2',
            },
          },
        ],
      };
      const options = {
        contentKey: 'data',
        width: 1200,
        height: 800,
        nodeWidth: 150,
        nodeHeight: 70,
        childrenSpacing: 70,
        siblingSpacing: 30,
        direction: 'left',
        enableExpandCollapse: true,
        nodeTemplate: (content) => {
          console.log(content);
          console.log(content.image);
          return `<div style='display: flex;flex-direction: row;justify-content: space-between;align-items: center;height: 100%; box-shadow: 1px 2px 4px #ccc; padding: 0 7px;'>
          <img style='width: 50px;height: 50px;border-radius: 50%;' src='\${content.imageURL}' alt=''>
          <div style="font-weight: bold; font-family: Arial; font-size: 14px">\${content.name}</div>
         </div>`;
        },
        nodeStyle: 'box-shadow: -3px 6px 8px -5px rgba(0,0,0,0.31)',
        canvasStyle: 'border: 1px solid black;background: #f6f6f6;',
      };
      const tree = new ApexTree(document.getElementById('svg-tree'), options);
      const graph = tree.render(data);
      document.getElementById('layoutTop').addEventListener('click', (e) => { graph.changeLayout('top'); });
      document.getElementById('layoutBottom').addEventListener('click', (e) => { graph.changeLayout('bottom'); });
      document.getElementById('layoutLeft').addEventListener('click', (e) => { graph.changeLayout('left'); });
      document.getElementById('layoutRight').addEventListener('click', (e) => { graph.changeLayout('right'); });
      document.getElementById('fitScreen').addEventListener('click', (e) => { graph.fitScreen(); });

</script>