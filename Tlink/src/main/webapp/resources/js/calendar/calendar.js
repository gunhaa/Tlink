const scheduleModal = document.getElementById("scheduleModal")
const addEventBtn = document.getElementById("addEventBtn")
const addHolidayBtn = document.getElementById("addHolidayBtn")

// 각 모달 변수
const insertEvent = document.getElementById("insertEvent")
const insertHoliday = document.getElementById("insertHoliday")
const detailEvent = document.getElementById("detailEvent")
const detailHoliday = document.getElementById("detailHoliday")

function clearEventForm() {
  // 폼과 관련된 요소들 가져오기
  const eventTitle = document.getElementById("eventTitle");
  const eventContent = document.getElementById("eventContent");
  const startDate = document.getElementById("startDate");
  const endDate = document.getElementById("endDate");

  // 요소들이 존재하는지 확인하고 초기화
  if (eventTitle) eventTitle.value = "";
  if (eventContent) eventContent.value = "";
  if (startDate) startDate.value = "";
  if (endDate) endDate.value = "";
}

function clearHolidayForm() {
  // 요소 선택
  const holiday2 = document.getElementById("holiday2");
  const holiday3 = document.getElementById("holiday3");
  const holidayReason = document.getElementById("holidayReason");
  const holidayContent = document.getElementById("holidayContent");
  const holidayStartDate = document.getElementById("holidayStartDate");
  const holidayEndDate = document.getElementById("holidayEndDate");

  // 각 요소가 존재하는지 확인 후 초기화
  if (holiday2) holiday2.selected = false; // <option> 요소인 경우
  if (holiday3) holiday3.selected = false; // <option> 요소인 경우

  if (holidayReason) holidayReason.value = '';
  if (holidayContent) holidayContent.value = '';
  if (holidayStartDate) holidayStartDate.value = '';
  if (holidayEndDate) holidayEndDate.value = '';
}

// 모달창들 다 사라지게 하기(재사용성을 위해 함수 생성)
function closeModal(){
  [insertEvent, insertHoliday, detailEvent, detailHoliday].forEach(el => el.style.display = 'none');
}

// 모달 창 열기
function openModal(contentEl) {
  scheduleModal.style.display = 'block';
  contentEl.style.display = 'block';
}

let isDragging = false;  // 드래그 중 여부를 추적
let dragTimeout = null;  // 드래그 후 클릭을 방지하기 위한 타이머

// 드래그 시작 시 플래그 설정
function onDragStart() {
  isDragging = true;
}

// 드래그 종료 시 플래그 해제 및 클릭 방지 타이머 설정
function onDragEnd() {
  isDragging = false;
  
  // 드래그 후 100ms 동안은 클릭 이벤트 방지
  dragTimeout = setTimeout(() => {
    dragTimeout = null;
  }, 100);
}

// 모달창을 닫는 클릭 이벤트 핸들러 수정
window.onclick = function(event) {
  // 드래그가 끝난 직후 클릭 이벤트가 발생하지 않도록 설정
  if (dragTimeout || isDragging) return;
  
  if (event.target === scheduleModal) {  // 모달 바깥 클릭 시 닫기
    scheduleModal.style.display = "none";
    closeModal();
    clearEventForm();
    clearHolidayForm();
  }
};

scheduleModal.addEventListener('click', function(event) {
  if (event.target.classList.contains('close')) {
    closeModal(); // 모든 모달 닫기
    scheduleModal.style.display='none';
  }
});

// 모달 이동을 위한 함수
function moveModal() {
  document.querySelectorAll('.movePoint').forEach(movePoint => {
    movePoint.addEventListener('mousedown', function(e) {
      onDragStart(); // 드래그 시작
      
      const modal = movePoint.closest('.modal-content'); // 부모 모달 창

      let offsetX = e.clientX - modal.offsetLeft;
      let offsetY = e.clientY - modal.offsetTop;

      function onMouseMove(e) {
        if (isDragging) {
          modal.style.left = `${e.clientX - offsetX}px`;
          modal.style.top = `${e.clientY - offsetY}px`;
        }
      }

      function onMouseUp() {
        onDragEnd(); // 드래그 종료
        document.removeEventListener('mousemove', onMouseMove);
        document.removeEventListener('mouseup', onMouseUp);
      }

      document.addEventListener('mousemove', onMouseMove);
      document.addEventListener('mouseup', onMouseUp);
    });
  });
}

// 단순 일정 등록하기
addEventBtn.addEventListener("click",function(){
  closeModal()
  insertEvent.innerHTML=`
          <div class="movePoint">
              <span id="insertEventTitle">일정 등록하기</span>
              <span class="close" id="closeInsert">&times;</span>
          </div>
          <form action="/calendar/eventForm?projectNo=${projectNo}" id="eventForm" method="post">
              <div>
                  <div class="eachForm">
                      <div>제목</div>
                      <input type="text" id="eventTitle" name="scheduleTitle" required>
                  </div>
                  <div class="eachForm">
                      <div>내용</div>
                      <textarea id="eventContent" name="scheduleContent" required></textarea>
                  </div>
                  <div class="eachForm">
                      <div>시작일</div>
                      <input type="datetime-local" id="startDate" name="startDate" required>
                  </div>
                  <div class="eachForm">
                      <div>종료일</div>
                      <input type="datetime-local" id="endDate" name="endDate" required>
                  </div>
                  <div id="insertEventBtnArea">
                    <button type="button" class="addBtn" id="insertEventBtn">등록하기</button>
                  </div>
              </div>
          </form>`
  openModal(insertEvent);
  moveModal()
  
  const insertEventBtn = document.getElementById("insertEventBtn");

  insertEventBtn.addEventListener("click", function() {
    const form = document.getElementById("eventForm");
    const startDate = new Date(document.getElementById("startDate").value);
    const endDate = new Date(document.getElementById("endDate").value);

    if (endDate < startDate) {
      alert('일정 기간을 다시 확인해주세요.');
      return; // 제출 중단
    }

    if (form.checkValidity()) {
      alert('일정이 등록되었습니다.');
      form.submit(); // form의 기본 동작을 수행합니다.
    } else {
      alert('모든 입력란을 작성해 주세요.');
    }
  });
  
})

// 휴가 등록하기
addHolidayBtn.addEventListener("click",function(){
  closeModal()
  insertHoliday.innerHTML=`
          <div class="movePoint">
              <span id="insertHolidayTitle">휴가 등록하기</span>
              <span class="close" id="closeInsert">&times;</span>
          </div>
          <form action="/calendar/holidayForm?projectNo=${projectNo}" id="holidayForm" method="post" enctype="multipart/form-data">
              <div>
                  <div class="eachForm">
                      <div>종류</div>
                      <label><input type="radio" name="scheduleType" id="holiday2" value="2" required>연가</label>
                      <label><input type="radio" name="scheduleType" id="holiday3" value="3" required>병가</label>
                  </div>
                  <div class="eachForm">
                      <div>제목</div>
                      <input type="text" id="holidayReason" name="scheduleTitle" required>
                  </div>
                  <div class="eachForm">
                      <div>내용</div>
                      <textarea id="holidayContent" name="scheduleContent" required></textarea>
                  </div>
                  <div class="eachForm">
                      <div>시작일</div>
                      <input type="date" id="holidayStartDate" name="startDate" required>
                  </div>
                  <div class="eachForm">
                    <div>종료일</div>
                    <input type="date" id="holidayEndDate" name="endDate" required>
                  </div>
                  <div class="eachForm" id="lastEachForm">
                    <div>관련서류</div>
                    <input type="file" id="holidayFile" name="scheduleFile" accept="image/*,application/zip">
                  </div>
                  <span class="info-text">※병가 관련 서류는 이미지 파일만, 2장 이상시 zip으로 제출</span>
                  <div id="insertHolidayBtnArea">
                    <button type="button" class="addBtn" id="insertHolidayBtn">등록하기</button>
                  </div>
              </div>
          </form>`
  openModal(insertHoliday);
  moveModal()

  const insertHolidayBtn = document.getElementById("insertHolidayBtn");

  insertHolidayBtn.addEventListener("click", function() {
    const form = document.getElementById("holidayForm");
    const startDate = new Date(document.getElementById("holidayStartDate").value);
    const endDate = new Date(document.getElementById("holidayEndDate").value);
    const scheduleType = document.querySelector('input[name="scheduleType"]:checked').value;
    const fileInput = document.getElementById("holidayFile");
  
    // 병가일 경우 관련 서류가 필수
    if (scheduleType == "3" && fileInput.files.length === 0) {
      alert('병가의 경우 관련 서류를 제출해야 합니다.');
      return; // 파일이 없으면 제출 중단
    }
  
    // 날짜 확인
    if (endDate < startDate) {
      alert('일정 기간을 다시 확인해주세요.');
      return; // 제출 중단
    }

    if (form.checkValidity()) {
      alert('등록이 완료되었습니다.');
      form.submit(); // form의 기본 동작을 수행합니다.
    } else {
      alert('관련서류 제외 모든 입력란을 작성해 주세요.');
    }
  });

})

// 날자 출력 모양 변경하기
// 현재 "2024-09-03T18:42:37Z" 모양으로 값 넘오옴
function formatDateTime(dateStr, includeTime = true) {
  const date = new Date(dateStr);

  const year = date.getUTCFullYear();
  const month = String(date.getUTCMonth() + 1).padStart(2, '0');
  const day = String(date.getUTCDate()).padStart(2, '0');
  const hours = String(date.getUTCHours()).padStart(2, '0');
  const minutes = String(date.getUTCMinutes()).padStart(2, '0');
  
  if (includeTime) {
    return `${year}-${month}-${day} ${hours}:${minutes}`;
  } else {
    return `${year}-${month}-${day}`;
  }
}


// `<br/>`을 줄바꿈으로 바꾸는 함수
function convertBrToNewLine(text) {
  return text.replace(/<br\s*\/?>/gi, '\n');
}

// 일정 클릭하여 일정 상세 조회하기
function showEventDetails(event) {
  console.log(event);
  const fileList = event.extendedProps.fileList;

  let filePath = '', fileReName = '', fileOriginal = '';
  if (fileList) {
    // filePath 값을 추출하는 정규 표현식
    const filePathRegex = /filePath=([^,]+)/;
    const fileReNameRegex = /fileReName=([^,]+)/;
    const fileOriginalRegex = /fileOriginal=([^,]+)/;

    // 각 필드값 추출
    filePath = fileList.match(filePathRegex)?.[1] || '';
    fileReName = fileList.match(fileReNameRegex)?.[1] || '';
    fileOriginal = fileList.match(fileOriginalRegex)?.[1] || '';
  } 

  // 종료일이 없을 경우 시작일과 동일하게 설정
  const endDateStr = event.endStr ? event.endStr : event.startStr;
  if(event.endStr != event.startStr){
    let endDate = new Date(event.endStr);
    endDate.setDate(endDate.getDate() - 1);

    const endDateStr2 = formatDateTime(endDate , false);

    // 모달에 데이터 삽입
    if (event.extendedProps.scheduleType.trim() === "1") {
      // 단순 일정일 경우
      detailEvent.innerHTML = `
          <div class="movePoint">
              <span>${event.title}</span>
              <span class="close" id="closeInsert">&times;</span>
          </div>
          <form action="/calendar/deleteEvent?projectNo=${projectNo}" id="eventForm" method="post">
            <div>
                <div class="eachForm">
                  <div>내용</div>
                  <textarea id="eventDetailContent" readOnly>${convertBrToNewLine(event.extendedProps.description)}</textarea>
                </div>
                <div class="eachForm">
                    <div>일자</div>
                    <span class="blank" readOnly>${formatDateTime(event.startStr)} ~ ${formatDateTime(endDateStr)}</span>
                </div>
                <input type="hidden" name="scheduleNo" value="${event.id}">
                <input type="hidden" name="scheduleType" value="${event.extendedProps.scheduleType}">
                <div class="btnArea">
                    <div>
                        <button type="button" id="eventUpdate" class="updateBtn">수정하기</button>
                        <button type="button" id="eventDelete" class="deleteBtn">삭제하기</button>
                    </div>
                </div>
            </div>
          </form>`;
  
      closeModal()
      openModal(detailEvent);
      moveModal()
    } else if (event.extendedProps.scheduleType.trim() === "2" || event.extendedProps.scheduleType.trim() === "3") {
      // 연가 혹은 병가일 경우
  
      if(userNo == event.extendedProps.userNo){
  
        const isAnnualLeave = event.extendedProps.scheduleType.trim() === '2';
        const isSickLeave = event.extendedProps.scheduleType.trim() === '3';

        // 관련 서류 영역 렌더링
        let fileSection = '';
        if (fileList) {
          // 파일이 있을 경우 a 태그를 사용하여 다운로드 링크 생성
          fileSection = `
            <a href="${filePath}${fileReName}" download="${fileOriginal}">
              ${fileOriginal}
            </a>`;
        } else {
          // 파일이 없을 경우 '등록된 서류가 없습니다.' 출력
          fileSection = '등록된 서류가 없습니다.';
        }
        
        detailHoliday.innerHTML = `
            <div class="movePoint">
              <span>${event.title}</span>
              <span class="close" id="closeInsert">&times;</span>
            </div>
            <form action="/calendar/deleteHoliday?projectNo=${projectNo}" id="eventForm" method="post">
              <div>
                <div class="eachForm">
                  <div>종류</div>
                  <label>
                    <input type="radio" name="scheduleType" value="2" ${isAnnualLeave ? 'checked' : ''} disabled>
                    <span class="${isAnnualLeave ? 'choicedText' : ''}">연가</span>
                  </label>
                  <label>
                    <input type="radio" name="scheduleType" value="3" ${isSickLeave ? 'checked' : ''} disabled>
                    <span class="${isSickLeave ? 'choicedText' : ''}">병가</span>
                  </label>
                </div>
                <div class="eachForm">
                  <div>내용</div>
                  <textarea id="holidayDetailContent" readOnly>${convertBrToNewLine(event.extendedProps.description)}</textarea>
                </div>
                <div class="eachForm">
                  <div>일자</div>
                  <span class="blank" readOnly>${event.startStr} ~ ${endDateStr2}</span>
                </div>
                <div class="eachForm">
                  <div>관련서류</div>
                  <span class="blank" readOnly>${fileSection}</span>
                </div>
                <input type="hidden" name="scheduleNo" value="${event.id}">
                <div class="btnArea">
                  <div>
                    <button type="button" id="holidayUpdate" class="updateBtn">수정하기</button>
                    <button type="button" id="holidayDelete" class="deleteBtn">삭제하기</button>
                  </div>
                </div>
              </div>
            </form>`;
                
    
        closeModal()
        openModal(detailHoliday);
        moveModal()
      }
    }
  }
  // false 포함 시 종료일 출력 시 시간을 제외합니다.
  const eventUpdateBtn = document.getElementById("eventUpdate");
  const holidayUpdateBtn = document.getElementById("holidayUpdate");

  if (eventUpdateBtn) {
    eventUpdateBtn.addEventListener("click", function () {
      closeModal()
      updateDetailEvent(event);
    });
  }

  if (holidayUpdateBtn) {
    holidayUpdateBtn.addEventListener("click", function () {
      closeModal()
      updateHolidayEvent(event);
    });
  }
  // 삭제하기 버튼 클릭 시
  const eventDelete = document.getElementById("eventDelete");
  const holidayDelete = document.getElementById("holidayDelete");

  if (eventDelete) {
    eventDelete.addEventListener("click", function () {
      if (confirm("정말로 삭제하시겠습니까?")) {
        alert('삭제가 완료되었습니다.')
        eventDelete.setAttribute("type", "submit")
      }
    });
  }

  if (holidayDelete) {
    holidayDelete.addEventListener("click", function () {
      if (confirm("정말로 삭제하시겠습니까?")) {
        alert('삭제가 완료되었습니다.')
        holidayDelete.setAttribute("type", "submit")
      }
    });
  }


}

function updateDetailEvent(event) {

  // 기존 데이터를 폼에 채워 넣기
  const startDate = new Date(event.startStr).toISOString().slice(0, 16); // "yyyy-mm-ddThh:mm"
  const endDate = event.endStr ? new Date(event.endStr).toISOString().slice(0, 16) : '';

  // 등록 모달을 표시
  insertEvent.innerHTML=`
          <div class="movePoint">
              <span id="insertEventTitle">일정 수정하기</span>
              <span class="close" id="closeInsert">&times;</span>
          </div>
          <form action="/calendar/eventUpdate?projectNo=${projectNo}" id="eventForm" method="post">
              <div>
                  <div class="eachForm">
                      <div>제목</div>
                      <input type="text" id="eventTitle" name="scheduleTitle" value="${event.title}" required>
                  </div>
                  <div class="eachForm">
                      <div>내용</div>
                      <textarea id="eventContent" name="scheduleContent" required>${convertBrToNewLine(event.extendedProps.description)}</textarea>
                  </div>
                  <div class="eachForm">
                      <div>시작일</div>
                      <input type="datetime-local" id="startDate" name="startDate" value="${startDate}" required>
                  </div>
                  <div class="eachForm">
                      <div>종료일</div>
                      <input type="datetime-local" id="endDate" name="endDate" value="${endDate}" required>
                  </div>
                  <input type="hidden" name="scheduleNo" value="${event.id}">
                  <input type="hidden" name="scheduleType" value="${event.extendedProps.scheduleType}">
                  <div id="insertEventBtnArea">
                    <button type="button" class="addBtn" id="updateEventBtn">수정하기</button>
                    <button type="button" class="addBtn" id="cancelEventBtn">취소하기</button>
                  </div>
              </div>
          </form>
  `
  openModal(insertEvent)
  moveModal()
  const updateEventBtn = document.getElementById("updateEventBtn");
  const cancelEventBtn = document.getElementById("cancelEventBtn");

  if (updateEventBtn) {
      updateEventBtn.addEventListener("click", function() {

        const eventForm = document.getElementById("eventForm");

        // HTML5 기본 폼 검증을 먼저 수행
        if (!eventForm.checkValidity()) {
          // 폼이 유효하지 않으면 기본 HTML5 폼 검증 메시지를 보여주고 함수를 종료
          eventForm.reportValidity(); // 브라우저의 기본 오류 메시지 출력
          return;
        }
        const startDateInput = document.getElementById("startDate").value;
        const endDateInput = document.getElementById("endDate").value;
      
        // 날짜를 Date 객체로 변환
        const startDate = new Date(startDateInput);
        const endDate = new Date(endDateInput);
        
        // 날짜 확인
        if (endDate < startDate) {
          alert('일정 기간을 다시 확인해주세요.');
          return; // 제출 중단
        }
        
        if (confirm("정말로 수정하시겠습니까?")) {
          alert('수정이 완료되었습니다.')
          updateEventBtn.setAttribute("type", "submit")
        }
      });
  }

  if (cancelEventBtn) {
      cancelEventBtn.addEventListener("click", function() {
        insertEvent.style.display = 'none';
        scheduleModal.style.display = 'none';
        clearEventForm(); // 폼 초기화
    });
  }

}

function updateHolidayEvent(event){

  // 종료일이 없을 경우 시작일과 동일하게 설정
  const endDateStr = event.endStr ? event.endStr : event.startStr;
  let endDate = new Date(event.endStr);
  endDate.setDate(endDate.getDate() - 1);
  const endDateStr2 = formatDateTime(endDate , false);

  // 기존 데이터를 폼에 채워 넣기
  const holidayStartDate = new Date(event.startStr).toISOString().slice(0, 10); // "yyyy-mm-ddThh:mm"
  const holidayEndDate = endDateStr2 ? new Date(endDateStr2).toISOString().slice(0, 10) : '';

  // 등록 모달을 표시
  insertHoliday.innerHTML=`
          <div class="movePoint">
              <span id="insertHolidayTitle">휴가 수정하기</span>
              <span class="close" id="closeInsert">&times;</span>
          </div>
          <form action="/calendar/holidayUpdate?projectNo=${projectNo}" id="holidayForm" method="post" enctype="multipart/form-data">
              <div>
                  <div class="eachForm">
                      <div>종류</div>
                      <label><input type="radio" name="scheduleType" value="2" id="holiday2" ${event.extendedProps.scheduleType.trim() === '2' ? 'checked' : ''} required>연가</label>
                      <label><input type="radio" name="scheduleType" value="3" id="holiday3" ${event.extendedProps.scheduleType.trim() === '3' ? 'checked' : ''} required>병가</label>
                  </div>
                  <div class="eachForm">
                      <div>제목</div>
                      <input type="text" id="holidayReason" name="scheduleTitle" value="${event.extendedProps.holidayTitle}" required>
                  </div>
                  <div class="eachForm">
                      <div>내용</div>
                      <textarea id="holidayContent" name="scheduleContent" required>${convertBrToNewLine(event.extendedProps.description)}</textarea>
                  </div>
                  <div class="eachForm">
                      <div>시작일</div>
                      <input type="date" id="holidayStartDate" name="startDate" value="${holidayStartDate}" required>
                  </div>
                  <div class="eachForm">
                    <div>종료일</div>
                    <input type="date" id="holidayEndDate" name="endDate" value="${holidayEndDate}" required>
                  </div>
                  <div class="eachForm" id="lastEachForm">
                    <div>관련서류</div>
                    <input type="file" id="holidayFile" name="scheduleFile" accept="image/*,application/zip">
                  </div>
                  <span class="info-text">※병가 관련 서류는 이미지 파일만, 2장 이상시 zip으로 제출</span>
                  <input type="hidden" name="scheduleNo" value="${event.id}">
                  <div id="insertHolidayBtnArea">
                    <button type="button" class="addBtn" id="updateHolidayBtn">수정하기</button>
                    <button type="button" class="addBtn" id="cancelHolidayBtn">취소하기</button>
                  </div>
              </div>
          </form>`
  openModal(insertHoliday)
  moveModal()
  const updateHolidayBtn = document.getElementById("updateHolidayBtn");
  const cancelHolidayBtn = document.getElementById("cancelHolidayBtn");
  
  if (updateHolidayBtn) {
    updateHolidayBtn.addEventListener("click", function(event) {
      const scheduleType = document.querySelector('input[name="scheduleType"]:checked').value;
      const fileInput = document.getElementById("holidayFile");
  
      const holidayForm = document.getElementById("holidayForm");

      // HTML5 기본 폼 검증을 먼저 수행
      if (!holidayForm.checkValidity()) {
        // 폼이 유효하지 않으면 기본 HTML5 폼 검증 메시지를 보여주고 함수를 종료
        holidayForm.reportValidity(); // 브라우저의 기본 오류 메시지 출력
        return;
      }

      const startDateInput = document.getElementById("holidayStartDate").value;
      const endDateInput = document.getElementById("holidayEndDate").value;
    
      // 날짜를 Date 객체로 변환
      const startDate = new Date(startDateInput);
      const endDate = new Date(endDateInput);
      
      // 날짜 확인
      if (endDate < startDate) {
        alert('일정 기간을 다시 확인해주세요.');
        return; // 제출 중단
      }

      // 병가일 경우 관련 서류가 필수
      if (scheduleType == "3" && fileInput.files.length === 0) {
        alert('병가의 경우 관련 서류를 제출해야 합니다.');
        return; // 파일이 없으면 제출 중단
      }
  
      // 수정 확인 후 제출
      if (confirm("정말로 수정하시겠습니까?")) {
        alert('수정이 완료되었습니다.');
        updateHolidayBtn.setAttribute("type", "submit");
      }
    });
  }

  if (cancelHolidayBtn) {
    cancelHolidayBtn.addEventListener("click", function() {
      insertHoliday.style.display = 'none';
      scheduleModal.style.display = 'none';
      clearHolidayForm(); // 폼 초기화
    });
  }
  
}


// dropEvent
function testfun(event){

  const formatDate = (date) => {
    return new Date(date).toISOString().slice(0, 19).replace('T', ' '); // 'T'를 공백으로 대체
  };
  
  const projectNo = event.extendedProps.projectNo

  const data = {
    "scheduleTitle" : event.title,
    "scheduleContent" : event.extendedProps.description,
    "projectNo" : event.extendedProps.projectNo,
    "scheduleNo" : event.extendedProps.scheduleNo,
    "startDate" : formatDate(event.start),
    "endDate" : formatDate(event.end),
    "projectNo" : projectNo,
    "scheduleType" : event.extendedProps.scheduleType
  }

  fetch("/calendar/eventUpdate?projectNo=" + projectNo,{
    method : "PUT",
    headers : {"Content-Type" : "application/json"},
    body : JSON.stringify(data)
  }) // GET 방식은 주소에 파라미터를 담아서 전달
  .then(response=>{
    if (!response.ok) {
      throw new Error('Network response was not ok ' + response.statusText);
    }
    return response.json();
  }) // 응답 객체 -> 파싱
  .then(response => {
    console.log(response);
  })
  .catch(err => console.log(err));
  
  
}

