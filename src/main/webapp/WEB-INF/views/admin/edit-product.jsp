
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>중고몬 관리자페이지</title>


<%@ include file="/WEB-INF/views/header/headerIncludeLink.jsp"%>
<%@ include file="/WEB-INF/views/admin/header/headerIncludeLink.jsp"%>
<script src="<c:url value ='/resources/js/ckeditor/ckeditor.js'/>"></script>
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>

<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" ></script>
 
<style>
.form-label {
	width: 170px;
}

.main-wrap {
	max-width: 1000px;
	width: calc(100% - 25px);
	margin: 0 auto;
}

form {
	margin: initial !important;
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

select option:checked, textarea::placeholder, input::placeholder {
	color: rgb(198, 198, 198) !important;
}

.checkbox-wrap {
	margin-right: 50px;
}

.custom-width {
	max-width: 250px;
	width: 100%;
}

.deliveryfee-check {
	margin-left: 170px;
}

.width-calc170 {
	width: calc(100% - 170px);
}

.number-input::-webkit-outer-spin-button, .number-input::-webkit-inner-spin-button
	{
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
}

.inputFile,
#Preview,
#Preview li{
    float:left
}
.inputFile{
    margin-bottom: 10px;
}
.addImgBtn{
    width: 80px !important;
    height: 80px !important;
    line-height: 71px !important;
    background-color: #fff !important;
    color: #b7b7b7 !important;
    border: 2px solid #b7b7b7;
    font-size: 35px !important;
    padding: 0 !important;
}

#Preview{
    margin-left: 20px;
    width: 650px;
}
#Preview li{
    margin-left: 10px;
    margin-bottom: 10px;
    position: relative;
    border: 1px solid #ececec;
    cursor:move;
     list-style-type: none;
}
.delBtn{
    position: absolute;
    top: 0;
    right: 0;
    font-size: 13px;
    background-color: #000;
    color: #fff;
    width: 18px;
    height: 18px;
    line-height: 16px;
    display: inline-block;
    text-align: center;
    cursor: pointer;
}
</style>

<script type="text/javascript">
$(function(){
	 
	  //드래그 앤 드롭
	  $(".sortable").sortable();
	  
	  //이미지 등록
	  $("#AddImgs").change(function(e){
	   
	      var currentImageCount = $("#Preview li").length;
	        var maxImageCount = 3; // 원하는 이미지 최대 개수

	        if (currentImageCount + e.target.files.length > maxImageCount) {
	            alert("이미지는 최대 " + maxImageCount + "개까지만 등록 가능합니다.");
	            $("#AddImgs").val(""); // 파일 초기화
	            return false;
	        }
	        
	       var files = e.target.files;
	        var arr = Array.prototype.slice.call(files);
	        var ulElement = $('<ul id="Preview" class="sortable"></ul>'); // 새로운 ul 생성


	      //업로드 가능 파일인지 체크
	      for(var i=0; i<files.length; i++){
	          if(!checkExtension(files[i].name,files[i].size)){
	              return false;
	          }
	      }
	        
	      // 기존 이미지 유지
	        $('.sortable li').each(function () {
	            ulElement.append($(this).clone());
	        });

	      
	        // 새로운 이미지 추가
	        preview(arr, ulElement);

	        
	        // 기존 ul 요소를 새로운 ul로 교체
	        $('.sortable').replaceWith(ulElement);

	      function checkExtension(fileName,fileSize){
	          var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	          var maxSize = 20971520;  //20MB

	          if(fileSize >= maxSize){
	              alert('이미지 크기가 초과되었습니다.');
	              $("#AddImgs").val("");  //파일 초기화
	              return false;
	          }

	          if(regex.test(fileName)){
	              alert('확장자명을 확인해주세요.');
	              $("#AddImgs").val("");  //파일 초기화
	              return false;
	          }
	          return true;
	      }

	      function preview(arr, ulElement) {
	          arr.forEach(function (f) {
	              var str = '<li class="ui-state-default">';
	              
	              // 이미지 파일 미리보기
	              if (f.type.match('image.*')) {
	                  var reader = new FileReader();
	                  reader.onload = function (e) {
	                      str += '<img src="' + e.target.result + '" title="' + f.name + '" width=80 height=80 id="' + f.name + '">';
	                      str += '<span class="delBtn" onclick="delImg(this)">x</span>';
	                      str += '</li>';
	                      $(str).appendTo(ulElement); // 새로운 ul에 이미지 요소 추가
	                  };
	                  reader.readAsDataURL(f);
	              } else {
	                  // 이미지 파일 아닐 경우 대체 이미지
	                  // ...
	              }
	          });
	      }
	  })



});

 

// 이미지 삭제
function delImg(_this) {
    var imgName = $(_this).siblings('img').attr('title'); // 이미지 파일명 가져오기
    $(_this).parent('li').remove();

    // input 파일 요소 내의 해당 이미지를 찾아 삭제
    var inputElement = $("#AddImgs")[0];
    var files = inputElement.files;
    var newFiles = [];
    for (var i = 0; i < files.length; i++) {
        if (files[i].name !== imgName) {
            newFiles.push(files[i]);
        }
    }

    // 새로운 FileList 객체 생성
    var newFileList = new DataTransfer();
    for (var i = 0; i < newFiles.length; i++) {
        newFileList.items.add(newFiles[i]);
    }

    // input 파일 요소의 files 속성에 새로운 FileList 객체 할당
    inputElement.files = newFileList.files;
}

</script>

 


</head>



<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

<%@ include file="/WEB-INF/views/admin/header/sidebar.jsp"%>


		<!-- Content -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">
		<%@ include file="/WEB-INF/views/admin/header/header.jsp"%>

				<!-- Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">${sessionScope.managerid}</h1>
					</div>

					<div class="alert alert-success d-none" role="alert">
						This is a warning alert—check it out!
						<button type="button" class="close">&times;</button>
					</div>
		<!--페이지 제목-->
		<p class="main-title">중고몬 상품 판매 등록</p>
		<hr class="main-hr">
		<br>
		<form class="row g-3" action="/admin/editProduct/edit.do" method="POST"   enctype="multipart/form-data">
			<!--상품이미지 파일업로드-->
					<!--상품이미지 파일업로드-->
			<div>
				<div class="d-flex flex-row mb-3">
					<label for="productImg" class="form-label">상품 이미지</label>
						<!--이미지 업로드 for문 영역 끝부분-->
							<div class="width-calc170 img-guide">
								<span>* 상품이미지는 최대 3개까지 업로드 가능합니다.</span>
							</div>
				</div>
				<!--이미지 업로드 for문 영역 시작부분-->
				<div class="img-main-wrap d-flex flex-wrap offset-md-2">
						 
						 
								    					    <ul id="Preview" class="sortable">
						          <c:forEach items="${imgList}" var="file">
						           <li class="ui-state-default">
						             <img src="<c:url value = '/productImg/'/>${file.p_imgname}" title="  ${file.p_imgname } " width=80 height=80 id=" ${file.p_imgname }"> 
						              
						              <input type="hidden" name="existingImages" value="${file.p_originalfilename}">
						              </li>
						        </c:forEach>
						    </ul> 
					 
				</div>
				
					 
					
					
	
			</div>
			<hr>
			<!--판매글 제목-->
	<div class="d-flex flex-row mb-3">
				<label for="inputTitle" class="form-label">제목</label> 
				<input type="text" class="form-control width-calc170" name="p_title" id="p_title"
					maxlength="40" placeholder="상품 제목을 입력해주세요. (글자 수 40자 제한)" value="${pvo.p_title}">
					
					<input type="hidden" name="pro_num" id="pro_num" value="${pvo.pro_num}">
			</div>
			<hr>
			<!--카테고리 셀렉트-->
			<div class="d-flex flex-row mb-3">
				<label for="inputCategory" class="form-label">카테고리</label>
					<select name="pro_category_id" id="pro_category_id" class="form-select width-calc170" aria-label="Default select example">
					    <option value="" selected>판매 카테고리를 선택해주세요</option>
					    <c:forEach var="category" items="${categoryList}" varStatus="status">
					        <c:choose>
					            <c:when test="${category.pro_category_id == pvo.pro_category_id}">
					                <option value="${category.pro_category_id}" selected>
					                    <c:out value="${category.pro_category}" />
					                </option>
					            </c:when>
					            <c:otherwise>
					                <option value="${category.pro_category_id}">
					                    <c:out value="${category.pro_category}" />
					                </option>
					            </c:otherwise>
					        </c:choose>
					    </c:forEach>
					</select>
			</div>
			<!-- <button class="btn btn-outline-secondary" type="button">Button</button>-->

			<hr>
			<!--상품상태-->
				<div class="d-flex flex-row mb-3">
				    <label for="inputCategory" class="form-label">상태</label>
				
				    <div class="form-check checkbox-wrap">
				        <input class="form-check-input" type="radio" value="중고상품"
				               name="p_state" id="flexRadioDefault1"
				               ${pvo.p_state == '중고상품' ? 'checked' : ''}>
				        <label class="form-check-label" for="flexRadioDefault1"> 중고상품 </label>
				    </div>
				    <div class="form-check checkbox-wrap">
				        <input class="form-check-input" type="radio" value="새상품"
				               name="p_state" id="flexRadioDefault2"
				               ${pvo.p_state == '새상품' ? 'checked' : ''}>
				        <label class="form-check-label" for="flexRadioDefault2"> 새상품 </label>
				    </div>
				</div>
			<hr>
			<!--교환가능여부-->
			<div class="d-flex flex-row mb-3">
			    <label for="inputCategory2" class="form-label">교환</label>
			    <div class="form-check checkbox-wrap">
			        <input class="form-check-input" type="radio" value="교환불가"
			               name="p_exchange" id="flexRadioDefault3"
			               ${pvo.p_exchange == '교환불가' ? 'checked' : ''}>
			        <label class="form-check-label2" for="flexRadioDefault3"> 교환불가 </label>
			    </div>
			    <div class="form-check checkbox-wrap">
			        <input class="form-check-input" type="radio" value="교환가능"
			               name="p_exchange" id="flexRadioDefault4"
			               ${pvo.p_exchange == '교환가능' ? 'checked' : ''}>
			        <label class="form-check-label2" for="flexRadioDefault4"> 교환가능 </label>
			    </div>
			</div>
			<hr>
			<!--가격, 배송비 체크박스 -->
				<div>
				    <div class="d-flex flex-row mb-3">
				        <label for="inputPrice" class="form-label">가격</label>
				        <div class="input-group mb-3 custom-width">
				            <input type="number" class="form-control number-input" placeholder="숫자만 입력해주세요."
				                   value="${pvo.p_price}" name="p_price" id="p_price">
				            <span class="input-group-text">원</span>
				        </div>
				    </div>
				    <div class="form-check deliveryfee-check">
				        <input class="form-check-input" type="checkbox" name="p_dfee" id="p_dfee"
				             value="배송비 포함"  ${pvo.p_dfee == '배송비 포함' ? 'checked' : ''}>
				        <label class="form-check-label" for="p_dfee"> 배송비 포함 </label>
				    </div>
				</div>
			<hr>
			<!--상품설명-->
			<div class="d-flex flex-row mb-3">
				<label for="inputPrice" class="form-label">상품 설명</label>
				<textarea class="form-control width-calc170" rows="5"
					placeholder="여러 장의 상품 사진과 구입 연도, 브랜드, 사용감, 하자 유무 등 구매자에게 필요한 정보를 꼭 포함해 주세요. (10자 이상)"
					 name="p_content" id="p_content">
					 ${pvo.p_content}
					 </textarea>
			</div>
			<hr>
			<!-- 판매자 연락처 -->
			<div class="d-flex flex-row mb-3">
				<label for="inputTitle" class="form-label">연락처</label>
				<input type="text" class="form-control width-calc170" maxlength="40"
					placeholder="구매자가 개별적으로 연락할 수 있는 전화번호 혹은 카카오톡 아이디를 입력해주세요."
					value="${pvo.p_contact}" name="p_contact" id="p_contact">
			</div>

			<!-- 등록하기 버튼 -->
			<div class="col-12">
				<button type="submit" class="btn bg-danger bg-gradient btn-submit"
					style="float: right; color: #fff" onclick="location.href='/admin/editProduct/edit.do'">수정하기</button>
			</div>
			<hr>
		</form>

	</div>

</body>

<script>
$(function () {
	 
	CKEDITOR.replace('n_contents');
   
	
 
});


   
</script>


</html>