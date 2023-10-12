<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head> 
 
    <title>프로젝트 공지사항</title>
  
<%@ include file="/WEB-INF/views/header/headerIncludeLink.jsp"%>
 
 
 
</head>
<body>

 
<%@ include file="/WEB-INF/views/header/header.jsp"%>
	
 
	
	
	<!-- 게시판 -->
	<div class="container mt-5" style="height: auto;
  min-height: 80%;
  padding-bottom:150px;">
		<h4 class="text-info text-center">공지사항</h4>
		<form action="/noticeboard" class="w-100" name="search"
							method="get" onsubmit="return searchCheck()">
							<div class="col-md-5 mb-3 d-flex justify-content-end offset-md-7">
								<input class="form-control " type="search"
									placeholder="Search" aria-label="Search" name="keyWord">
								<button class="btn btn-2 col-md-3" type="submit">검색</button>
 
							</div>
		<div class="table-responsive">
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
 
							<!--레코드가 없다면  -->
									<c:if test="${count==0}">
										<tr>
											<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
										</tr>
									</c:if>
									<c:forEach var="notice" items="${list}">
										<c:if test="${notice.n_important==1}">
										<tr class="danger" onclick="location.href='/noticeboardDetail?noti_board_id=${notice.noti_board_id}'" style="cursor:hand">
										<td class="text-danger">${notice.noti_board_id}</td>
											<td class="text-danger">${notice.n_title}</td>
											<td class="text-danger">${notice.manager_id}</td>
											<td class="text-danger">${notice.n_regdate}</td>
											<td>${notice.n_count}</td>
										</tr>
										</c:if>
									<c:if test="${notice.n_important==2}">
										<tr onclick="location.href='/noticeboardDetail?noti_board_id=${notice.noti_board_id}'"  style="cursor:hand">
										<td>${notice.noti_board_id}</td>
											<td>${notice.n_title}</td>
											<td>${notice.manager_id}</td>
											<td>${notice.n_regdate}</td>
											<td>${notice.n_count}</td>
										</tr>
										</c:if>
											
									</c:forEach>

			</table>


			<hr>
 

									   
					<!--페이지네이션 시작 -->
					${pagingHtml}
					<!-- 페이지네이션 끝 -->

			
		</div>
		</form>
	</div>

<footer>

 	<%@ include file="/WEB-INF/views/footer/footer.jsp"%>
</footer>
    
 
</body>
</html>