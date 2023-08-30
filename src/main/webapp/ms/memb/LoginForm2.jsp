<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.88.1">
<title>로그인</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.2.0/css/bootstrap.min.css">
<style>
div {
	margin-left: 100px;
}

.jb-red {
	color: red;
}
</style>
</head>
<body>
	<span style="color: red; font-size: 1.2em;"> </span>
	<%=request.getAttribute("LoginErrMsg") == null ? "" : request.getAttribute("LoginErrMsg")%>
	<%
	/*
		세션 영역에 UserId라는 속성값이 없는경우, 즉 로그인 처리가 되지 않은
		상태에서는 로그인폼과 검증을 위한 JS를 웹브라우저에 출력한다.
	*/
	if (session.getAttribute("UserId") == null) {
	%>
	<script>
		function validateForm(form) {
			/*
				<form>태그 하위의 각 input 태그에 입력값이 있는지 확인하여
				만약 빈값이라면 경고창, 포커스이동, 폼값전송 취소처리를
				한다.
			 */

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
			<h6 class="jb-red" style="margin-left: 100px;">ID 혹은 비밀번호를 잘못 입력하셨거나 등록되지 않은 ID 입니다.</h6>
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
			<button class="btn" type="submit" style="margin-left: 100px;">로그인</button>
			<button class="btn" type="button" style="margin-left: 20px;"
				onclick="location.href='join.jsp'">회원가입</button>
		</form>
		<%
		} else
		{
		/*
			session영역에 저장된 속성값이 있다면 로그인 된 상태이므로
			회원정보 및 로그아웃 버튼을 화면에 출력한다.
		*/
		%>
		<%=session.getAttribute("UserName")%>
		회원님, 로그인하셨습니다. <br />
		<h6 href="Logout.jsp">[로그아웃]</h6>
		<%
		}
		%>
</body>

</html>