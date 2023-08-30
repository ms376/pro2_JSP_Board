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
<link href="login.css" rel="stylesheet">
</head>
<body>
	<span style="color: red; font-size: 1.2em;"> </span>
	<script>
		function validateForm(form) {
			if (form.pass.value == "") {
				alert("비밀번호를 입력하세요.");
				form.pass.focus();
				return false;
			}
		}
	</script>
		<img class="mb-4" src="../ms/board/dda.jpg" alt="" style="margin-top: 100px;"
			width="450" height="350">
		<form name="writeFrm" method="post" action="../mvcboard/pass.do"
			onsubmit="return validateForm(this);">
			<input type="hidden" name="idx" value="${ param.idx }" /> <input type="hidden" name="mode" value="${ param.mode }" />
					<table class="table col-md-12 table-striped" style="width: 100%;">
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pass" style="width: 100px;" />
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<button type="submit" class="btn">검증하기</button>
						<button type="reset" class="btn">RESET</button>
						<button type="button" class="btn"
							onclick="location.href='../mvcboard/list.do';">목록바로가기</button>
				</td>
				</tr>
			</table>
			
		</form>
</body>

</html>