
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>중고몬 물품게시판 메인페이지</title>

<!-- 찜 하트아이콘 cdn -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<%@ include file="/WEB-INF/views/header/headerIncludeLink.jsp"%>


</head>
<style>
.main-wrap {
	max-width: 1000px;
	width: calc(100% - 25px);
	margin: 0 auto;
}

.main-hr {
	border: 1px solid black;
	opacity: 1;
}

.main-title {
	margin-top: 50px !important;
	font-size: 26px;
	font-weight: 400;
}

.card-img-top {
	cursor: pointer;
}

.bi-heart, .bi-heart-fill {
	font-size: 18px;
	line-height: 18px;
	color: crimson;
	margin-left: 120px;
}

.bi-heart:hover {
	font-size: 18px;
	line-height: 18px;
	color: cadetblue;
}
/* 페이지네이션 색상변경 */
.page-link {
	color: #000;
	background-color: #fff;
	border: 1px solid #ccc;
}

/* .page-item.active, .page-link {
 		z-index: 1;
 		color: #555;
 		font-weight:bold;
 		background-color: #f1f1f1;
 		border-color: #ccc;
	}
 	볼드하게 넣고싶으면 주석 풀기 */
.page-link:focus, .page-link:hover {
	color: #fff;
	background-color: crimson;
	border-color: #ccc;
}

.pagination {
	margin-top: 20px;
}

.fcolor {
	color: crimson;
}

.col-md-4 {
	margin-bottom: 20px;
}

/* card 높이 균일하게 설정 */
.card-title {
   text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
}
.carousel-item img {
	height:100%
}
</style>

<body>

	<%@ include file="/WEB-INF/views/header/header.jsp"%>


	<div class="main-wrap">
		<p class="main-title">중고몬 판매 상품</p>
		<hr class="main-hr">

		<div>
			<!-- 카테고리 드롭다운 시작 -->
<div class="col-md-12 d-flex justify-content-between">
    <!-- 카테고리 드롭다운 -->
    <div class="dropdown p-2">
        <form action="productMain.do" class="d-flex" name="category" method="get">
            <div class="dropdown">
                <button class="btn btn-2 dropdown-toggle" type="button"
                        data-bs-toggle="dropdown" aria-expanded="false" value="all">카테고리</button>
                <ul class="dropdown-menu">
                    <c:forEach var="category" items="${categoryList}" varStatus="status">
                        <a href="productMain.do?category=${category.pro_category_id}" class="category-link" data-category-id="${category.pro_category_id}">
                            <li class="dropdown-item" value="${category.pro_category_id}">
                                <c:out value="${category.pro_category}" />
                            </li>
                        </a>
                    </c:forEach>
                </ul>
            </div>
        </form>
    </div>
    
    <!-- 검색창 -->
	    <nav class="navbar col-md-4">
	        <div>
	            <form action="productMain.do" class="d-flex" name="search" method="get" onsubmit="return searchCheck()">
	                <input name="keyWord" class="form-control me-2" type="search" placeholder="검색어를 입력하세요." aria-label="Search">
	                <input type="submit" value="찾기" class="btn btn-danger">
	            </form>
	        </div>
	    </nav>
</div>
         <!-- 카테고리 드롭다운 끝 -->
			


			<!-- 판매하기버튼 -->
			<%
			if (session.getAttribute("user_id") == null) {
			%>
			<a href="productUpload" class="btn btn-2 float-end" role="button" aria-disabled="true">판매하기</a>
				
			<%
			} else {
			%>
			<a href="productUpload" class="btn btn-2 float-end" role="button" aria-disabled="true">판매하기</a>
			<%
			}
			%>
			<!-- 판매하기버튼 끝 -->

		</div>
		<p>
			<!-- 카테고리 드롭다운 끝 -->
			<!--상품리스트 카드 컨테이너 시작-->

			<!--레코드가 없다면  -->
			<c:if test="${count==0}">
				<tr>
					<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
				</tr>
			</c:if><div class="container row">



			<!-- 카드그리드 시작 -->
			<div class="row row-cols-2 row-cols-md-3 g-2">
				<!-- 카드리스트 시작 -->
				<c:forEach var="product" items="${list}">
					<div class="col-md-4">
						<div class="card">
							 <div class="embed-responsive embed-responsive-4by3">
							 <img src = "<c:url value = '/productImg/'/>${product.p_imgname}" class="card-img-top embed-responsive-item"/>
							  </div>
							<div class="card-body">
								<h5 class="card-title">${product.p_title}</h5>
								<p class="card-text"><fmt:formatNumber value="${product.p_price}" pattern="#,###,###,###"/>원</p>
								<a href="/productDetail.do?pro_num=${product.pro_num}"
									class="btn btn-outline-danger fcolor" role="button"> 상세 보기</a>
								 
							</div>

						</div>
					</div>
				</c:forEach>
				<!-- 카드리스트 끝 -->

			</div>
			<!-- 카드그리드 끝 -->

			${pagingHtml}

			<!-- 페이지네이션  -->
			<%-- 	<nav aria-label="Page navigation example">
	<ul class="pagination justify-content-center"><!-- 링크문자열(이전,현재블럭,다음) -->
		<li class="page-item" align="center" colspan="5">${pagingHtml}</li>
	</ul>
	</nav> --%>
			<!-- 페이지네이션 끝 -->
			<!-- 		
		페이지네이션 시작
	<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
    <li class="page-item"><a class="page-link" href="#">1</a></li>
    <li class="page-item"><a class="page-link" href="#">2</a></li>
    <li class="page-item"><a class="page-link" href="#">3</a></li>
    <li class="page-item"><a class="page-link" href="#">4</a></li>
    <li class="page-item"><a class="page-link" href="#">5</a></li>
    <li class="page-item">
      <a class="page-link" href="#" aria-label="Next">
        <span aria-hidden="true">&raquo;</span>
      </a>
    </li>
  </ul> 
</nav>
	페이지네이션 끝  -->

		</div>
		<!-- 상품리스트 카드 컨테이너 끝 -->
	</div>

	<footer>

		<%@ include file="/WEB-INF/views/footer/footer.jsp"%>
	</footer>



 
</body>


</html>