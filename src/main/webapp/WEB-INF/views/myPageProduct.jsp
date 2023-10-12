 <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
   content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Bootstrap Accordion Menu for All Purpose</title>
 
<%@ include file="/WEB-INF/views/header/headerIncludeLink.jsp"%>
 

<style>
@import
   url("https://fonts.googleapis.com/css?family=Poppins:400,500,600,700&display=swap")
   ;

.cards {
   display: flex;
   width: 100%;
}

@media ( min-width : 40rem) {
   .cards {
      width: 50%;
   }
}

@media ( min-width : 56rem) {
   .cards {
      width: 33.3%;
   }
}

.card-container {
   position: relative;
   height: 300px;
   width: 250px;
   background: #f4f4f4;
   border: 1px solid #ddd; /* 테두리 추가 */
   margin-bottom: 20px; /* 아래 여백 추가 */
   overflow: hidden;
   border-radius: 15px;
   box-shadow: 0px 5px 43px rgba(239, 240, 255, 0.25);
   transition: all 0.3s ease;
}

.card-container:hover {
   box-shadow: 0 0 15px 0 rgba(0, 0, 0, 0.2);
}

.card-container .image {
   position: absolute;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   display: flex;
   justify-content: center;
   align-items: center;
}

.card-container .image img {
   height: 75%;
   width: 75%;
   object-fit: cover;
   transition: all 0.3s ease;
}

.card-container:hover .image img {
   transform: scale(1.1);
}

.card-container .card-content {
   position: relative;
   height: 100%;
   width: 100%;
}

.card-content .wrapper {
   position: absolute;
   bottom: -100%;
   width: 100%;
   background: #fff;
   padding: 10px 25px;
   box-shadow: -1px -1px 6px rgba(0, 0, 0, 0.1);
   transition: bottom 0.3s ease;
}

.card-container:hover .card-content .wrapper {
   bottom: 0px;
}

.wrapper {
   text-align: center;
}

.wrapper .title {
   font-size: 22px;
   font-weight: 500;
}

.wrapper p {
   font-size: 17px;
   color: grey;
}

.wrapper .content {
   margin: 10px 0;
}

.wrapper .content .name {
   font-size: 15px;
   text-transform: uppercase;
   font-weight: 500;
}

.wrapper .btns {
   display: flex;
   height: 80px;
   width: 100%;
   align-items: center;
   justify-content: center;
   text-align: center;
}

a {
   text-decoration: none;
}

.btn:hover {
   text-decoration: none;
}
/*btn_background*/
.effect04 {
   --uismLinkDisplay: var(--smLinkDisplay, inline-flex);
   display: var(--uismLinkDisplay);
   color: black;
   background-color: white;
   outline: solid 2px rgb(0, 0, 0);
   position: relative;
   transition-duration: 0.4s;
   overflow: hidden;
}

.effect04::before, .effect04 span {
   margin: 0 auto;
   transition-timing-function: cubic-bezier(0.86, 0, 0.07, 1);
   transition-duration: 0.4s;
}

/* 文字1を上に */
.effect04:hover {
   background-color: rgb(0, 0, 0);
}

/* HOVERしたら文字1を上に */
.effect04:hover span {
   -webkit-transform: translateY(-400%) scale(-0.1, 20);
   transform: translateY(-400%) scale(-0.1, 20);
}

/*文字2*/
.effect04::before {
   content: attr(data-sm-link-text);
   color: #fff;
   position: absolute;
   left: 0;
   right: 0;
   margin: auto;
   -webkit-transform: translateY(500%) scale(-0.1, 20);
   transform: translateY(500%) scale(-0.1, 20);
}

/* HOVERしたら文字2を上に */
.effect04:hover::before {
   letter-spacing: 0.05em;
   -webkit-transform: translateY(0) scale(1, 1);
   transform: translateY(0) scale(1, 1);
}

#particles-js {
   position: fixed;
   top: 0;
   left: 0;
   bottom: 0;
   right: 0;
   z-index: -1;
}

</style>
<script>
const hearts = {};

function toggleHeart(wantId) {
    const heart = document.getElementById(`heart-${wantId}`);
    
    if (!hearts[wantId]) {
        heart.classList.remove('empty');
        heart.classList.add('filled');
        // 여기서 백엔드로 해당 아이템을 찜 목록에 등록 요청을 보낼 수 있음
        hearts[wantId] = true;
    } else {
        heart.classList.remove('filled');
        heart.classList.add('empty');
        // 여기서 백엔드로 해당 아이템을 찜 목록에서 삭제 요청을 보낼 수 있음
        hearts[wantId] = false;
    }
}
</script>

</head>
<header>
   <%@ include file="/WEB-INF/views/header/header.jsp"%>

</header>
<body>




   <div class="container mt-4 mb-5" style="height: auto;
  min-height: 80%;
  padding-bottom:150px;">

      <div class="row">
             <%@ include file="/WEB-INF/views/header/myPageSideBar.jsp"%>
         <div class="col-lg-9">
            <!-- 위시리스트 제목 부분 -->
            <div class="col-12 d-flex justify-content-between align-items-center mt-3">
                   <h3>물품 리스트</h3>
  
               </div>
  
			<!-- 카드그리드 시작 -->
			<div class="row row-cols-2 row-cols-md-3 g-2">
				<!-- 카드리스트 시작 -->
				<c:forEach var="product" items="${productList}">
					<div class="col-md-4">
						<div class="card">
							 <div class="embed-responsive embed-responsive-4by3">
							 <img src = "<c:url value = '/productImg/'/>${product.p_imgname}" class="card-img-top embed-responsive-item"/>
							  </div>
							<div class="card-body">
								<h5 class="card-title">${product.p_title}</h5>
								<p class="card-text">${product.p_price}원</p>
								<a href="/productDetail.do?pro_num=${product.pro_num}"
									class="btn btn-danger fcolor" role="button"> 상세 보기</a>
								 
							</div>

						</div>
					</div>
				</c:forEach>
				<!-- 카드리스트 끝 -->

			</div>
               
         <!--페이지네이션 시작 -->
            ${pagingHtml}
         <!--페이지네이션 끝 -->   
   </div>
   </div>
   </div>
   
   <footer>
      <div class="container">
         <%@ includefile="/WEB-INF/views/footer/footer.jsp"%>
      </div>
   </footer>
</body>
</html>