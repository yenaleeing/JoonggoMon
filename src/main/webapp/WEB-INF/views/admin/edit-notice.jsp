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



<%@ include file="/WEB-INF/views/admin/header/headerIncludeLink.jsp"%>
<script src="<c:url value ='/resources/js/ckeditor/ckeditor.js'/>"></script>
<link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>

<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js" ></script>
 
<style>
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




	})
	


//이미지 삭제
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


					<h4 class="text-info text-center">공지게시판 수정</h4>
					<br>
					<div class="container" role="main">

						<form action="editNotiBoard/edit.do" method="post" enctype="multipart/form-data">
							
							<input value="${sessionScope.managerid}" name="manager_id" id="manager_id" type="hidden">
							<input value="${notice.noti_board_id}" name ="noti_board_id" id="noti_board_id" type="hidden">
							<div class="mb-3">

								<label for="title">제목</label> <input type="text"
									class="form-control" name="n_title" id="n_title"
									placeholder="제목을 입력해 주세요" value="${notice.n_title}">

							</div>


							<div class="mb-3">
 

	 					<div class="form-check">
	 							   
	 							   
									<input class="form-check-input" type="radio"
										name="n_important" id="n_important1" value="1"  <c:if test="${notice.n_important =='1'}">checked</c:if>> <label
										class="form-check-label" > 긴급공지
									</label> &nbsp;&nbsp;&nbsp;&nbsp; &nbsp; <input
										class="form-check-input" type="radio" name="n_important"
										id="n_important2" value="2"   <c:if test="${notice.n_important =='2'}">checked</c:if>><label
										class="form-check-label"  > 일반공지
									</label> 
									
								</div>  

							</div>


								<div class="mb-3">

								<label for="content">내용</label>

								<textarea  name="n_contents" id="n_contents">
									${notice.n_contents }
								</textarea>

							</div>


				 

							<div class="mb-3">

								<div class="form-check">
									<input class="form-check-input" type="checkbox" value=""
										id="noticeValid"> <label class="form-check-label"
										for="noticeValid"> 회원들이 보게 될 공지사항입니다. 자세한 검토 후 작성
										부탁드립니다. </label>
								</div>
							</div>
 
						     
				 <div class="input-group mb-3">
					   <div class="filebox clearfix">
						    <div class="inputFile">
						        <label for="AddImgs" class="addImgBtn">+</label>
						        <input type="file" id="AddImgs" name="AddImgs" class="upload-hidden" accept=".jpg, .png, .gif"   style="display:none;" multiple>
						    </div>
						    <ul id="Preview" class="sortable">
						          <c:forEach items="${imgList}" var="file">
						           <li class="ui-state-default">
						             <img src="<c:url value = '/noticeboardPic/'/>${file.n_imgname } " title="  ${file.n_imgname } " width=80 height=80 id=" ${file.n_imgname }"> 
						              <span class="delBtn" onclick="delImg(this)">x</span>
						              <input type="hidden" name="existingImages" value="${file.n_originafile}">
						              </li>
						        </c:forEach>
						    </ul> 
						</div>
					</div>
					
	

						<div class="justify-content-center">

							<input type="submit" class="btn btn-sm btn-primary" value="글수정"/>
							<button type="button" class="btn btn-sm btn-primary"
								id="btnreset">다시쓰기</button>
							<button type="button" class="btn btn-sm btn-primary" id="btnList" onclick="location.href='noticeboard'" >목록</button>

						</div>
				</form>
					</div>


					

				</div>




			</div>

		</div>
	</div>

</body>

<script>
$(function () {
	 
	CKEDITOR.replace('n_contents');
   
	
 
});


   
</script>


</html>