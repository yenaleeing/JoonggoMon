<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>중고몬 회원가입</title>
 
<%@ include file="/WEB-INF/views/header/headerIncludeLink.jsp"%>
 
 <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr =  extraAddr ;
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("inputAddress2").value = extraAddr;
                
                } else {
                    document.getElementById("inputAddress2").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("inputAddress1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("inputAddress2").focus();
            }
        }).open();
    }
    
   	var idCheck = 1 ;
   	var emCheck = 1 ;
    $(document).ready(function(){
    	
		// 취소
		$("#cancel").on("click", function(){
			location.href = "/controller/home";
		})
		
		$("#submit").on("click", function(){
			
			if($("#user_id").val() == ""){
				alert("아이디를 입력해주세요.");
				$("#user_id").focus();
				return false;
			}
			
			
			if($("#u_nickname").val()==""){
				alert("닉네임을 입력해주세요.");
				$("#u_nickname").focus();
				return false;
			}
			
			
			if($("#u_name").val() == ""){
				alert("이름을 입력해주세요.");
				$("#u_name").focus();
				return false;
			}
			
			
			if($("#u_pwd").val()==""){
				alert("비밀번호를 입력해주세요.");
				$("#u_pwd").focus();
				return false;
			}
			
			if($("#u_chkPwd").val()==""){
				alert("확인 비밀번호를 입력해주세요.");
				$("#u_chkPwd").focus();
				return false;
			}
			
			if($("#email").val()==""){
				alert("이메일을 입력해주세요.");
				$("#email").focus();
				return false;
			}
			
			if($("#birthdate").val()==""){
				alert("생년월일 을 입력해주세요.");
				$("#birthdate").focus();
				return false;
			}
			
			if($("#postcode").val()==""){
				alert("우편번호 를 입력해주세요.");
				$("#postcode").focus();
				return false;
			}
			
			if($("#tel1").val()==""){
				alert("번호를 입력해주세요.");
				$("#tel1").focus();
				return false;
			}
			
			if($("#tel2").val()==""){
				alert("번호를 입력해주세요.");
				$("#tel2").focus();
				return false;
			}
			
			if($("#tel3").val()==""){
				alert("번호를 입력해주세요.");
				$("#tel3").focus();
				return false;
			}
			
			if($("#inputAddress1").val()==""){
				alert("주소를 입력해주세요.");
				$("#inputAddress1").focus();
				return false;
			}
			
			
 
			 
			if(idCheck == 1){
				alert("아이디 중복을 확인해주세요.");
				return false;
			}else if(idCheck == 0){
				if(emCheck==1){
				alert("이메일 중복을 확인해주세요.");
				return false;
				}else{
				if($("#u_pwd").val() != $("#u_chkPwd").val()){
					alert("비밀번호 확인을 부탁드립니다.");
					return false;
				}else{
				$("#regForm").submit();
					}
				}
				
			}
		});
	})
	
	function fn_idChk(){
		$.ajax({
			url : "regist/idChk.do",
			type : "post",
			dataType : "json",
			data : {"user_id" : $("#user_id").val()},
			success : function(data){
				if(data == 1){
					alert("중복된 아이디입니다.");
				}else if(data == 0){
				
					alert("사용가능한 아이디입니다.");
					idCheck = 0;
				}
			}
		})
	}
    
    function fn_emChk(){
		$.ajax({
			url : "regist/emChk.do",
			type : "post",
			dataType : "json",
			data : {"email" : $("#email").val()},
			success : function(data){
				if(data == 1){
					alert("중복된 이메일입니다.");
				}else if(data == 0){
				
					alert("사용가능한 이메일입니다.");
					emCheck = 0;
				}
			}
		})
	}
    
    function readURL(input) {
    	  if (input.files && input.files[0]) {
    	    var reader = new FileReader();
    	    reader.onload = function(e) {
    	      document.getElementById('preview').src = e.target.result;
    	    };
    	    reader.readAsDataURL(input.files[0]);
    	  } else {
    	    document.getElementById('preview').src = "";
    	  }
    	}
</script>



</head>
<body>


	<%@ include file="/WEB-INF/views/header/header.jsp"%>

	<div class="container border border-dark-subtle mt-4 pb-4 mb-3">
		<div class="col-12 ml-auto mt-3">
			<h3>회원가입</h3>
		</div>
		<form class="row g-2" action="/member/regist.do" enctype="multipart/form-data"  method="POST">
			<div class="col-md-6 ">
				<div
					class="col-md-6 offset-md-3
                            text-center mb-2">
					<img src="<c:url value = '/resources/img/joonggomon.jpg'/>" id ="preview" width="250px" height="250px">
				</div>
				<input class="form-control mt-1" type="file" id="upload" name="upload" onchange="readURL(this);">
			</div>
			<div class="col-md-6">

				<label for="inputusername" class="form-label">아이디</label>
				<div class="row">
					<div class="col-md-8">
					<input type="text" class="form-control mb-2" name="user_id" id="user_id">
					</div>
					<div class="col-md-4">
						<input class="btn btn-2" type="button" id="idChk" onclick="fn_idChk();" value="중복확인"/>
					</div>
				</div>
				<label for="inputnickname" class="form-label">닉네임</label> <input
					type="text" class="form-control mb-2" name="u_nickname" id="u_nickname"> 
				<label for="inputname" class="form-label">이름</label> <input
					type="text" class="form-control mb-2" name="u_name" id="u_name"> 	
					<label
					for="inputPassword4" class="form-label">Password</label> <input
					type="password" class="form-control mb-2" name="u_pwd" id="u_pwd">

				<label for="inputPassword5" class="form-label">비밀번호 체크</label> <input
					type="password" class="form-control mb-2" id="u_chkPwd" name="u_chkPwd">

			</div>
 
			<div class="col-md-6">
				<label for="inputEmail4" class="form-label">Email</label> 
				<input type="email" class="form-control mb-2" name="email" id="email">
				<input class="btn btn-2" type="button" id="emChk" onclick="fn_emChk();" value="중복확인"/>
			</div>
			<div class="col-md-6">

				<label for="birthDay">생년월일</label> <input name="birthdate" id="birthdate"
					class="form-control mb-2" type="date" />
			</div>

			<div class="col-6">

				<label for="inputPostNum" class="form-label">우편번호</label>


				<div class="input-group mb-3">
					<input type="text" class="form-control " name="address"
						placeholder="123456" id="postcode">
					<div class="input-group-append">
					<input type="button" class="btn btn-2" value="주소찾기" onclick="sample6_execDaumPostcode()"/>
					</div>
				</div>

			</div>

			<div class="col-6">

				<label class="form-label">전화번호</label>

				<div class="col-md-12">
					<div class="d-md-inline-block">
						<input type="text" maxlength="3" size="3" name="tel1" id="tel1"
							class="form-control" value="010">
					</div>
					-
					<div class=" d-md-inline-block">
						<input type="text" maxlength="4" size="4" name="tel2" id="tel2"
							class="form-control  ">
					</div>
					-
					<div class=" d-md-inline-block">
						<input type="text" maxlength="4" size="4" name="tel3" id="tel3"
							class="form-control  ">
					</div>
				</div>
			</div>


			<div class="col-8">
				<label for="inputAddress" class="form-label">주소</label> <input
					type="text" class="form-control mb-2" name="inputAddress1" id="inputAddress1"
					placeholder="1234 Main St" id="inputAddress1">
			</div>
			<div class="col-4">
				<label for="inputAddress2" class="form-label">상세주소</label> <input
					type="text" class="form-control mb-2" name="inputAddress2"  id="inputAddress2"
					placeholder="Apartment, studio, or floor">
			</div>


			<div class="col-12 offset-md-5 mt-5">

				<button type="button" class="btn btn-danger" id="cancel">돌아가기</button>
				<button type="submit" class="btn btn-primary" id="submit" >회원가입</button>
			</div>
		</form>
	</div>

	<footer>
		<%@ include file="/WEB-INF/views/footer/footer.jsp"%>
	</footer>


</body>
</html>