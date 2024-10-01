<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="comment-area">
    <!-- 댓글 목록 -->
    <div class="comment-list-area">
        <ul id="commentList">
            <!-- commentDeleteFlag == 3인 댓글이 있는지 확인 -->
            <c:set var="hasFixedComment" value="false" />
            <c:forEach items="${notice.commentList}" var="comment">
                <c:if test="${comment.commentDeleteFlag == 3}">
                    <c:set var="hasFixedComment" value="true" />
                </c:if>
            </c:forEach>

        <!-- 고정된 댓글 출력 -->
        <c:forEach items="${notice.commentList}" var="comment">
            <c:if test="${comment.commentDeleteFlag == 3}">
                <li class="comment-row topComment">
                    <div class="comment-writer">
                        <c:choose>
                            <c:when test="${comment.role != 'U'}">
                                <img src="/resources/images/common/admin_profile.png" id="image">
                            </c:when>
                            <c:otherwise>
                                <c:if test="${empty comment.profileImage}">
                                    <img src="/resources/images/common/user.png" id="image">
                                </c:if>
                                <c:if test="${!empty comment.profileImage}">
                                    <img src="${comment.profileImage}" id="image">
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                        <div class="comment-text-area">
                            <span>${comment.userName}</span>
                            <span class="comment-date">(${comment.commentCreateDate})</span>
                            <c:if test="${loginUser.role != 'U'}">
                                <c:choose>
                                    <c:when test="${hasFixedComment}">
                                        <button onclick="commentFixDisabled(${comment.commentNo}, this)" class="fixBtn">
                                            <i class="fa-solid fa-thumbtack-slash" id="commentFixDisable"></i>
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button onclick="commentFixd(${comment.commentNo}, this)" class="fixBtn">
                                            <i class="fa-solid fa-thumbtack" id="commentFix"></i>
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                            <span class="fixText">관리자가 고정한 댓글입니다.</span>
                        </div>
                    </div>
                    <p class="comment-content">${comment.commentContent}</p>
                    <div class="comment-btn-area">
                        <c:if test="${loginUser.userNo == comment.userNo}">
                            <button onclick="showInsertComment(${comment.commentNo}, this)">답글</button>
                            <button onclick="showUpdateComment(${comment.commentNo}, this)">수정</button>
                            <button onclick="deleteComment(${comment.commentNo})">삭제</button>
                        </c:if>
                        <c:if test="${loginUser.userNo != comment.userNo}">
                            <button onclick="showInsertComment(${comment.commentNo}, this)">답글</button>
                            <c:if test="${loginUser.role != 'U'}">
                                <button onclick="deleteComment(${comment.commentNo})">삭제</button>
                            </c:if>
                        </c:if>
                    </div>
                </li>
            </c:if>
        </c:forEach>

        <!-- 일반 댓글 출력 -->
        <c:forEach items="${notice.commentList}" var="comment">
            <c:if test="${comment.commentDeleteFlag == 2}">
                <li class="comment-row addcolor">삭제된 댓글입니다.</li>
            </c:if>

            <c:if test="${comment.commentDeleteFlag == 1 || (comment.commentDeleteFlag == 3 && hasFixedComment)}">
                <!-- 고정 댓글인 경우 topComment 클래스 추가 -->
                <li class="comment-row <c:if test='${comment.parentNo != 0}'>child-comment</c:if> <c:if test='${comment.commentDeleteFlag == 3}'>topComment</c:if>">
                    <div class="comment-writer">
                        <c:choose>
                            <c:when test="${comment.role != 'U'}">
                                <img src="/resources/images/common/admin_profile.png" id="image">
                            </c:when>
                            <c:otherwise>
                                <c:if test="${empty comment.profileImage}">
                                    <img src="/resources/images/common/user.png" id="image">
                                </c:if>
                                <c:if test="${!empty comment.profileImage}">
                                    <img src="${comment.profileImage}" id="image">
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                        <div class="comment-text-area">
                            <span>${comment.userName}</span>
                            <span class="comment-date">(${comment.commentCreateDate})</span>
                            
                            <!-- 로그인한 사용자의 역할이 U가 아닌 경우 고정 버튼을 표시 -->
                            <c:if test="${loginUser.role != 'U' && !hasFixedComment}">
                                <button onclick="commentFixd(${comment.commentNo}, this)" class="fixBtn">
                                    <i class="fa-solid fa-thumbtack" id="commentFix"></i>
                                </button>
                            </c:if>
                            <c:if test='${comment.commentDeleteFlag == 3}'>
                                <span class="fixText">관리자가 고정한 댓글입니다.</span>
                            </c:if>
                        </div>
                    </div>
                    <p class="comment-content">${comment.commentContent}</p>
                    <div class="comment-btn-area">
                        <c:if test="${loginUser.userNo == comment.userNo}">
                            <button onclick="showInsertComment(${comment.commentNo}, this)">답글</button>
                            <button onclick="showUpdateComment(${comment.commentNo}, this)">수정</button>
                            <button onclick="deleteComment(${comment.commentNo})">삭제</button>
                        </c:if>
                        <c:if test="${loginUser.userNo != comment.userNo}">
                            <c:if test="${loginUser.role != 'U'}">
                                <button onclick="deleteComment(${comment.commentNo})">삭제</button>
                            </c:if>
                            <button onclick="showInsertComment(${comment.commentNo}, this)">답글</button>
                        </c:if>
                    </div>
                </li>
            </c:if>
        </c:forEach>


        </ul>
    </div>
    
    <!-- 댓글 작성 부분 -->
    <div class="comment-write-area">
        <textarea id="commentContent"></textarea>
        <button id="addComment">댓글<br>등록</button>
    </div>
</div>
