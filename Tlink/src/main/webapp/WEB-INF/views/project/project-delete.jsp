<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로젝트 삭제</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage/myPage.css">
    <script src="${pageContext.request.contextPath}/resources/js/myPage/secession.js" defer></script>
</head>

<body>

    <main>

        <section class="container" style="display: flex;">
            <!-- 우측 -->
            <jsp:include page="/WEB-INF/views/common/side.jsp" />
            <div class="content">
                <div class="title">프로젝트 삭제</div>

                <!-- 상단 카드 -->

                    <div class="card">
                        <div class="terms">
                            <span>프로젝트 삭제에 관한 약관</span>
                            <span>1. 현재 프로젝트가 삭제됩니다.</span>
                            <span>2. 다른 멤버들의 작업도 삭제됩니다.</span>
                            <span>3. 일정과 첨부파일도 삭제됩니다.</span>
                            <span>4. 삭제된 프로젝트는 복구가 불가능합니다.</span>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-row">
                            <div class="agree">
                                위의 약관을 확인했습니다.
                            </div>
                            <div>
                                <input type="checkbox" id="agree">
                            </div>
                        </div>
                    </div>

                    <div class="btn-area">
                        <button type="button" id="delete-btn">삭제</button>
                    </div>
            </div>
        </section>
    </main>

    <script>
        document.getElementById("delete-btn").addEventListener("click", ()=>{
            if (!agree.checked) {
                alert('약관에 동의해주세요.');
                return;
            }

            // 확인 대화상자
            if (!confirm("정말로 삭제하시겠습니까?")) {
                return;
            }

            const urlSearch = new URLSearchParams(location.search);
            const projectNo = urlSearch.get('projectNo');

            location.href="deleteProject?projectNo="+projectNo;
        })
    </script>

</body>

</html>
