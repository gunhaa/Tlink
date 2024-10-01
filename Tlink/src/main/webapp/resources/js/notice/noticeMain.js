const arrayComment = document.getElementById('arrayComment')
const arrayRead = document.getElementById('arrayRead')
const searchQuery = document.getElementById('searchQuery').value;

arrayRead.addEventListener('click', function () {
    // 조회순으로 정렬 요청 (검색어 포함)
    fetch(`/notice/arrayRead?cp=1&sort=arrayRead&query=${searchQuery}`)
        .then(response => response.json())
        .then(map => {
            updateNoticeTableRead(map);
        })
        .catch(err => console.log(err));
});

arrayComment.addEventListener('click', function () {
    // 댓글순으로 정렬 요청 (검색어 포함)
    fetch(`/notice/arrayComment?cp=1&sort=arrayComment&query=${searchQuery}`)
        .then(response => response.json())
        .then(map => {
            updateNoticeTableComment(map);
        })
        .catch(err => console.log(err));
});

function updateNoticeTableRead(map) {
    const searchQuery = document.getElementById('searchQuery').value; // 검색어 가져오기
    const tbody = document.querySelector('.list-table tbody');
    tbody.innerHTML = ''; // 기존 내용을 비움

    // noticeList 출력
    if (map.noticeList && map.noticeList.length > 0) {
        map.noticeList.forEach(notice => {
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td>${notice.noticeNo}</td>
                <td>
                    <a href="/notice/${notice.noticeNo}">
                        ${notice.noticeType == 1 ? '[안내]' : notice.noticeType == 2 ? '[새기능 안내]' : '[정책 변경 안내]'} ${notice.noticeTitle}
                    </a>
                    ${notice.noticeCommentView == 1 ? `[${notice.commentCount}]` : ''}
                </td>
                <td>${notice.createDate}</td>
                <td>
                    ${notice.fileList.map(file => file.fileOrder == 0 ? '<span><i class="fa-solid fa-file-lines"></i></span>' : '').join('')}
                </td>
                <td>${notice.readCount}</td>
            `;
            tbody.appendChild(tr); // tbody에 추가
        });
    } else {
        console.log("noticeList가 없습니다.");
    }

    // 페이지네이션 처리
    const paginationArea = document.getElementById('paginationArea');
    paginationArea.innerHTML = ''; // 기존 내용을 비움

    if (map.pagination) {
        let paginationHtml = `
            <ul class="pagination">
                <li><a href="#" data-cp="1">&lt;&lt;</a></li>
                <li><a href="#" data-cp="${map.pagination.prevPage}">&lt;</a></li>
        `;

        for (let i = map.pagination.startPage; i <= map.pagination.endPage; i++) {
            if (i === map.pagination.currentPage) {
                paginationHtml += `<li><a class="current">${i}</a></li>`;
            } else {
                paginationHtml += `<li><a href="#" data-cp="${i}">${i}</a></li>`;
            }
        }

        paginationHtml += `
                <li><a href="#" data-cp="${map.pagination.nextPage}">&gt;</a></li>
                <li><a href="#" data-cp="${map.pagination.maxPage}">&gt;&gt;</a></li>
            </ul>
        `;
        paginationArea.innerHTML = paginationHtml;

        // 페이지네이션 링크에 클릭 이벤트 추가
        document.querySelectorAll('.pagination a').forEach(link => {
            link.addEventListener('click', function (e) {
                e.preventDefault();
                const cp = this.getAttribute('data-cp');
                loadPage(cp); // 또는 loadPageComment(cp);
            });
        });
    }
}

function updateNoticeTableComment(map) {
    const searchQuery = document.getElementById('searchQuery').value; // 검색어 가져오기
    const tbody = document.querySelector('.list-table tbody');
    tbody.innerHTML = ''; // 기존 내용을 비움

    // noticeList 출력
    if (map.noticeList && map.noticeList.length > 0) {
        map.noticeList.forEach(notice => {
            const tr = document.createElement('tr');
            tr.innerHTML = `
                <td>${notice.noticeNo}</td>
                <td>
                    <a href="/notice/${notice.noticeNo}">
                        ${notice.noticeType == 1 ? '[안내]' : notice.noticeType == 2 ? '[새기능 안내]' : '[정책 변경 안내]'} ${notice.noticeTitle}
                    </a>
                    ${notice.noticeCommentView == 1 ? `[${notice.commentCount}]` : ''}
                </td>
                <td>${notice.createDate}</td>
                <td>
                    ${notice.fileList.map(file => file.fileOrder == 0 ? '<span><i class="fa-solid fa-file-lines"></i></span>' : '').join('')}
                </td>
                <td>${notice.readCount}</td>
            `;
            tbody.appendChild(tr); // tbody에 추가
        });
    } else {
        console.log("noticeList가 없습니다.");
    }

    // 페이지네이션 처리
    const paginationArea = document.getElementById('paginationArea');
    paginationArea.innerHTML = ''; // 기존 내용을 비움

    if (map.pagination) {
        let paginationHtml = `
            <ul class="pagination">
                <li><a href="#" data-cp="1">&lt;&lt;</a></li>
                <li><a href="#" data-cp="${map.pagination.prevPage}">&lt;</a></li>
        `;

        for (let i = map.pagination.startPage; i <= map.pagination.endPage; i++) {
            if (i === map.pagination.currentPage) {
                paginationHtml += `<li><a class="current">${i}</a></li>`;
            } else {
                paginationHtml += `<li><a href="#" data-cp="${i}">${i}</a></li>`;
            }
        }

        paginationHtml += `
                <li><a href="#" data-cp="${map.pagination.nextPage}">&gt;</a></li>
                <li><a href="#" data-cp="${map.pagination.maxPage}">&gt;&gt;</a></li>
            </ul>
        `;
        paginationArea.innerHTML = paginationHtml;

        // 페이지네이션 링크에 클릭 이벤트 추가
        document.querySelectorAll('.pagination a').forEach(link => {
            link.addEventListener('click', function (e) {
                e.preventDefault();
                const cp = this.getAttribute('data-cp');
                loadPageComment(cp, searchQuery); // 페이지 이동
            });
        });
    }
}

// 페이지네이션 시 데이터 로드 (조회순)
function loadPage(cp) {
    const searchQuery = document.getElementById('searchQuery').value; // 검색어 가져오기
    const url = searchQuery ? `/notice/arrayRead?cp=${cp}&query=${searchQuery}` : `/notice/arrayRead?cp=${cp}`;
    
    fetch(url)
        .then(response => response.json())
        .then(map => {
            updateNoticeTableRead(map);
        })
        .catch(err => console.log(err));
}

// 페이지네이션 시 데이터 로드 (댓글순)
function loadPageComment(cp) {
    const searchQuery = document.getElementById('searchQuery').value; // 검색어 가져오기
    const url = searchQuery ? `/notice/arrayComment?cp=${cp}&query=${searchQuery}` : `/notice/arrayComment?cp=${cp}`;
    
    fetch(url)
        .then(response => response.json())
        .then(map => {
            updateNoticeTableComment(map);
        })
        .catch(err => console.log(err));
}

