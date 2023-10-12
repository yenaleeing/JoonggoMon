<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>프로젝트 자유게시판</title>


<%@ include file="/WEB-INF/views/header/headerIncludeLink.jsp"%>
    <script>
		    function toggleEditMode(cmntId) {
		    	console.log('toggleEditMode called for comment:', cmntId);
		        const contentDiv = document.getElementById('contentDiv_' + cmntId);
		        const editDiv = document.getElementById('editDiv_' + cmntId);
		        const editTextarea = document.getElementById('editTextarea_' + cmntId);
		
		        if (contentDiv && editDiv && editTextarea) {
		            contentDiv.style.display = 'none';
		            editDiv.style.display = 'block';
		            editTextarea.value = contentDiv.innerText;
		        }
		    }
        
		    function saveComment(cmntId) {
		        const contentDiv = document.getElementById('contentDiv_' + cmntId);
		        const editDiv = document.getElementById('editDiv_' + cmntId);
		        const editTextarea = document.getElementById('editTextarea_' + cmntId);

		        if (contentDiv && editDiv && editTextarea) {
		           

		            if (editTextarea) {
		            	
		                const newContent = editTextarea.value;

		                $.ajax({
		                    url: '/member/editComment/editcomment.do',
		                    type: 'POST',
		                    dataType: 'text',  // 예상 응답 데이터 타입
		                    data: {
		                        cmnt_id: cmntId,
		                        c_contents: newContent
		                    },
		                    success: function(response) {
		                        if (response === 'success') {
		                            // 댓글 수정 성공 시 실행할 코드
		                            // 예를 들어, 화면 갱신 등을 수행합니다.
		                           contentDiv.innerText = newContent; // 원본 내용 업데이트
                     			   contentDiv.style.display = 'block'; // 원본 표시
                        		   editDiv.style.display = 'none'; // 수정 폼 숨기기
		                        } else {
		                            // 댓글 수정 실패 시 실행할 코드
		                        }
		                    },
		                    error: function(xhr, status, error) {
		                        // 에러 처리
		                    }
		                });
		                
		                
		             
		            }
		          
		        }
		    }
		    
        
		    function cancelEdit(cmntId) {
		        const contentDiv = document.getElementById('contentDiv_' + cmntId);
		        const editDiv = document.getElementById('editDiv_' + cmntId);

		        if (contentDiv && editDiv) {
		            contentDiv.style.display = 'block';
		            editDiv.style.display = 'none';
		        }
		    }
        
        function deleteComment(cmntId) {
		            if (confirm('댓글을 삭제하시겠습니까?')) {
					        $.ajax({
					            url: '/path/to/deleteComment', // 댓글 삭제를 처리하는 URL로 수정
					            type: 'POST',
					            dataType: 'text', // 예상 응답 데이터 타입
					            data: {
					                cmnt_id: cmntId
					            },
					            success: function(response) {
					                if (response === 'success') {
					                    updateCommentList();
					                } else {
					                    // 댓글 삭제 실패 시 실행할 코드
					                    // 이 부분을 채워주세요.
					                }
					            },
					            error: function(xhr, status, error) {
					                // 에러 처리
					                console.error(error);
					            }
					        });
					    }
        }
        
        function updateCommentList() {
            $.ajax({
                url: '/path/to/getCommentList', // 댓글 목록을 가져오는 URL로 수정
                type: 'GET',
                dataType: 'json',
                data: {
                    board_id: $('#board_id').val()
                },
                success: function(response) {
                    const commentContainer = $('.card-body'); // 댓글 컨테이너 선택
                    commentContainer.empty(); // 기존 댓글 비우기

                    response.forEach(function(comment) {
                     
               var user_id = '<%=session.getAttribute("user_id") %>';
               
               const canEditAndDelete = user_id === comment.user_id;

               const editButtonsHtml = canEditAndDelete
                   ? `<div>
                          <a type="button" class="btn btn-sm btn-primary me-1 mt-2 mb-2" onclick="toggleEditMode(`+comment.cmnt_id+`)">수정</a>
                          <a type="button" class="btn btn-sm btn-danger" onclick="deleteComment(`+comment.cmnt_id+`)">삭제</a>
                      </div>`
                   : '';

                      
                const commentHtml = `
                    <!-- Single comment -->
                    <div class="d-flex mb-3">
                        <div class="d-flex col-md-10">
                            <div class="flex-shrink-0">
                                <img class="rounded-circle" src="<c:url value='/profilePic/'/>"`+comment.u_picture+`"" alt="..." width="50px" height="50px" />
                            </div>
                            <div class="ms-3">
                                <div class="fw-bold">`+comment.user_id+`</div>
                                <div id="contentDiv_`+comment.cmnt_id+`" class="content-div">`+comment.c_contents+`</div>
                                <div id="editDiv_`+comment.cmnt_id+`" class="edit-div" style="display: none;">
                                    <textarea id="editTextarea_`+comment.cmnt_id+`" class="form-control" style="width:700px">`+comment.c_contents+`</textarea>
                                    <div class="mt-2">
                                        <button type="button" class="btn btn-sm btn-primary me-1" onclick="saveComment(`+comment.cmnt_id+`)">저장</button>
                                        <button type="button" class="btn btn-sm btn-secondary" onclick="cancelEdit(`+comment.cmnt_id+`)">취소</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="d-flex align-items-center">
                            <div class="me-2"><b>작성 날짜 : `+comment.c_regdate+`</b></div>
                           
                            `+editButtonsHtml+`
                            
                        </div>
                    </div>
                `;
                        commentContainer.append(commentHtml);
                    });
                },
                error: function(xhr, status, error) {
                    console.error(error);
                }
            });
        }
        
        
        
        function submitComment() {
        	
        	
            const boardId = document.getElementById('board_id').value;
            const cContents = document.getElementById('c_contents').value;
            const user_id = '<%= session.getAttribute("user_id") %>';  
 	
      
            if (user_id != null) {
            // Ajax 요청을 보냅니다.
            $.ajax({
                url: '/member/writecomment/writecomment.do',
                type: 'POST',
                dataType: 'text',
                data: {
                    board_id: boardId,
                    c_contents: cContents
                },
                success: function(response) {
                    if (response === 'success') {
                        // 댓글 등록 성공 시 실행할 코드
                        // 예를 들어, 댓글 목록 갱신 등을 수행합니다.
                        // 이 부분을 채워주세요.
                        // 댓글 등록 성공 시 댓글 리스트 갱신
                        updateCommentList();
                        
                    } else {
                        // 댓글 등록 실패 시 실행할 코드
                        // 이 부분을 채워주세요.
                        alert("로그인을 먼저해주세요!")
                    }
                },
                error: function(xhr, status, error) {
                    // 에러 처리
                    console.error(error);
                }
            });
            
        }else{
        	 // 세션이 없는 경우 처리 (예: 알림창 띄우기 등)
            alert("세션이 없습니다. 로그인이 필요합니다.");
        }
     }
        $(document).ready(function() {
        	  // 페이지 로딩 시 댓글 리스트 초기화
            updateCommentList();
        });
     
    </script>

</head>
<body>

	<%@ include file="/WEB-INF/views/header/header.jsp"%>
	
	
	<!-- 시작 -->
	<!-- 상단 버튼 -->
	<div class="container">
	<h4 class="text-info text-center mt-5">자유게시판</h4>
	 	<% if(session.getAttribute("user_id") != null){ %>
		<a class="btn btn-secondary btn-sm" href="/member/editBoard?board_id=${notice.board_id}" role="button">수정</a>
		<!-- 삭제하기 구현 -->
		<a class="btn btn-secondary btn-sm" href="/member/deleteBoard.do?board_id=${notice.board_id}" role="button">삭제</a>
		 <%} %>
				<!-- <div class="modal fade" id="deleteModal" tabindex="-1"
					aria-labelledby="deleteModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="deleteModalLabel">게시물 삭제</h5>
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">게시물을 삭제하시겠습니까 ?</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">닫기</button>
								<button type="button" class="btn btn-danger"
									onclick="deleteBoard()">확인</button>
							</div>
						</div>
					</div>
				</div> -->

		<a class="btn btn-light pull-right btn-sm" href="normalboard" role="button">목록</a>
		<a class="btn btn-light pull-right btn-sm" href="#" role="button">▾다음글</a>
		<a class="btn btn-light pull-right btn-sm" href="#" role="button">▴이전글</a>
	
	</div>
	
	<!-- 글 정보 -->
	<div class="container"> <!-- div class="container-fluid" -->
		<h3 class="article_title mt-3">제목 : ${notice.b_name}</h3>
			<div class="writerInfo" class="nickname">작성자 : ${notice.user_id}</div>
				<div class="article_info" align="right">
					<span class="date">작성날짜 : ${notice.b_regdate}</span>
					<span class="count">조회 : ${notice.count}</span>
				</div>
				
				<hr>
	
	</div>
	
	<!-- 사진 -->
	<div class="container">


		<div class="article_content">
			<c:forEach var="imgList" items="${imgList}">
				<img src="<c:url value = '/normalboardPic/'/>${imgList.board_filename}" width="300px" height="300px" />
			</c:forEach>

			${notice.b_content}
		</div>

		<hr>
	<br>
	
	<!-- 댓글 창 -->
	<div class="article_comment">
	 <!-- Comments section-->
                    <section class="mb-5">
                        <div class="card">
                            <div class="card-body">
 		 
                            </div>
                                                      <!-- Comment form-->
                                <h5>Comment:</h5>
                                <form class="mb-4" >
                                <input type="hidden" name="board_id" id="board_id" value="${notice.board_id}" />
                                <textarea class="form-control" rows="3" placeholder="Join the discussion and leave a comment!" name="c_contents" id="c_contents"></textarea>
                               	<input type="button" class="btn btn-primary pull-right mt-2" onclick="submitComment()" value="댓글 등록"/>
                                </form>
                        </div>
                        
                    </section>
	</div>
	
	</div>

</body>
 
</html>