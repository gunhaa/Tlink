<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Calendar"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>

  <link rel="stylesheet" href="/resources/css/calendar/calendar.css">
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js'></script>
  <script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.15/index.global.min.js'></script>

   <script type='importmap'>
    {
      "imports": {
        "@fullcalendar/core": "https://cdn.skypack.dev/@fullcalendar/core@6.1.15",
        "@fullcalendar/daygrid": "https://cdn.skypack.dev/@fullcalendar/daygrid@6.1.15",
        "@fullcalendar/interaction": "https://cdn.skypack.dev/@fullcalendar/interaction@6.1.15"
      }
    }
  </script>

  <script type='module'>
    import { Calendar } from '@fullcalendar/core'
    import dayGridPlugin from '@fullcalendar/daygrid'
    import interactionPlugin from '@fullcalendar/interaction'
    
    
    document.addEventListener('DOMContentLoaded', function() {
        const calendarEl = document.getElementById('calendar');

        const events = [
            <c:forEach var="schedule" items="${schedules}">
                <c:choose>
                    <c:when test='${schedule.scheduleType == "1 "}'>

                      {
                        id: '${schedule.scheduleNo}', 
                        title: '${schedule.scheduleTitle}',
                        start: '${schedule.startDate}',
                        end: '${schedule.endDate}',
                        description: '${schedule.scheduleContent}',
                        backgroundColor: "blue",
                        borderColor: "blue",
                        extendedProps: {
                          scheduleType: '${schedule.scheduleType}',
                          userNo : '${schedule.userNo}',
                          projectNo : '${projectNo}',
                          scheduleNo : '${schedule.scheduleNo}'
                        }
                      }<c:if test="${!loop.last}">,</c:if>
                    </c:when>
                    <c:when test='${schedule.scheduleType == "2 "}'>
                      {
                        id: '${schedule.scheduleNo}', 
                        title: '${schedule.userName}',
                        start: '${schedule.startDate}',
                        end: '${schedule.endDate}',
                        description: '${schedule.scheduleContent}',
                        allDay: true,
                        backgroundColor: "green",
                        borderColor: "green",
                        extendedProps: {
                          scheduleType: '${schedule.scheduleType}',
                          holidayTitle: '${schedule.scheduleTitle}',
                          userNo : '${schedule.userNo}',
                          projectNo : '${projectNo}',
                          scheduleNo : '${schedule.scheduleNo}'
                        }
                      }<c:if test="${!loop.last}">,</c:if>
                    </c:when>
                    <c:when test='${schedule.scheduleType == "3 "}'>
                      {
                        id: '${schedule.scheduleNo}', 
                        title: '${schedule.userName}',
                        start: '${schedule.startDate}',
                        end: '${schedule.endDate}',
                        description: '${schedule.scheduleContent}',
                        allDay: true,
                        backgroundColor: "red",
                        borderColor: "red",
                        extendedProps: {
                          scheduleType: '${schedule.scheduleType}',
                          holidayTitle: '${schedule.scheduleTitle}',
                          userNo : '${schedule.userNo}',
                          fileList: '${schedule.fileList}',
                          projectNo : '${projectNo}',
                          scheduleNo : '${schedule.scheduleNo}'
                        }
                      }<c:if test="${!loop.last}">,</c:if>
                    </c:when>
                </c:choose>
            </c:forEach>
        ];

        console.log(events)
        const calendar = new Calendar(calendarEl, {
            googleCalendarApiKey: 'AIzaSyDlinZ2qoYza4O6CKpcLXqG_ZO2sbIuB2Q',
            dayMaxEventRows: true,
            views: {
                timeGrid: {
                    dayMaxEventRows: 4
                }
            },
              // eventDrop 핸들러 추가
            eventDrop: function(info) {
                if (confirm('일부 일정이 변경되었습니다. 변경하시겠습니까?')) {
                  // '예'를 선택한 경우, 일정 업데이트 로직 실행
                  testfun(info.event);
                } else {
                  // '아니요'를 선택한 경우, 드래그된 이벤트를 원래 위치로 되돌림
                  info.revert();
                }
            },
            plugins: [dayGridPlugin, interactionPlugin],
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,dayGridWeek'
            },
            timeZone: 'UTC',
            initialView: 'dayGridMonth',
            eventDisplay: 'block',
            events: events,
            eventSources:[
              {googleCalendarId:'b86e0e69cbbc994d221a29cd0f40c96a821fa1bf1fca52a076abbb34d597e4c2@group.calendar.google.com'},
              {googleCalendarId:'ko.south_korea#holiday@group.v.calendar.google.com',
                className:'ko_event',
                color:'white',
                textColor:'red'
              }
            ],
            editable: true,
            displayEventTime: false,
            eventClick: function(info) {
                showEventDetails(info.event);
            }
        });

        calendar.render();
    });


</script>


</head>
<body>

  <jsp:include page="/WEB-INF/views/common/side.jsp" />

  <div id="calendar-container">
    <div id='calendar'></div>
    <div>
      <button class="addScheduleBtn" id="addEventBtn">일정 추가</button>
      <button class="addScheduleBtn" id="addHolidayBtn">휴가 추가</button>
    </div>
  </div>

  <div id="scheduleModal">
      <div id="insertEvent" class="modal-content"></div>
      <div id="insertHoliday" class="modal-content"></div>
      <div id="detailEvent" class="modal-content"></div>
      <div id="detailHoliday" class="modal-content"></div>
  </div>


 
  <script>
    const userNo = ${loginUser.userNo}
  </script>
  <script src="/resources/js/calendar/calendar.js"></script>

</body>
</html>
