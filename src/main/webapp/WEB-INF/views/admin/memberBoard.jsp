<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title></title>



<%@ include file="/WEB-INF/views/admin/header/headerIncludeLink.jsp"%>

<script>
var noti_board_id = "";

$(document).ready(function() {     
    $('#deleteModal').on('show.bs.modal', function(event) {          
    	noti_board_id = $(event.relatedTarget).data('notifyid');
    	console.log($(event.relatedTarget).data('notifyid'));
    });
});

function deleteNotiBoard(){
	location.href='deleteNotiBoard.do?noti_board_id='+noti_board_id;
}

</script>
</head>

<!-- Modal -->
<div class="modal fade" id="archiveModal" tabindex="-1"
	aria-labelledby="archiveModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="archiveModalLabel">게시물 숨기기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">게시물을 숨기시겠습니까 ?</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-danger">확인</button>
			</div>
		</div>
	</div>
</div>


<!-- Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1"
	aria-labelledby="deleteModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="deleteModalLabel">게시물 삭제</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">게시물을 삭제하시겠습니까 ?</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-danger" onclick="deleteNotiBoard()" >확인</button>
			</div>
		</div>
	</div>
</div>


<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

<%@ include file="/WEB-INF/views/admin/header/sidebar.jsp"%>


		<!-- Content -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">
		<%@ include file="/WEB-INF/views/admin/header/header.jsp"%>

				<!-- Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">${sessionScope.managerid}</h1>
					</div>

					<div class="alert alert-success d-none" role="alert">
						This is a warning alert—check it out!
						<button type="button" class="close">&times;</button>
					</div>


					<!-- Table -->
					<div class="row">
						<form action="/admin/member" class="w-100" name="search"
							method="get" onsubmit="return searchCheck()">

							<div class="d-flex justify-content-end">
								<input class="form-control col-md-2" type="search"
									placeholder="Search" aria-label="Search" name="keyWord">
								<button class="btn btn-outline-success" type="submit">Search</button>
							</div>
							<br>
							<table class="table table-hover">

								<thead>
									<tr>
										<th scope="col">아이디</th>
										<th scope="col">이름</th>
										<th scope="col">이메일</th>
										<th scope="col">생일</th>
										<th scope="col">회원 정보 수정 및 삭제</th>
									</tr>
								</thead>

								<tbody>
									<!--레코드가 없다면  -->
									<c:if test="${count==0}">
										<tr>
											<td colspan="5" align="center">등록된 회원이 없습니다.</td>
										</tr>
									</c:if>
									<c:forEach var="member" items="${list}">
										<tr>
											<td>${member.user_id}</td>
											<td>${member.u_name}</td>
											<td>${member.email}</td>											
											<td>${member.birthdate}</td>
											<td>
												<input type="button" class="btn btn-outline-primary" value="회원정보 수정" onClick="location.href='/admin/memberEdit'"> 
												<button type="button" class="btn btn-outline-warning"
													data-toggle="modal" data-target="#archiveModal">비활성화</button>
												<button type="button" class="btn btn-outline-danger"
													data-toggle="modal" data-target="#deleteModal" data-notifyid = "${member.user_id}">삭제</button>
											</td>
										</tr>
									</c:forEach>

								</tbody>
							</table>
						</form>
						 <!-- 회원추가  버튼 넣기 -->
						<!--<a class="btn btn-primary ml-auto" href="writeBoard"
							role="button">회원추가</a> -->


					</div>

				   
					<!--페이지네이션 시작 -->
					${pagingHtml}
					<!-- 페이지네이션 끝 -->
			 
				</div>
			</div>
		</div>
	</div>
</body>

</html>