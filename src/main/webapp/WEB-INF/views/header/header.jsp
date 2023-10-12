<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 

<script type="text/javascript">
 $(document).ready(function() {
     
 
           $("#joonggoSearch").submit(function (e) {
              e.preventDefault();

            var form = $("form")[0];        
            var formData = new FormData(form);




              // Simple validation at client's end
              // We simply change border color to red if empty field using .css()
              var proceed = true;


              if (proceed) {
                  // 검색어 값을 searchword 변수에 저장
                  searchword = $(".searchContent").val();

                  // 검색 페이지로 이동
                  location.href = "Search?searchWord=" + searchword;
              }
          });
           $("#joonggoSearch2").submit(function (e) {
               e.preventDefault();

             var form = $("form")[0];        
             var formData = new FormData(form);




               // Simple validation at client's end
               // We simply change border color to red if empty field using .css()
               var proceed = true;


               if (proceed) {
                   // 검색어 값을 searchword 변수에 저장
                   searchword2 = $(".form-control.search-input").val();

                   // 검색 페이지로 이동
                   location.href = "Search?searchWord=" + searchword2;
               }
           });

        $(".search").on("click", function() {
          $(".searchContent").val('');
        });

        $(".search-icon").on("click", function() {
            $(".search-box").toggleClass("show_search");
          });
    });
 

  
 </script>


</head>
<body>

	<nav class="navbar <c:if test="${requestScope['javax.servlet.forward.servlet_path'] == '/home' }">fixed-top </c:if> navbar-expand-lg navbar-light flexed-top bg-light">
		<div class="container">
			<a href="/home"><img
				src="<c:url value = '/resources/img/joonggomon.svg'/>" width="100px"
				height="50px"></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
				aria-controls="navbarNavDropdown" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<ul
					class="navbar-nav ms-auto p-3 align-items-center justify-content-center">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						id="navbarDropdownMenuLink" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> 게시판 </a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
							<li><a class="dropdown-item" href="/noticeboard">공지게시판</a></li>
							<li><a class="dropdown-item" href="/normalboard">자유게시판</a></li>
						</ul></li>

					<li class="nav-item"><a class="nav-link" href="/productMain">
							중고몬 거래 게시판 </a></li>

					<li class="nav-item"><a class="nav-link" href="/verify">사기조회</a></li>
			 
			 		<% if(session.getAttribute("user_id") == null){ %>
				
			 		<%}else{ %>
					<li class="nav-item  p-2 mr-2"><a class="nav-link"
						href="/member/myPage">마이페이지 </a></li>
				
					<%} %>
					
 				<c:if test="${requestScope['javax.servlet.forward.servlet_path'] != '/home' }">
					<li class="nav-item p-2 mr-2">
						<div class="d-flex">
							<div class="search-box me-2">
									<form id="joonggoSearch2">
										<input type="text" name="SearchBox"
											class="form-control search-input" placeholder="Search...">
									</form>
								</div>
							<i class="fa fa-search search-icon mt-2"></i>
						</div>
					</li>
 				</c:if>
 
 				<% if(session.getAttribute("user_id") != null){ %>
						<li class="nav-item">
						<!-- Button trigger modal --> <a href="/member/logout.do" class="btn btn-2">LogOut</a>
					</li>
			 		<%}else{ %>
					<li class="nav-item">
						<!-- Button trigger modal --> <a data-bs-toggle="modal"
						data-bs-target="#exampleModalCenter" class="btn btn-2">Log-In</a>
					</li>
				 <%} %>
	 
		 
				</ul>
			</div>
		</div>
	</nav>


	<!-- 로그인 Modal -->
	<div class="modal fade" id="exampleModalCenter" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalCenterTitle"
		aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body p-4 p-md-5">
					<div class="icon d-flex align-items-center justify-content-center">
						<ion-icon name="person-outline"></ion-icon>
					</div>
					<h3 class="text-center mb-4">로그인</h3>
					<form action="/member/login.do" class="login-form" method="POST">
						<div class="form-group">
							<input type="text" class="form-control rounded-left" id="login_user_id" name="login_user_id"
								placeholder="아이디">
						</div>
						<div class="form-group d-flex">
							<input type="password" id="login_u_pwd" name="login_u_pwd" class="form-control rounded-left"
								placeholder="비밀번호">
						</div>
						<div class="form-group">
							<button type="submit"
								class="form-control btn btn-primary rounded submit px-3">로그인</button>
						</div>
						<div class="form-group d-md-flex">
							<div class="form-check w-50">
								<label class="custom-control fill-checkbox"> <input
									type="checkbox" class="fill-control-input"> <span
									class="fill-control-indicator"></span> <span
									class="fill-control-description">아이디 기억하기</span>
								</label>
							</div>
							<div class="w-50 text-md-right">
								<a href="member/forgotpassword">비밀번호찾기</a>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer justify-content-center">
					<p>
						계정이 없으신가요? <a href="member/regist">회원가입</a>
					</p>

				</div>
			</div>
		</div>
	</div>


</body>
</html>