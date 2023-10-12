<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.jgmon.domain.joonggoVO"%>
<%@page import="org.jgmon.domain.dangunVO"%>
<%@page import="org.jgmon.domain.bungeVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    ArrayList<bungeVO> bungeList = (ArrayList<bungeVO>) request.getAttribute("bunge");
    ArrayList<dangunVO> dangunList = (ArrayList<dangunVO>) request.getAttribute("dangun");
   ArrayList<joonggoVO> joonggoList = (ArrayList<joonggoVO>) request.getAttribute("joonggo");
%>
    <%
   
/*     	dangunVO dvo = new dangunVO();
    	dvo = (dangunVO)request.getAttribute("dangun");
    	joonggoVO jvo = new joonggoVO();
    	jvo = (joonggoVO)request.getAttribute("joonggo"); */
    %>
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

	
	  <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">검색 단어 : <%=request.getAttribute("searchWord") %></h1>
                    <p class="lead fw-normal text-white-50 mb-0">검색된 결과물들</p>
                </div>
            </div>
        </header>
	
   <section class="py-5">
        
       <div class="container px-4 px-lg-5 mt-5">
          <div class="col-md-12"><h1>번개장터</h1></div>
          <div class="row gx-4 gx-lg-4 row-cols-md-4 row-cols-xl-4 justify-content-center">                
	<%-- 루프를 사용하여 데이터 추출 --%>
	<%
	    if (bungeList != null) {
	        for (bungeVO bunge : bungeList) {
	%>
 			<div class="col-md-3 mb-5">
              <div class="card h-100">
               <!-- Product image-->
              <img class="card-img-top" src="<%= bunge.getImageSrc() %>" alt="그림" /> 
              <!-- Product details-->
              <div class="card-body p-4">
                 <div class="text-center">
                    <!-- Product name-->
                    <h5 class="fw-bolder"><%= bunge.getPrice() %></h5>
                    <!-- Product price-->
                    <%= bunge.getContent() %> 
                 </div>
              </div>
               <!-- Product actions-->
             <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
           <div class="text-center"><a class="btn btn-primary mt-auto" target="_blank" rel="noopener noreferrer" href="<%= bunge.getHref() %>">이동</a>
            	    	<!-- 찜하기,판매자연락처 (로그인 권한체크) -->	
				<c:if test="${sessionScope.user_id == null}">
				<button type="button" class="btn btn-secondary btn-lg btn-addwishlist" onclick="movePage()"  >찜하기</button>	
				</c:if>
				<c:if test="${sessionScope.user_id != null}">
				<button type="button" class="btn btn-primary" onclick="wishAndContactBtn(this.getAttribute('data-wimg'), this.getAttribute('data-wurl'))"  data-wimg="<%= bunge.getImageSrc() %>" data-wurl="<%= bunge.getHref() %>" >찜하기</button>
				</c:if>
           </div>                    
          </div>
         </div>		
         </div>	
	<%
	        }
	    }
	%>
   </div>
  </div>
  <!-- -------------------------------------- -->
  <div class="container px-4 px-lg-5 mt-5">
          <div class="col-md-12"><h1>당근마켓</h1></div>
          <div class="row gx-4 gx-lg-4 row-cols-md-4 row-cols-xl-4 justify-content-center">                
	<%-- 루프를 사용하여 데이터 추출 --%>
	<%
	    if (dangunList != null) {
	        for (dangunVO dangun : dangunList) {
	%>
 			<div class="col-md-3 mb-5">
              <div class="card h-100">
               <!-- Product image-->
              <img class="card-img-top" src="<%= dangun.getImageSrc() %>" alt="그림" /> 
              <!-- Product details-->
              <div class="card-body p-4">
                 <div class="text-center">
                    <!-- Product name-->
                    <h5 class="fw-bolder"><%= dangun.getPrice() %></h5>
                    <!-- Product price-->
                    <%= dangun.getContent() %>
                 </div>
              </div>
               <!-- Product actions-->
             <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
           <div class="text-center"><a class="btn btn-primary mt-auto" target="_blank" rel="noopener noreferrer" href="<%= dangun.getHref() %>">이동</a>
             	<!-- 찜하기,판매자연락처 (로그인 권한체크) -->	
				<c:if test="${sessionScope.user_id == null}">
				<button type="button" class="btn btn-secondary btn-lg btn-addwishlist" onclick="movePage()"  >찜하기</button>	
				</c:if>
				<c:if test="${sessionScope.user_id != null}">
				<button type="button" class="btn btn-primary" onclick="wishAndContactBtn(this.getAttribute('data-wimg'), this.getAttribute('data-wurl'))"  data-wimg="<%= dangun.getImageSrc() %>" data-wurl="<%= dangun.getHref() %>" >찜하기</button>
				</c:if>
           </div>                    
          </div>
         </div>		
         </div>	
	<%
	        }
	    }
	%>
   </div>
  </div>
  <!-- ----------------------------------- -->
  
    <div class="container px-4 px-lg-5 mt-5">
          <div class="col-md-12"><h1>중고나라</h1></div>
          <div class="row gx-4 gx-lg-4 row-cols-md-4 row-cols-xl-4 justify-content-center">                
	<%-- 루프를 사용하여 데이터 추출 --%>
	<%
	    if (joonggoList != null) {
	        for (joonggoVO joonggo : joonggoList) {
	%>
 			<div class="col-md-3 mb-5">
              <div class="card h-100">
               <!-- Product image-->
              <img class="card-img-top" src="<%= joonggo.getImageSrc() %>" alt="그림" /> 
              <!-- Product details-->
              <div class="card-body p-4">
                 <div class="text-center">
                    <!-- Product name-->
                    <h5 class="fw-bolder"><%= joonggo.getPrice() %></h5>
                    <!-- Product price-->
                    <%= joonggo.getContent() %>
                 </div>
              </div>
               <!-- Product actions-->
             <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
           <div class="text-center"><a class="btn btn-primary mt-auto" target="_blank" rel="noopener noreferrer" href="<%= joonggo.getHref() %>">이동</a>
           
           	<!-- 찜하기,판매자연락처 (로그인 권한체크) -->	
				<c:if test="${sessionScope.user_id == null}">
				<button type="button" class="btn btn-secondary btn-lg btn-addwishlist" onclick="movePage()"  >찜하기</button>	
				</c:if>
				<c:if test="${sessionScope.user_id != null}">
				<button type="button" class="btn btn-primary" onclick="wishAndContactBtn(this.getAttribute('data-wimg'), this.getAttribute('data-wurl'))"  data-wimg="<%= joonggo.getImageSrc() %>" data-wurl="<%= joonggo.getHref() %>" >찜하기</button>
				</c:if>
				
           	
           </div>                    
          </div>
         </div>		
         </div>	
	<%
	        }
	    }
	%>
   </div>
  </div>
  
  
  </section>

		<script>
 
		  	 
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
		    
	 
		</script>
		
		
		<footer>
		<%@ include file="/WEB-INF/views/footer/footer.jsp"%>
	</footer>
</body>
</html>