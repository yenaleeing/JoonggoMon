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

<title>중고몬 관리자페이지</title>


<%@ include file="/WEB-INF/views/admin/header/headerIncludeLink.jsp"%>

</head>




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
						<h1 class="h3 mb-0 text-gray-800">게시판 상세내용</h1>
					</div>

					<div class="alert alert-success d-none" role="alert">
						This is a warning alert—check it out!
						<button type="button" class="close">&times;</button>
					</div>


					<div class="d-flex justify-content-end">
						<a class="btn btn-primary mr-2" href="editNotiBoard?noti_board_id=${notice.noti_board_id}" role="button">수정</a> 
						<a
							class="btn btn-primary pull-right"
							href="/admin/noticeboard" role="button">목록</a> <a
							class="btn btn-default pull-right" href="#" role="button">▾다음글</a>
						<a class="btn btn-default pull-right" href="#" role="button">▴이전글</a>

					</div>
					<br>

					<h3 class="article_title">제목 : ${notice.n_title}</h3>

					<!-- 작성자 누르면 해당 회원으로 넘어갈 수 있게 하고싶습니다
      <button id="writerInfo" class="nickname">작성자</button>
    -->
					<div class="writerInfo" class="nickname">작성자 : ${notice.manager_id}</div>
			
					<div class="article_info" align="right">
						<span class="date">작성날짜 : ${notice.n_regdate}</span> <span class="count">조회
							${notice.n_count}</span>
					</div>

					<hr>
				</div>
				<br>
				<br>


				<!-- 사진 -->
				<div class="container">

 
					<div class="article_content">
								<c:forEach var="imgList" items="${imgList}">
								<img src =	"<c:url value = '/noticeboardPic/'/>${imgList.n_imgname}" width="300px" height="300px"/>	 
								</c:forEach>
									
									
						 ${notice.n_contents}
					</div>

		  

				</div>
			</div>


		</div>
	</div>
</body>

</html>