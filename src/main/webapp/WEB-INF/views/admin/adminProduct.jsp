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
var pro_num = "";

$(document).ready(function() {     
    $('#deleteModal').on('show.bs.modal', function(event) {          
    	pro_num = $(event.relatedTarget).data('productid');
    	console.log($(event.relatedTarget).data('productid'));
    });
});

function deleteProduct(){
	location.href='deleteProduct.do?pro_num='+pro_num;
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
				<button type="button" class="btn btn-danger" onclick="deleteProduct()" >확인</button>
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
						<form action="/admin/adminProduct" class="w-100" name="search"
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
										<th scope="col">번호</th>
										<th scope="col">제목</th>
										<th scope="col">작성자</th>
										<th scope="col">날짜</th>
										<th scope="col">금액</th>
										<th scope="col">조회수</th>
										<th scope="col">글보기 / 수정 및 삭제</th>
									</tr>
								</thead>

								<tbody>
									<!--레코드가 없다면  -->
									<c:if test="${count==0}">
										<tr>
											<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
										</tr>
									</c:if>
									<c:forEach var="product" items="${list}">
										<tr>
											<td>${product.pro_num}</td>
											<td>${product.p_title}</td>
											<td>${product.user_id}</td>
											<td>${product.p_regdate}</td>
											<td>${product.p_price}</td>
											<td>${product.p_count}</td>
											<td>
												<button type="button" class="btn btn-outline-primary" onclick="location.href='/admin/editProduct.do?pro_num=${product.pro_num}' ">글 수정</button>
												<button type="button" class="btn btn-outline-warning"
													data-toggle="modal" data-target="#archiveModal">숨기기</button>
												<button type="button" class="btn btn-outline-danger"
													data-toggle="modal" data-target="#deleteModal" data-productid = "${product.pro_num}">삭제</button>
											</td>
										</tr>
									</c:forEach>

								</tbody>
							</table>
						</form>
						<!-- 글쓰기 버튼 넣기 -->



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