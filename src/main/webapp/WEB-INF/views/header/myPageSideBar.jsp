 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> 
 
 <div class="col-lg-3">
      <div class="accordion" id="accordionExample">
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingOne">
            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
              회원정보
            </button>
          </h2>
          <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
            <div class="accordion-body">
            <ul class="list-group">
                <li class="list-group-item"><a href="editInfo"><i class="fa fa-pencil"></i> 정보 수정하기</a></li>
                <li class="list-group-item"><li class="list-group-item"><a href="/myPage/memRemove?user_id=${user_id}" class="text-danger" onclick="return confirm('정말 회원탈퇴를 진행하시겠습니까?')"><i class="fa fa-trash"></i> 회원 탈퇴</a></li>
              </ul>
            </div>
          </div>
        </div>
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingTwo">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
              활동내역
            </button>
          </h2>
          <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
            <div class="accordion-body">
              <ul class="list-group">
                <li class="list-group-item"><a href="/member/myProduct"><i class="fa fa-inbox"></i> 내가 올린 물품 <span class="badge badge-pill badge-primary">${ProductNumber}</span></a></li>
                <li class="list-group-item"><a href="/member/myBoard"><i class="fa fa-file-text"></i> 내가 쓴 게시물 <span class="badge badge-pill badge-info">${BoardNumber}</span></a></li>
                <li class="list-group-item"><a href="/member/wishlist"><i class="fa fa-tags"></i> 위시리스트 <span class="badge badge-pill badge-info">${wantCount}</span></a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>

    </div>