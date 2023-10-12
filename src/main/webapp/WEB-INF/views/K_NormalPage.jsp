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


</head>
<body>

	<%@ include file="/WEB-INF/views/header/header.jsp"%>



	<!-- 게시판 -->
	<div class="container mt-5" style="height: auto;
  min-height: 80%;
  padding-bottom:150px;">
		<h4 class="text-info text-center">자유게시판</h4>
		<div class="table-responsive">
			
			
			<form action="normalboard" class="w-100" name="search"
							method="get" onsubmit="return searchCheck()">

										<div class="col-md-5 mb-3 d-flex justify-content-end offset-md-7">
								<input class="form-control " type="search"
									placeholder="Search" aria-label="Search" name="keyWord">
								<button class="btn btn-2 col-md-3" type="submit">검색</button>
 
							</div>
			</form>

			<table class="table table-bordered table-hover">
				<thead>
					<tr class="active">
						<td>번호</td>
						<td>제목</td>
						<td>작성자</td>
						<td>날짜</td>
						<td>조회수</td>
					</tr>
				</thead>
				<tbody>
					<!--레코드가 없다면  -->
					<c:if test="${count==0}">
						<tr>
							<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
						</tr>
					</c:if>

					<!-- 레코드가 있다면 -->
					<c:forEach var="notice" items="${list}">
						<tr onclick="location.href='detailBoard.do?board_id=${notice.board_id}' ">
							<td>${notice.board_id}</td>
							<td>${notice.b_name}</td>
							<td>${notice.user_id}</td>
							<td>${notice.b_regdate}</td>
							<td>${notice.count}</td>

						</tr>
					</c:forEach>

				</tbody>
			</table>


			<hr>
			<!-- 글쓰기 버튼 넣기 -->
			<a class="btn btn-primary pull-right" href="/member/writeBoard" role="button">글쓰기</a>



			<!--페이지네이션 시작 -->
				${pagingHtml}
			<!-- 페이지네이션 끝 -->


		</div>

	</div>

	<footer>
		<%@ include file="/WEB-INF/views/footer/footer.jsp"%>
	</footer>


	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>