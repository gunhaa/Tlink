/* 프로젝트 슬라이드 */
var swiper = new Swiper(".swiper-project", {
    spaceBetween: 24,
    slidesPerView: 3, // 슬라이드 3개씩 보이도록 설정
    initialSlide: 0,
    centeredSlides: false,
    autoplay: false,
    pagination: {
	    el: ".swiper-pagination",
	    clickable: true
    },
    navigation: {
	    nextEl: ".swiper-button-next",
	    prevEl: ".swiper-button-prev"
    }
});

const modal1 = document.querySelector('.modal1');
const modalOpen = document.querySelector('.modal-btn');
const modalClose = document.querySelector('.close-btn');

//열기 버튼을 눌렀을 때 모달팝업이 열림
modalOpen.addEventListener('click',function(){
  	//'on' class 추가
    modal1.classList.add('on');
});
//닫기 버튼을 눌렀을 때 모달팝업이 닫힘
modalClose.addEventListener('click',function(){
    //'on' class 제거
    modal1.classList.remove('on');
});

// 자동완성
const query = document.getElementById("query");
const autocomplete = document.getElementById("autocomplete");

query.addEventListener("input", e => {
    
    if (query.value.trim().length != 0) {
        
        fetch("/project/autocomplete?query=" + e.target.value.trim())
        .then(response => response.json())
        .then(list => {
            autocomplete.style.display = "block";
            
            const queryValue = query.value.trim();

                if (list.length > 0) {

                    autocomplete.innerHTML = "";

                    const ul = document.createElement("ul");

                    
                    for (let project of list) {
                        
                        const li = document.createElement("li");
                        
                        // board.boardTitle에서 queryValue를 두껍게 표현
                        li.innerHTML = project.projectTitle.replace(queryValue, "<span class='match'>" + queryValue + "</span>");

                        li.addEventListener("click", () => {
                            location.href = "/workList?projectNo="+project.projectNo;
                        })

                        ul.append(li);
                    }

                    autocomplete.append(ul);
                }


            })
            .catch(e => console.log(e))
    } else {
        autocomplete.innerText = "";
    }


})

// 클릭 시 자동완성 숨기기
document.addEventListener("click", e => {
    if (!autocomplete.contains(e.target) && e.target !== query) {
        autocomplete.style.display = "none";
    }
});

document.getElementById("search-btn").addEventListener("click", ()=>{

    if (query.value.trim().length == 0) {
        alert("검색어를 입력해주세요.");
        return;
    }

    fetch("/project/search?query="+query.value)
    .then(response => response.json())
    .then(result => {
        console.log(result)
    })
    .catch(e=>console.log(e))
})
