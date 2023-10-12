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
	
	
	<!-- 시작 -->
	<!-- 상단 버튼 -->
	<div class="container">
	<h4 class="text-info text-center mt-5">자유게시판</h4>
	

		<a class="btn btn-light pull-right btn-sm" href="/noticeboard" role="button">목록</a>
		<a class="btn btn-light pull-right btn-sm" href="#" role="button">▾다음글</a>
		<a class="btn btn-light pull-right btn-sm" href="#" role="button">▴이전글</a>
	
	</div>
	
	<!-- 글 정보 -->
	<div class="container"> <!-- div class="container-fluid" -->
		<h3 class="article_title mt-3">제목 : ${notice.n_title}</h3>
			<div class="writerInfo" class="nickname">작성자 : ${notice.manager_id}</div>
				<div class="article_info" align="right">
					<span class="date">작성날짜 : ${notice.n_regdate}</span>
					<span class="count">조회 : ${notice.n_count}</span>
				</div>
				
				<hr>
	
	</div>
	
	<!-- 사진 -->
	<div class="container">


		<div class="article_content">
			<c:forEach var="imgList" items="${imgList}">
				<img src="<c:url value = '/noticeboardPic/'/>${imgList.n_imgname}" width="300px" height="300px" />
			</c:forEach>

			${notice.n_contents}
		</div>

		<hr>
	<br>
	
	
	</div>

</body>
</html>