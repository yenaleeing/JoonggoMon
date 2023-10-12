<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>Template 01 for Bootstrap</title>

 
 
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
</style>
<body>


	<%@ include file="/WEB-INF/views/header/header.jsp"%>


	<section class="banner-sec" id="home">
		<div class="container">
			<div class="jumbotron">
				<h1>원하는 물건들을 검색해 보세요!</h1>
				<h2>중고나라 , 번개장터 , 당근마켓 , 중고몬 에서의 모든 결과를 확인가능합니다.</h2>

				<form class="d-flex" role="search" id="joonggoSearch">
					<div class="searchContainer">
						<input type="text" name="searchContent" class="searchContent"
							placeholder="Search...">
						<div class="search"></div>
					</div>
				</form>
			</div>
		</div>
	</section>

	<section class="four-col-services" id="services">
		<div class="container">
			<div class="row">
				<h2 class="text-center">중고몬 최신 업로드 물건</h2>
				<h4 class="text-center">물건들입니다~</h4>


			<!-- 카드그리드 시작 -->
			<div class="row row-cols-2 row-cols-md-3 g-2">
				<!-- 카드리스트 시작 -->
				<c:forEach var="product" items="${recentProducts}">
					<div class="col-md-4">
						<div class="card">
							 <div class="embed-responsive embed-responsive-4by3">
							 <img src = "<c:url value = '/productImg/'/>${product.p_imgname}" class="card-img-top embed-responsive-item"/>
							  </div>
							<div class="card-body">
								<h5 class="card-title">${product.p_title}</h5>
								<p class="card-text">${product.p_price}원</p>
								<a href="/productDetail.do?pro_num=${product.pro_num}"
									class="btn btn-outline-danger fcolor" role="button"> 상세 보기</a>
								 
							</div>

						</div>
					</div>
				</c:forEach>
				<!-- 카드리스트 끝 -->

			</div>
			<!-- 카드그리드 끝 -->

				<!-- <div
					class="col-lg-4 col-md-4 col-sm-6 text-center service-block down-effect">
					<img src="./vector/당근마켓vec.svg">
					<h3>물건1</h3>
					<p>물건 1</p>
				</div>

				<div
					class="col-lg-4 col-md-4 col-sm-6 text-center service-block up-effect">
					<img src="./vector/번개장터vec.svg">
					<h3>물건2</h3>
					<p>물건2</p>
				</div>
				<br>

				<div
					class="col-lg-4 col-md-4 col-sm-6 text-center service-block down-effect">
					<img src="./vector/중고나라vec.svg">
					<h3>물건3</h3>
					<p>물건3</p>
				</div>
 -->


			</div>
		</div>
	</section>








	<section class="content contact-sec" id="contact">
		<div class="container">


			<div id="carouselExampleIndicators" class="carousel slide"
				data-bs-ride="carousel">
				<div class="carousel-indicators">
					<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="0" class="active" aria-current="true"
						aria-label="Slide 1"></button>
					<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="1" aria-label="Slide 2"></button>
					<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="2" aria-label="Slide 3"></button>
				</div>
				<div class="carousel-inner">
					<div class="carousel-item active">
						<img
							src="https://media.bunjang.co.kr/images/nocrop/1014009653_w1197.jpg"
							class="d-block w-100" alt="...">
					</div>
					<div class="carousel-item">
						<img
							src="https://media.bunjang.co.kr/images/nocrop/1013743833_w1197.jpg"
							class="d-block w-100" alt="...">
					</div>
					<div class="carousel-item">
						<img
							src="https://media.bunjang.co.kr/images/nocrop/1013752024_w1197.jpg"
							class="d-block w-100" alt="...">
					</div>
				</div>
				<button class="carousel-control-prev" type="button"
					data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>


		</div>

	</section>




	<section class="four-col-services" id="services">
		<div class="container">
			<div class="row">
				<h2 class="text-center">벤치마킹</h2>
				<h4 class="text-center">저희 사이트와 연관된 모든 사이트를 나열해두었습니다.</h4>


				<div
					class="col-lg-4 col-md-4 col-sm-6 text-center service-block up-effect">
					<img src="../../resources/img/joonggomon.svg" width="360px" height="360px">
					<h3>About Us</h3>
					<p>Search service combine the second-hands product of
						three-site & Ours</p>
				</div>

				<div
					class="col-lg-4 col-md-4 col-sm-6 text-center service-block down-effect">
					<a href="https://www.daangn.com/"><img src="../../resources/vector/당근마켓vec.svg"></a>
					<h3>당근마켓</h3>
					<p>중고 거래부터 동네 정보까지, 이웃과 함께해요.
					가깝고 따뜻한 당신의 근처를 만들어요.</p>
				</div>

				<div
					class="col-lg-4 col-md-4 col-sm-6 text-center service-block up-effect">
					<a href="https://m.bunjang.co.kr/"><img src="../../resources/vector/번개장터vec.svg"></a>
					<h3>번개장터</h3>
					<p>전국에 있는 내 취향의 브랜드 상품, 
					번개장터에서 더 쉽고 안전하게 거래하세요.</p>
				</div>
				<br>

				<div
					class="col-lg-4 col-md-4 col-sm-6 text-center service-block down-effect">
					<a href="https://web.joongna.com/"><img src="../../resources/vector/중고나라vec.svg"></a>
					<h3>중고나라</h3>
					<p>안전결제를 통한 사기조회와 피해 보상까지, 
					카드결제 가능한 중고나라에서 거래하세요.</p>
				</div>



			</div>
		</div>
	</section>



	<footer>
		<%@ include file="/WEB-INF/views/footer/footer.jsp"%>
	</footer>






</body>
</html>