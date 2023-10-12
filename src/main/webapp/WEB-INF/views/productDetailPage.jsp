<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
 
<%@ include file="/WEB-INF/views/header/headerIncludeLink.jsp"%>

 

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
	<title>중고몬 물품게시판 상품 등록페이지</title>
 
 <!-- 찜 하트아이콘 cdn -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	
</head>
<style>
.main-wrap {
	max-width: 100%;
}

.title-wrap {
	max-width: 1140px;
    width: 100%;
    margin: 0 auto;
    padding-right: 15px;
    padding-left: 15px;
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

.carousel-sizing {
	width: 400px;
	height: 400px;
	border: 1px solid black;
	background: #fff;
}

.carousel-item img {
	width: 100%;
}

.carousel-inner {
	height: 100%;
}

.carousel-item {
	height: 100%;
}

.carousel-indicators button {
	border: 1px solid black !important;
}

.carousel-indicators .active {
	background: crimson !important;
}

/* .carousel-indicators {
    	position:absolute;
    	float:right;
    }
    .productinfo-grid {
    	position:relative;
    	float:left;
    } */
ul li {
	display: inline-block;
}

.product-explain {
	margin-top: 30px;
	margin-bottom: 30px;
}

.carousel-productinfo-wrap {
	display: flex;
	margin-bottom: 40px;
}

.product-info {
	width: calc(100% - 480px);
	margin: 0 40px;
}

.btn-addwishlist {
	margin-left: 30px;
}

.btn-contact {
	margin: 5px 20px;
}

.product-info-labels {
	width: 65px;
	display: inline-block;
	margin-right: 20px;
}
.product-info-ul {
	padding-left: 0;
    display: block;
    text-align: right;
}
.product-info-labels2 {
	color: #808080;
	margin-left: 5px;
	text-align: right;  /* 적용이 안되고있음 */
}

.bi-heart,
.bi-heart-fill {
	font-size: 18px;
	line-height: 18px;
	color: crimson;
}

.bottom-btn {
	text-align: center;
	margin-top: 50px;
	margin-bottom: 50px;
}

button {
	margin: 5px 10px;
}

</style>

<body>

 
<%@ include file="/WEB-INF/views/header/header.jsp"%>

	<div class="main-wrap">
		<!--페이지 제목-->
		<div class="title-wrap">
		<p class="main-title">중고몬 상품 상세페이지</p>
		<hr class="main-hr">
		</div>
		<br>
		<!-- 컨테이너 시작 (상품이미지+상품정보+상품설명) -->
		<div class="container">
			<!-- 캐러셀 시작 (상품이미지) -->
			<div class="carousel-productinfo-wrap">
			<div id="carouselExampleIndicators" class="carousel slide carousel-sizing" data-bs-ride="carousel">
				<div class="carousel-indicators">
					<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0"
						class="active" aria-current="true" aria-label="Slide 1"></button>
					<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"
						aria-label="Slide 2"></button>
					<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"
						aria-label="Slide 3"></button>
					
				</div>
				<div class="carousel-inner">
					
					<c:forEach var="imgList" items="${imgList}" varStatus="loopStatus">
						
					<c:choose>
				        <c:when test="${loopStatus.index == 0}">
				            <!-- 첫 번째 값일 때 -->
				           <div class="carousel-item active">
				               <img src = "<c:url value = '/productImg/'/>${imgList.p_imgname}" class="d-block w-100" />
							</div>
				        </c:when>
				        <c:otherwise>
				            <!-- 나머지 값들일 때 -->
				             <div class="carousel-item ">
				                 <img src = "<c:url value = '/productImg/'/>${imgList.p_imgname}" class="d-block w-100" />
							</div>
				        </c:otherwise>
				    </c:choose>
				
					</c:forEach>
					<!-- 
					<div class="carousel-item">
						<img src="" class="d-block w-100" alt="...">
					</div> -->
								
					
				</div>
				<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>
			<!-- 캐러셀 끝 (상품이미지) -->
			
			<!-- 상품정보란 시작 -->
			
			<div class="product-info">
				<ul class="product-info-ul">
					<li class="product-info-labels2"><b>조회수</b></li>
					<li class="product-info-labels2">${pvo.p_count}</li>
				
					<li class="product-info-labels2"><b>등록일</b></li>
					<li class="product-info-labels2">
						<fmt:formatDate value="${pvo.p_regdate}" pattern="yyyy-MM-dd hh:mm"/>
					</li>
			
					<li class="product-info-labels2"><b>판매자</b></li>
					<li class="product-info-labels2">${pvo.user_id}</li>
				</ul>
				<h3>${pvo.p_title}</h3>
				<h2><fmt:formatNumber value="${pvo.p_price}" pattern="#,###,###,###"/>원</h2>
			
				
				
				
				<hr>
				<ul>
					<li><b class="product-info-labels">카테고리</b></li>
					<li>${pvo.pro_category}</li>
				</ul>
				<ul>
					<li><b class="product-info-labels">상품상태</b></li>
					<li>${pvo.p_state}</li>
				</ul>
				<ul>
					<li><b class="product-info-labels">교환여부</b></li>
					<li>${pvo.p_exchange}</li>
				</ul>
				<ul>
					<li><b class="product-info-labels">배송비</b></li>
					<li>${pvo.p_dfee}</li>
				</ul>
				
				<!-- 찜하기,판매자연락처 (로그인 권한체크) -->	
				<c:if test="${sessionScope.user_id == null}">
				<button type="button" class="btn btn-secondary btn-lg btn-addwishlist" onclick="movePage()"  >찜하기</button>
					
				<!-- 판매자연락처 팝오버  -->
				<button type="button" class="btn btn-secondary btn-lg btn-contact" onclick="movePage()">
					<font style="vertical-align: inherit;">판매자 연락처</font>
				</button>	
					
				</c:if>
				<c:if test="${sessionScope.user_id != null}">
				<button type="button" class="btn btn-danger btn-lg btn-addwishlist" onclick="wishAndContactBtn(this.getAttribute('data-wimg'), this.getAttribute('data-wurl'))"  data-wimg="<c:url value='/productImg/' />${imgList[0].p_imgname}" data-wurl="/productDetail.do?pro_num=${pvo.pro_num}" >찜하기</button>
					
				<!-- 판매자연락처 팝오버  -->
				<button type="button" class="btn btn-danger btn-lg btn-contact" data-bs-toggle="popover" title="판매자 연락처"
					data-bs-content="${pvo.p_contact}" aria-describedby="popover738439">
					<font style="vertical-align: inherit;">판매자 연락처</font>
				</button>
				<!-- 판매자연락처 버튼끝 -->
				</c:if>
				<!-- 찜하기,판매자연락처 끝 -->	
				
				
				
				</div>
				
			</div>
			<!-- 상품정보란 끝 -->
				
			<hr class="main-hr">
				
			<!--상품설명 시작-->
			<div class="product-explain-wrap">
				<h4>상품정보</h4>
				<hr>
				
				<div class="container-sm">
					<P class="product-explain" style="white-space: pre-line;">
					${pvo.p_content}
					</P>
				</div>
			</div>
			<hr>
			<!--상품설명 끝-->
			
			
			<!--수정 삭제 목록 버튼 (로그인 권한체크) -->
			<div class="bottom-btn">
			
				<c:if test="${sessionScope.user_id != pvo.user_id}">
				<button type="button" class="btn btn-danger btn-lg" onclick="location.href='productMain'">목록보기</button>
				
				</c:if>
				<c:if test="${sessionScope.user_id == pvo.user_id}">
				<a href="/member/editProduct?pro_num=${pvo.pro_num}" role="button" class="btn btn-danger btn-lg">수정하기</a>
				<a href="deleteProduct.do?pro_num=${pvo.pro_num}" role="button" class="btn btn-danger btn-lg">삭제하기</a>
				<button type="button" class="btn btn-danger btn-lg" onclick="location.href='productMain'">목록보기</button>
				</c:if>
				
			</div>
			<!--수정 삭제 목록 버튼 끝-->
			
		</div>
		<!-- 컨테이너 끝 (상품이미지+상품정보+상품설명) -->
		<footer>

	<%@ include file="/WEB-INF/views/footer/footer.jsp"%>
</footer>
    



		
		
		<script>
			/* 캐러셀(상품이미지) 동작 함수 */
			var carousel = new bootstrap.Carousel('#carouselExampleIndicators')

			/* 찜버튼 카운트(+1,-1) 동작 함수 */
		    /*
		    var i = 0;
		    var test = Number(document.querySelector('.wishlist-num').innerText)
		    $('.btn-addwishlist').on('click',function(){
		        if(i==0){
		            $('.bi').removeClass('bi-heart');
		            $('.bi').addClass('bi-heart-fill');
					i++;
					document.querySelector('.wishlist-num').innerText =  test += 1

		  		 버튼클릭시 현재 찜카운트+1 -> 재클릭시 -1 
		        }else if(i==1){
		            $('.bi').removeClass('bi-heart-fill');
		            $('.bi').addClass('bi-heart');
		            i--;
		            document.querySelector('.wishlist-num').innerText =  test -= 1
		        }
		    });
		    */
		 
		    function wishAndContactBtn(wImg, wUrl) {
			 
				        
		 

				        // Ajax를 사용하여 데이터를 컨트롤러로 전송
				        $.ajax({
				            type: "POST", 
				            url: "/member/addWishList.do", // 컨트롤러 URL을 여기에 입력
				            data: {
				            	w_img: wImg,
				                w_url: wUrl
				            },
				            success: function (response) {
				            	console.log("AJAX 요청 성공:", response);
				            	alert('찜목록에 추가 되었습니다.');
				            },
				            error: function (error) {
				                // 오류 발생 시 실행될 코드
				            }
				        });
		
		    }
		    
		    /* 찜하기,판매자연락처 버튼 클릭시 로그인권한 체크 */
			function movePage() {
			alert('로그인이 필요합니다.')
			}
		    
		    /* 판매자연락처 팝오버 동작 함수 */
			const popoverTriggerList = document.querySelectorAll('[data-bs-toggle="popover"]')
			const popoverList = [...popoverTriggerList].map(popoverTriggerEl => new bootstrap.Popover(popoverTriggerEl));
		    
		    
		</script>

</body>

</html>