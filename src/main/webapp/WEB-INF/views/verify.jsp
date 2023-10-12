<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>

    
<%@ include file="/WEB-INF/views/header/headerIncludeLink.jsp"%>
 
   

<style>
@import url('https://fonts.googleapis.com/css?family=Montserrat:400,800');

 
 

.h1-abc {
  font-weight: bold;
  margin: 0;
}

.h2-abc {
  text-align: center;
}

.p-abc {
  font-size: 14px;
  font-weight: 100;
  line-height: 20px;
  letter-spacing: 0.5px;
  margin: 20px 0 30px;
}

.span-abc {
  font-size: 12px;
}

.a-abc {
  color: #333;
  font-size: 14px;
  text-decoration: none;
  margin: 15px 0;
}

.button-abc {
  border-radius: 20px;
  border: 1px solid #FF4B2B;
  background-color: #FF4B2B;
  color: #FFFFFF;
  font-size: 12px;
  font-weight: bold;
  padding: 12px 45px;
  letter-spacing: 1px;
  text-transform: uppercase;

}

button:active {
  transform: scale(0.95);
}

button:focus {
  outline: none;
}


.form-abc {
  background-color: #FFFFFF;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  padding: 0 50px;
  height: 100%;
  text-align: center;
}

.input-abc {
  background-color: #eee;
  border: none;
  padding: 12px 15px;
  margin: 8px 0;
  width: 100%;
}
.select-abc {
  background-color: #eee;
  border: none;
  padding: 12px 15px;
  margin: 8px 0;
  width: 100%;
}
.container-abc {
  background-color: #fff;
  border-radius: 10px;
    box-shadow: 0 14px 28px rgba(0,0,0,0.25), 
      0 10px 10px rgba(0,0,0,0.22);
  position: relative;
  overflow: hidden;
  width: 77vh;
  max-width: 100%;
  min-height: 480px;
}

.form-container-abc {
  position: absolute;
  top: 0;
  height: 100%;
  transition: all 0.6s ease-in-out;
  left: 0;
  width: 50%;
  z-index: 2;
}


.result-container {
  position: absolute;
  top: 0;
  left: 50%;
  width: 50%;
  height: 100%;
  overflow: hidden;
  transition: transform 0.6s ease-in-out;
  z-index: 100;
}


.result {
  background: #FF416C;
  background: -webkit-linear-gradient(to right, #FF4B2B, #FF416C);
  background: linear-gradient(to right, #FF4B2B, #FF416C);
  background-repeat: no-repeat;
  background-size: cover;
  background-position: 0 0;
  color: #FFFFFF;
  position: relative;
  left: -100%;
  height: 100%;
  width: 200%;
}


.result-panel {
  position: absolute;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  padding: 0 40px;
  text-align: center;
  top: 0;
  height: 100%;
  width: 50%;
}

.result-rightpanel {
  position: absolute;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  padding: 0 40px;
  text-align: center;
  top: 0;
  height: 100%;
  width: 50%;
  right: 0;
}
 

.body-abc{
  margin-top: 13vh;
  margin-bottom: 14.5vh;
}
</style>      
       
 
 
</head>
<header>

 <%@ include file="/WEB-INF/views/header/header.jsp"%>
 
</header>

<body >


<center>

<div class="body-abc">
<div class="container-abc mt-5 mb-5" id="container">
  <div class="form-container-abc">
    <form id="verificationForm" class="form-abc">
      <h1 class="h1-abc">Verification</h1>
      <span class="span-abc">조회할 정보를 입력해주세요.</span>
      <select name="selectdata" class="select-abc">
	    <option value="H">전화번호</option>
	    <option value="A">계좌번호</option>
	    <option value="E">Email주소</option>
	  </select>
      <input name="inputdata" class="input-abc" type="text"/>
      <a href="#" class="a-abc">안전한 사이버 거래, <br>경찰청 사이버캅과 함께해요!</a>
      <button type="submit" class="button-abc">결과 조회</button>
    
    </form>
  </div>
  <div class="result-container">
    <div class="result">
      <div class="result-rightpanel">
        <h1 class="h1-abc">조회 결과</h1>
        <p class="p-abc" id="resultText">거래 전 반드시 상대방이 최근 3개월 내 3회 이상 '사이버사기'로 사이버범죄 신고시스템에 신고된 사실이 있는지 확인해 보세요.</p>

        <div>
        <button onclick="window.open('https://cyber.go.kr/prevention/prevention1.jsp?mid=020301')" class="btn" href="">예방수칙</button>
        <button onclick="window.open('https://ecrm.police.go.kr/minwon/main')" class="btn" id="signUp">신고하기</button>
		</div>
      </div>
    </div>
  </div>
</div>
</div>
</center>


    <!-- JavaScript 코드 -->
    <script>

/*     function fn_submit() {
        $.ajax({
            type: "POST",
            url: "/verify1",
            dataType: "json",
            data: {
                "selectdata": $("select[name='selectdata']").val(),
                "inputdata": $("input[name='inputdata']").val()
            },
            success: function(data) {
                $("#resultText").text(data); // 서버에서 받아온 데이터 출력
                console.log(data);   
                
            },
            error: function(data) {
                $("#resultText").text("실패"); // 에러 메시지 표시
                console.log(data);
        
            }
        });
    } */
    
    document.getElementById("verificationForm").addEventListener("submit", function(event) {
        event.preventDefault(); // 폼 제출 동작 중지

        const processVerify = document.getElementById("resultText");
        processVerify.textContent = "결과조회중입니다."; // 서버에서 받아온 데이터 출력

        const formData = new FormData(event.target);
        fetch("/verify1", {
            method: "POST",
            body: formData
        })
        .then(response => response.json()) // JSON으로 변환
        .then(data => {
            processVerify.textContent = data.result; // 서버에서 받아온 데이터 출력
        })
        .catch(error => console.error("Error:", error));
    });
    
    
    
    
    
    </script>
    

<footer >
 <%@ include file="/WEB-INF/views/footer/footer.jsp"%>
</footer> 

</body>


