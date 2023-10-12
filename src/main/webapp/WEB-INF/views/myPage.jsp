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
 <script>
    // JSP 내부에서 Model로 전달된 메시지 가져오기
    var message = "${message}";
    
    if (message !== "") {
        // 메시지가 비어있지 않으면 알림창 띄우기
        alert(message);
    }
</script>
<body>

 <%@ include file="/WEB-INF/views/header/header.jsp"%>


<div class="container mt-5">



	<div class="row">
    <%@ include file="/WEB-INF/views/header/myPageSideBar.jsp"%>
		<div class="col-lg-9">
			<div class="jumbotron">
				<h1 class="display-4"><%=session.getAttribute("user_id") %> 님, 반갑습니다!</h1>
				 <p class="lead my-3"><%=session.getAttribute("user_id") %>  님이 쓰신 게시판 글 갯수 : ${BoardNumber}개</p>
	  			<p class="lead my-3"><%=session.getAttribute("user_id") %>  님이 올린 물품 갯수 : ${ProductNumber}개</p>
				<hr class="my-4">						
				<a class="btn btn-primary btn-lg" href="https://www.tutorialrepublic.com/snippets/gallery.php" target="_blank">확인하러 가기</a>
			</div>
		</div>
	</div>
</div>
<footer class="fixed-bottom">
 <%@ include file="/WEB-INF/views/footer/footer.jsp"%>
</footer>
</body>
</html>