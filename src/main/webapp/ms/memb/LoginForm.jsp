<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<meta name="description" content="">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-Control" content="no-cache" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Imagetoolbar" content="no" />
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.88.1">
<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
<title>로그인</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.2.0/css/bootstrap.min.css">
<%
String ctx = request.getContextPath();
%>
<style>
div {
	margin-left: 100px;
}
</style>
</head>
<script type="text/javascript">
function changeCaptcha() {
	  //IE에서 '새로고침'버튼을 클릭시 CaptChaImg.jsp가 호출되지 않는 문제를 해결하기 위해 "?rand='+ Math.random()" 추가
	  $('#catpcha').html('<img src="<%=ctx%>/ms/memb/CaptChaImg.jsp?rand='+ Math.random() + '"/>');
	 }

 function winPlayer(objUrl) {
  $('#audiocatpch').html(' <bgsound src="' + objUrl + '">');
 }
 
 function audioCaptcha() {

   var uAgent = navigator.userAgent;
   var soundUrl = 'CaptChaAudio.jsp';
	 if (!!document.createElement('audio').canPlayType) {
       //Chrome일 경우 호출
       try { new Audio(soundUrl).play(); } catch(e) { winPlayer(soundUrl); }
   } else window.open(soundUrl, '', 'width=1,height=1');
 }
 
 //화면 호출시 가장 먼저 호출되는 부분
 $(document).ready(function() {
  
  changeCaptcha(); //Captcha Image 요청
  
  $('#reLoad').click(function(){ changeCaptcha(); }); //'새로고침'버튼의 Click 이벤트 발생시 'changeCaptcha()'호출
  $('#soundOn').click(function(){ audioCaptcha(); }); //'음성듣기'버튼의 Click 이벤트 발생시 'audioCaptcha()'호출
  
  //'확인' 버튼 클릭시
  $('#frmSubmit').click(function(){
      if ( !$('#answer').val() ) {
           alert('이미지에 보이는 숫자 또는 스피커를 통해 들리는 숫자를 입력해 주세요.');
      } else {
           $.ajax({
               url: 'CaptchaSubmit.jsp',
               type: 'POST',
               dataType: 'text',
               data: 'answer=' + $('#answer').val(),
               async: false,  
               success: function(resp) {
                    alert(resp);
                    $('#reLoad').click();
                    $('#answer').val('');
              }
         });
      }
  });
 });
</script>
<body>
	<span style="color: red; font-size: 1.2em;"> </span>
	<%=request.getAttribute("LoginErrMsg") == null ? "" : request.getAttribute("LoginErrMsg")%>
	<%
	if (session.getAttribute("UserId") == null) {
	%>
	<script>
		function validateForm(form) {
			if (!form.user_id.value) {
				alert("아이디를 입력하세요.");
				return false;
			}
			if (form.user_pw.value == "") {
				alert("패스워드를 입력하세요.");
				return false;
			}
		}
	</script>
	<main class="form-signin">
		<form action="LoginProcess.jsp" method="post" name="loginFrm"
			onsubmit="return validateForm(this);">
			<img class="mb-4" src="ddabonglogin.jpg" alt=""
				style="margin-top: 100px; margin-left: 100px;" width="450"
				height="350">
			<h1 class="h3 mb-3 fw-normal" style="margin-left: 100px;">
				<b>로그인</b>
			</h1>
			<div class="form-floating"
				style="margin-left: 100px; margin-bottom: 6px;">
				<input type="text" class="form-control" name="user_id"
					style="width: 300px;" maxlength='20' placeholder="ID"> <label
					for="floatingInput"><b>ID(아이디)</b></label>
			</div>
			<div class="form-floating"
				style="margin-left: 100px; margin-bottom: 6px;">
				<input type="password" class="form-control" name="user_pw"
					style="width: 300px;" maxlength='20' placeholder="비밀번호"> <label
					for="floatingPassword"><b>비밀번호</b></label>
			</div>
			<div class="checkbox mb-3"
				style="margin-left: 100px; margin-bottom: 6px;">
				<label> <input type="checkbox" value="remember-me"
					name="remember"> <b>로그인 상태 유지</b>
				</label>
			</div>
			<button class="btn btn-primary" type="submit"
				style="margin-left: 100px;">로그인</button>
			<button class="btn btn-primary" type="button"
				style="margin-left: 20px;" onclick="location.href='join.jsp'">
				회원가입</button>
		</form>
	</main>
	<%
	} else
	{
	%>
	<%=session.getAttribute("UserName")%>
	회원님, 로그인하셨습니다.
	<br />
	<h6 href="Logout.jsp">[로그아웃]</h6>
	<%
	}
	%>
</body>
</html>
