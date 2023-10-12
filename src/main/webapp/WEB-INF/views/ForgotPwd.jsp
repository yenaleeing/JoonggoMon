<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ForgotPasswd</title>

 
<%@ include file="/WEB-INF/views/header/headerIncludeLink.jsp"%>
 
<script>

$(document).ready(function(){
	
	 
	// 취소
	$("#cancel").on("click", function(){
		location.href = "/controller/home";
	})
	
	$("#submit").on("click", function(){
 
 
		if($("#email").val()==""){
			alert("이메일을 입력해주세요.");
			$("#email").focus();
			return false;
		}else{
			$("#resetpass").submit();
			}
	});
})

</script>


<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: "Noto Sans KR", sans-serif;
}

a {
	text-decoration: none;
	color: black;
}

li {
	list-style: none;
}

.wrap {
	width: 100%;
	height: 77vh;
	display: flex;
	align-items: center;
	justify-content: center;
	background: rgba(0, 0, 0, 0.1);
}

.login {
	width: 30%;
	height: 600px;
	background: white;
	border-radius: 20px;
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
}

h2 {
	color: tomato;
	font-size: 2em;
}

.forgotPWD {
	margin-top: 20px;
	width: 80%;
}

.forgotPWD input {
	width: 100%;
	height: 50px;
	border-radius: 30px;
	margin-top: 10px;
	padding: 0px 20px;
	border: 1px solid lightgray;
	outline: none;
}

.submit {
	margin-top: 50px;
	width: 80%;
}

.submit input {
	width: 100%;
	height: 50px;
	border: 0;
	outline: none;
	border-radius: 40px;
	background: linear-gradient(to left, rgb(255, 77, 46), rgb(255, 155, 47));
	color: white;
	font-size: 1.2em;
	letter-spacing: 2px;
}
</style>
</head>
<body>

	<%@ include file="/WEB-INF/views/header/header.jsp"%>




<form  action="/member/resetpassword" id="resetpass"  method="POST"> 
	<div class="wrap">
		<div class="login">
			<h2>비밀번호찾기</h2>
			<div class="forgotPWD">
				<h4>
					아래에 이메일 주소를 입력하시면 <br>입력하신 이메일로 새로운 암호를 보내드립니다
				</h4>
				<input type="email" name="email" id="email"
					placeholder="Example@domain.com">
			</div>
			<div class="submit">
				<a type="button" id="submit" class="btn btn-2 w-100"> 비밀번호 찾기 </a>
			</div>
		</div>
	</div>
</form>
	<footer>

		<%@ include file="/WEB-INF/views/footer/footer.jsp"%>
	</footer>


</body>
</html>