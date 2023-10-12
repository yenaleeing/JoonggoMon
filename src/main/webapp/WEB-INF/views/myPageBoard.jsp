<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Bootstrap Accordion Menu for All Purpose</title>		
   
  
<%@ include file="/WEB-INF/views/header/headerIncludeLink.jsp"%>
 
 
</head>
 
<body>

 <%@ include file="/WEB-INF/views/header/header.jsp"%>


<div class="container mt-5">
 
	<div class="row">
    <%@ include file="/WEB-INF/views/header/myPageSideBar.jsp"%>
		<div class="col-lg-9">
		<h1>내가 쓴 게시물들</h1>
			<table class="table">
  <thead>
    <tr>
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
					<c:forEach var="notice" items="${boardList}">
						<tr onclick="location.href='/detailBoard.do?board_id=${notice.board_id}' ">
							<td>${notice.board_id}</td>
							<td>${notice.b_name}</td>
							<td>${notice.user_id}</td>
							<td>${notice.b_regdate}</td>
							<td>${notice.count}</td>

						</tr>
					</c:forEach>

  </tbody>
</table>
		</div>
	</div>

</div>
<footer class="fixed-bottom">
 <%@ include file="/WEB-INF/views/footer/footer.jsp"%>
</footer>
</body>
</html>