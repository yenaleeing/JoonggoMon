<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
<title>중고몬 물품게시판 상품 등페이지</title>

 
<%@ include file="/WEB-INF/views/header/headerIncludeLink.jsp"%>
 
</head>
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
    // 드래그 앤 드롭
    $(".sortable").sortable();
    
    // 이미지 등록
    $("#AddImgs").change(function(e){
        // 이미지 개수 체크
        var currentImageCount = $("#Preview li").length;
        var maxImageCount = 3; // 원하는 이미지 최대 개수

        if (currentImageCount + e.target.files.length > maxImageCount) {
            alert("이미지는 최대 " + maxImageCount + "개까지만 등록 가능합니다.");
            $("#AddImgs").val(""); // 파일 초기화
            return false;
        }

        // div 내용 비워주기
        $('#Preview').empty();

        var files = e.target.files;
        var arr = Array.prototype.slice.call(files);

        // 업로드 가능 파일인지 체크
        for(var i=0; i<files.length; i++){
            if(!checkExtension(files[i].name,files[i].size)){
                return false;
            }
        }
        preview(arr);
    });

    function checkExtension(fileName,fileSize){
        var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
        var maxSize = 20971520;  //20MB

        if(fileSize >= maxSize){
            alert('이미지 크기가 초과되었습니다.');
            $("#AddImgs").val("");  // 파일 초기화
            return false;
        }

        if(regex.test(fileName)){
            alert('확장자명을 확인해주세요.');
            $("#AddImgs").val("");  // 파일 초기화
            return false;
        }
        return true;
    }

    function preview(arr){
        arr.forEach(function(f){
            var str = '<li class="ui-state-default">';
            if(f.type.match('image.*')){
                var reader = new FileReader(); 
                reader.onload = function (e) { 
                    str += '<img src="'+e.target.result+'" title="'+f.name+'" width=80 height=80 id="'+f.name+'">';
                    str += '<span class="delBtn" onclick="delImg(this)">x</span>';
                    str += '</li>';
                    $(str).appendTo('#Preview');
                } 
                reader.readAsDataURL(f);
            }
        });
    }
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

// 업로드 form 유효성 검사
function uploadFormCheck(event) {
   // 이미지
   if(document.uploadForm.AddImgs.value == "") {
      alert("상품이미지를 업로드해주세요.");
      return false;
   }
   // 제목
   if(document.uploadForm.p_title.value == "") {
      alert("제목을 입력해주세요.");
      document.uploadForm.p_title.focus();
      return false;
   }
   // 카테고리
   if(document.uploadForm.pro_category_id.value == "") {
      alert("카테고리를 선택해주세요.");
      return false;
   }
   // 가격
   if(document.uploadForm.p_price.value == "") {
      alert("가격을 입력해주세요.");
      document.uploadForm.p_price.focus();
      return false;
   }
   // 상품 설명
   if(document.uploadForm.p_content.value == "") {
      alert("상품 설명을 입력해주세요.");
      document.uploadForm.p_content.focus();
      return false;
   }
   // 연락처
   if(document.uploadForm.p_contact.value == "") {
      alert("연락처를 입력해주세요.");
      document.uploadForm.p_contact.focus();
      return false;
   }
   event.preventDefault();
}
	
</script>

<body>


	<%@ include file="/WEB-INF/views/header/header.jsp"%>


	<div class="main-wrap">
		<!--페이지 제목-->
		<p class="main-title">중고몬 상품 판매 등록</p>
		<hr class="main-hr">
		<br>
		<form action="productUpload/write.do" method="POST" class="row g-3" enctype="multipart/form-data">
		
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
						 
								    <div class="inputFile ">
								        <label for="AddImgs" class="addImgBtn">+</label>
								        <input type="file" id="AddImgs" name="AddImgs" class="upload-hidden" accept=".jpg, .png, .gif"   style="display:none;" multiple>
								    </div>
								    <ul id="Preview" class="sortable"></ul> 
					 
				</div>
				
					 
					
					
	
			</div>
			<hr>
			<!--판매글 제목-->
			<div class="d-flex flex-row mb-3">
				<label for="inputTitle" class="form-label">제목</label> 
				<input type="text" class="form-control width-calc170" name="p_title" id="p_title"
					maxlength="40" placeholder="상품 제목을 입력해주세요. (글자 수 40자 제한)" >
			</div>
			<hr>
			<!--카테고리 셀렉트-->
			<div class="d-flex flex-row mb-3">
				<label for="inputCategory" class="form-label">카테고리</label>
				<select name="pro_category_id" id="pro_category_id" class="form-select width-calc170" aria-label="Default select example" >
				<!-- id="inputGroupSelect04" -->
					
					<option selected>판매 카테고리를 선택해주세요</option>
					<c:forEach var="category" items="${list}" varStatus="status">
					    <option value="${category.pro_category_id}"> <c:out value="${category.pro_category}" /></option>
					</c:forEach>
					
				</select>
			</div>
		

			<hr>
			<!--상품상태-->
			<div class="d-flex flex-row mb-3">
				<label for="inputCategory" class="form-label">상태</label>

				<div class="form-check checkbox-wrap">
					<input class="form-check-input" type="radio" value="중고상품"
						name="p_state" id="flexRadioDefault1" checked>
						<label class="form-check-label" for="flexRadioDefault1"> 중고상품 </label>
				</div>
				<div class="form-check checkbox-wrap">
					<input class="form-check-input" type="radio" value="새상품"
						name="p_state" id="flexRadioDefault2">
						<label class="form-check-label" for="flexRadioDefault2"> 새상품 </label>
				</div>
			</div>
			<hr>
			<!--교환가능여부-->
			<div class="d-flex flex-row mb-3">
				<label for="inputCategory2" class="form-label">교환</label>
				<div class="form-check checkbox-wrap">
					<input class="form-check-input" type="radio" value="교환불가"
					name="p_exchange" id="flexRadioDefault3" checked>
					<label class="form-check-label2" for="flexRadioDefault3"> 교환불가 </label>
				</div>
				<div class="form-check checkbox-wrap">
					<input class="form-check-input" type="radio" value="교환가능"
						name="p_exchange" id="flexRadioDefault4">
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
						name="p_price" id="p_price">
						<span class="input-group-text">원</span>
					</div>
				</div>
				<div class="form-check deliveryfee-check">
					<input class="form-check-input" type="checkbox" name="p_dfee" id="p_dfee"> <!-- value초기값 on으로 들어감 value="${pvo.p_dfee}" onchange="pCheck()" -->
					<input class="form-check-input" type="hidden" name="_p_dfee" value="on" />
					<label class="form-check-label" for="p_dfee"> 배송비 포함 </label>
				</div>
			</div>
			<hr>
			<!--상품설명-->
			<div class="d-flex flex-row mb-3">
				<label for="inputPrice" class="form-label">상품 설명</label>
				<textarea class="form-control width-calc170" rows="5"
					placeholder="여러 장의 상품 사진과 구입 연도, 브랜드, 사용감, 하자 유무 등 구매자에게 필요한 정보를 꼭 포함해 주세요. (10자 이상)"
					 name="p_content" id="p_content"></textarea>
			</div>
			<hr>
			<!--판매수량
			<div class="d-flex flex-row mb-3 ">
				<label for="inputPrice" class="form-label ">수량</label>
				<div class="input-group mb-3 custom-width">
					<input type="number" class="form-control" value="1"> <span
						class="input-group-text">개</span>
				</div>
			</div>
			<hr>
			-->
			
			<!-- 판매자 연락처 -->
			<div class="d-flex flex-row mb-3">
				<label for="inputTitle" class="form-label">연락처</label>
				<input type="text" class="form-control width-calc170" maxlength="40"
					placeholder="구매자가 개별적으로 연락할 수 있는 전화번호 혹은 카카오톡 아이디를 입력해주세요."
					 name="p_contact" id="p_contact">
			</div>
			<!-- <input class="form-check-input" type="hidden" name="w_cnt" id="w_cnt" value="0" /> -->


			<!-- 등록하기 버튼 -->
			<div class="col-12">
				<button type="submit" class="btn bg-danger bg-gradient btn-submit"
					style="float: right; color: #fff" onclick="location.href='/productUpload/write.do'">등록하기</button>
			</div>
		</form>

	</div>


	<footer>
		<%@ include file="/WEB-INF/views/footer/footer.jsp"%>
	</footer>

 
</body>

</html>