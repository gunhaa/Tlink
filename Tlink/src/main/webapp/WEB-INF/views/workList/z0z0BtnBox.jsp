<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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


<section class="btnBox">
    <button class="removeEffect"><span class="material-symbols-outlined">disabled_by_default</span><span>효과제거</span></button>
    <button class="spreadEffect"><span class="material-symbols-outlined">add_circle</span><span>펼침효과</span></button>

    <button class="allFold"><span class="material-symbols-outlined">menu</span><span>모두접기</span></button>
    <button class="allSpread"><span class="material-symbols-outlined" style="transform: rotateY(180deg);">sort</span><span>모두펴기</span></button>
    <button class="draagable"><span class="material-symbols-outlined">arrow_selector_tool</span><span>Drag이동</span></button>
    <button class="draagableDestroy"><span class="material-symbols-outlined">mouse_lock_off</span><span>Drag고정</span></button>
    <button class="originMovement"><span class="material-symbols-outlined">adjust</span><span>원점이동</span></button>
    <button class="translateX"><span class="material-symbols-outlined">arrow_right_alt</span><span>우측이동</span></button>
    <button class="translateY"><span class="material-symbols-outlined">arrow_left_alt</span><span>좌측이동</span></button>
</section>

<script>
    function spread(ele){ $(ele).parents("details").attr("open","open"); }
    function fold(ele){ $(ele).parents("details").removeAttr("open"); }





    $(document).on("mouseover", `.workTitle`, function(e){ 
            spread(this); 
    });

    $('.removeEffect').on("click", function(){ 
        $(document).off("mouseover",`.title`); 

    })
    $('.spreadEffect').on("click", function(){ $(`.title`).on("mouseover", function(){ spread(this);   } ); })
    $(`.allFold`)     .on("click", function(){ $(`details`).removeAttr("open"); $(`.dataBox`).css("display", "none"); })
    $(`.allSpread`)   .on("click", function(){ $(`details`).attr("open","open") })
    $(`.draagable`)   .on("click", function(){ $('.btnBox').draggable(); })
    $(`.draagableDestroy`)   .on("click", function(){   $('.btnBox').draggable("destroy"); })
    $(`.originMovement`)   .on("click", function(){ $('.btnBox').attr("style",`transition-duration: 1s; transform: translateX(0px);`);  })

    let x=0;
    $(`.translateX`).on("click", function(){ 
        x+=300;
        $('.btnBox').attr("style",
        `transition-duration: 1s; transform: translateX(\${x}px);`); 

    })
    $(`.translateY`).on("click", function(){ 
        x-=300;
        $('.btnBox').attr("style",
        `transition-duration: 1s; transform: translateX(\${x}px);`); 
    })
    

</script>