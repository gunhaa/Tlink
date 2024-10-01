<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>





    



<aside class="btnBox">
    
    <table style="font-weight: bold;">
        <tbody>
            <tr>
                <td><button><span class="material-symbols-outlined tgB">description</span>상단접기</button></td>
                <td><sub>Alt+Q</sub></td>
            </tr>
            <tr>
                <td><button><span class="material-symbols-outlined tgB">description</span>중단접기</td></button>
                <td><small>Alt+A</small></td>
            </tr>
            <tr>
                <td><button><span class="material-symbols-outlined tgB">description</span>하단접기</button></td>
                <td><small>Alt+Z</small></td>
            </tr>
            <tr>
                <td><button class="saveBtn"><span class="material-symbols-outlined">save</span>저장하기</button></td>
                <td><small>Alt+Shift+S</small></td>
            </tr>
            <tr>
                <td><button class="deleteBtn"><span class="material-symbols-outlined">scan_delete</span>삭제하기</button></td>
                <td><small>Alt+Shift+D</small></td>
            </tr>
        </tbody>
    </table>

    
    
</aside>




    

    







<style>

   

    .btnBox{
        display:flex;
        flex-direction:column;
    }
    .btnBox button{
        background-color:transparent; 
        border:none;
        font-weight: bold;
    }



</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script src="/resources/js/work/udf.js"></script>

<script>

    //단축키
    const obj={arrStyle:[`transition-duration: 100ms; transform: rotateY(360deg);`,`transition-duration: 100ms; transform: rotateY(0deg);`], arr:[`thead`, `tbody`, `tfoot`]}
    for (let i = 0; i < 3; i++){ $($('.tgB')[i]).on(`click`, function () { $(this).toggleText(`folder`,`description`).toggleStyle(obj.arrStyle[0], obj.arrStyle[1]); $(`\${obj.arr[i]}`).parents("div").toggle("100");}) } //토글버튼
    $(document).keyup( function(e){ 
        if(e.altKey &&               (e.key=='q' || e.key=='Q')){ $(`\${obj.arr[0]}`).parents("div").toggle("100");}
        if(e.altKey &&               (e.key=='a' || e.key=='A')){ $(`\${obj.arr[1]}`).parents("div").toggle("100");}
        if(e.altKey &&               (e.key=='z' || e.key=='Z')){ $(`\${obj.arr[2]}`).parents("div").toggle("100");}
        if(e.altKey && e.shiftKey && (e.key=='S' || e.key=='s')){ updateWork();}
        if(e.altKey && e.shiftKey && (e.key=='D' || e.key=='d')){ deleteWork();}
    })





    //삽입*수정*삭제 
    function alertResult(res){ res==1 ?  alert("성공하였습니다.") : alert("실패하였습니다.") }

    function updateWork(){
        const data={
            "workNo"      : $(`.workNo`).text(), 
            "workTitle"   : $(`.workTitle`).text(),
            "workMnNo"    : $(`.workMnNo`).val(),
            "workPrSt"    : $(`.workPrSt`).val(),
            "dueDt"       : $(`.dueDt`).val(),
            "workPr"      : $(`.workPr`).val(),
            "projectNo"   : $(`.projectNo`).val(),
            "parentNo"    : $(`.parentNo`).val(),
            "workContent" : $(`.workContent`).html().trim(),
        };
        console.log(
            data.workNo
        );

        fetch("/workSheet/detail", {
                method: "PUT",
                headers: {"Content-Type" : "application/json"},
                body: JSON.stringify(data)
            }
        )
        .then (rep => rep.text())
        .then (res => {alertResult(res); })
        .catch(err => console.log(err))
    }


    function deleteWork(){
        if(confirm("삭제하시겠습니까??")){
            const data={
                "workNo"      : $(`.workNo`).text(), 
            };
        
            fetch("/workSheet/detail", {
                    method: "DELETE",
                    headers: {"Content-Type" : "application/json"},
                    body: JSON.stringify(data)
                }
            )
            .then (rep => rep.text())
            .then (res => {
                alertResult(res); 

                const url = new URL(window.location.href);
                const params = new URLSearchParams(url.search);
                const workNo = params.get('workNo');
                const projectNo = params.get('projectNo');

                location="/workList/table?projectNo="+projectNo;
            })
            .catch(err => console.log(err))
        }
        return;
        
    }


    $(`.saveBtn`)  .on("click", function(e){ updateWork(); })
    $(`.deleteBtn`).on("click", function(e){ deleteWork(); })


</script>

