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
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 <script type="text/javascript">

 
 $(document).ready( function(){

	 var data = "${member.address}";
	 var array_data = data.split(",");
	 var addr1 = array_data[0];
	 var addr2 = array_data[1];
	 var addr3 = array_data[2];
	 
	 
	 $("#postcode").val(addr1);
	 $("#inputAddress1").val(addr2);
	 $("#inputAddress2").val(addr3);
	 
	 
	 var num = "${member.phonenum}";
	 var array_phdata = num.split("-");
	 var num1 = array_phdata[0];
	 var num2 = array_phdata[1];
	 var num3 = array_phdata[2];
	 
	 $("#tel1").val(num1);
	 $("#tel2").val(num2);
	 $("#tel3").val(num3);
	 
	Dday = "${member.birthdate}";
	
	var darray_data = Dday.split(" ");
	 
	 $("#birthdate").val(darray_data[0]);
	 
	 
	 
	  }); 
 
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

<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">&nbsp 비밀번호 변경</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="/member/changePassword" method="POST">
      <div class="modal-body">
        
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label">이전 비밀번호:</label>
            <input type="password" class="form-control" id="prepassword" name="prepassword">
          </div>
          
                    <div class="mb-3">
            <label for="recipient-name" class="col-form-label">변경 비밀번호:</label>
            <input type="password" class="form-control" id="newpassword" name = "newpassword">
          </div>
          
                    <div class="mb-3">
            <label for="recipient-name" class="col-form-label">변경할 비밀번호 확인:</label>
            <input type="password" class="form-control" id="chkpassword" name="chkpassword">
          </div>
 
      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary"  >Send message</button>
      </div>
        </form>
    </div>
  </div>
</div>

<div class="container mt-4 mb-5">



	<div class="row">
		    <%@ include file="/WEB-INF/views/header/myPageSideBar.jsp"%>
		<div class="col-7">
 
				<div class="col-12 mt-3">
					 <h3>회원정보 수정</h3>
				</div>
				<form class="row g-2" action="/member/editInfo.do" enctype="multipart/form-data"  method="POST">
					<div class="col-md-6 ">
						 <div class="col-md-6 offset-md-1
                            text-center mb-2">
						<img src="<c:url value = '/profilePic/${member.u_PICTURE}'/>" id="preview" width="250px" height="250px">
  						</div>
  					<input class="form-control mt-1" type="file" id="upload" name="upload" onchange="readURL(this);">
  					</div>
					<div class="col-md-6">
					
					<label for="inputusername" class="form-label">아이디</label>
	 				<div class="row">
	 				<div class="col-md-12">
				    <input type="text" class="form-control mb-2" name="user_id" id="user_id" value="${member.user_id}" readonly>

				    </div>
				    
			 		</div>
					<label for="inputnickname" class="form-label">닉네임</label>
				    <input type="text" class="form-control mb-2" name="u_nickname" id="u_nickname" value="${member.u_nickname}" readonly>
									    <label for="inputname" class="form-label">이름</label> <input
					type="text" class="form-control mb-2" name="u_name" id="u_name" value="${member.u_name }"> 	
					
					<label for="inputPassword4" class="form-label">비밀번호 변경</label><br>
					<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@mdo">비밀번호 변경</button>
 

					</div>

				  <div class="col-md-6">
				    <label for="inputEmail4" class="form-label">Email</label>
				    <input type="email" class="form-control mb-2" id="email" name="email" value="${member.email}">
				  </div>
				  <div class="col-md-6">

				               <label for="birthDay">생년월일 </label>
				            <input id="birthdate" name="birthdate" class="form-control mb-2" type="date"  />
				  </div>

	 	 		<div class="col-6">
 
				    <label for="inputPostNum" class="form-label">우편번호</label>
				 
		 
				  	<div class="input-group mb-3">
					  <input type="text" class="form-control " id="postcode" name="address" placeholder="123456">
					  <div class="input-group-append">
					      <input type="button" class="btn btn-2" value="주소찾기" onclick="sample6_execDaumPostcode()">
					  </div>
					</div>		 
				 
				  </div>

				  <div class="col-12">

 					<label  class="form-label">전화번호</label>
				 
				 <div class="col-md-12">
				  	<div class="d-md-inline-block">
					  <input type="text" maxlength="3" size="3" name="tel1" id="tel1" class="form-control  " >
					</div> 
					-
					<div class=" d-md-inline-block">
					  <input type="text"  maxlength="4" size="4" name="tel2" id="tel2" class="form-control  "  >
					</div>
					-
					<div class=" d-md-inline-block"> 
					  <input type="text"   maxlength="4" size="4" name="tel3" id="tel3" class="form-control  " >
					</div>
				  </div>
				</div>


				  <div class="col-8">
				    <label for="inputAddress" class="form-label">Address</label>
				    <input type="text" class="form-control mb-2" id="inputAddress1" name="inputAddress1" placeholder="1234 Main St">
				  </div>
				  <div class="col-4">
				    <label for="inputAddress2" class="form-label">Address 2</label>
				    <input type="text" class="form-control mb-2" id="inputAddress2" name = "inputAddress2" placeholder="Apartment, studio, or floor">
				  </div>
		
			 
				  <div class="col-12 offset-md-9 mt-5">
				  
				 <button type="button" class="btn btn-danger" id="cancel">돌아가기</button>
				<button type="submit" class="btn btn-primary" id="submit" >정보수정</button>
				 </div>
				</form>
 
		</div>
	</div>
</div>
<footer>

 <%@ include
			file="/WEB-INF/views/footer/footer.jsp"%>
</footer>
</body>
</html>