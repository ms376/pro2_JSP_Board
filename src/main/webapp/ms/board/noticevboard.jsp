<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="model1.noticeboard.BoardDAO"%>
<%@ page import="model1.noticeboard.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
/*
	목록에서 제목을 클릭하면 게시물의 일련번호를 ?num=99 와 같이 받아온다.
	따라서 내용보기를 위해 해당 파라미터를 받아온다.
*/
String num = request.getParameter("num");
// DAO객체 생성을 통해 oracle에 연결한다.
BoardDAO dao = new BoardDAO(application);
// 게시물 조회수 증가
dao.updateVisitCount(num);
// 게시물의 내용을 인출하여 DTO로 반환받는다.
BoardDTO dto = dao.selectView(num);
dao.close();
%>
<%-- core 라이브러리 적용 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>게시판 전체</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<!-- 뼈대 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.2.0/css/bootstrap.min.css">
<!-- unity 상단메뉴 위치지정-->
<link rel="stylesheet"
	href="https://ddo7jzca0m2vt.cloudfront.net/unify/css/style.css?version=20230101">
<!-- css 로고 크기지정-->
<link rel="stylesheet"
	href="https://ddo7jzca0m2vt.cloudfront.net/unify/css/custom.css?version=20230101">
<!-- ajax 스크롤바 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.css">
<!-- 폰트 -->
<link rel="stylesheet"
	href="https://ddo7jzca0m2vt.cloudfront.net/unify/css/theme-colors/blue.css?version=20230101">
<meta name="username" content="">
<style>
.jb-red {
	color: red;
}
</style>
<script>
	// 게시물 삭제를 위한 JS함수
	function deletePost() {
		// confirm()함수는 대화창에서 "예"를 누를 떄 true가 반환된다.
		var confirmed = confirm("정말로 삭제하겠습니까?");
		if (confirmed) {
			// <form>의 name속성을 통해 DOM을 가져온다.
			var form = document.writeFrm;
			// 전송방식과 폼값을 전송할 URL을 설정 한다.
			form.method = "post";
			form.action = "../aboutpost/DeleteProcess2.jsp";
			// submit() 함수를 통해 폼값을 전송한다.
			form.submit();
			// <form>태그 하위의 hidden박스에 설정된 일련번호가 전송된다.
		}
	}
</script>
</head>
<body>
	<div class="wrapper">
		<div class="header no-print">
			<div class="topbar">
				<div class="container">
					<ul class="loginbar pull-right">
						<%
						if (session.getAttribute("UserId") == null) {
						%>
						<a href="../memb/join.jsp">회원가입</a>&nbsp;&nbsp;&nbsp;
						<a href="../memb/LoginForm.jsp">로그인</a>
						<%
						} else {
						%>
						<b>안녕하세요.</b>&nbsp;&nbsp;
						<a href="../memb/prof.jsp"><%=session.getAttribute("UserName")%></a>
						<b>님&nbsp;</b>
						<a class="jb-red" href="../memb/Logout.jsp">로그아웃</a>
						<%
						}
						%>
						&nbsp;&nbsp;&nbsp;
					</ul>
				</div>
			</div>
			<div class="navbar navbar-default mega-menu" role="navigation">
				<div class="container">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse"
							data-target=".navbar-responsive-collapse">
							<span class="sr-only">Toggle navigation</span><span
								class="fa fa-bars"></span>
						</button>
						<a class="navbar-brand" href="main.jsp"><img id="logo-header"
							src="ddabongmain.jpg" alt="Logo" data-retina></a>
					</div>
					<div class="collapse navbar-collapse navbar-responsive-collapse">
						<ul class="nav navbar-nav">
							<li class="dropdown mega-menu-fullwidth "><a
								class="dropdown-toggle" data-toggle="dropdown">게시판</a>
								<ul class="dropdown-menu">
									<li><div class="mega-menu-content">
											<div class="container">
												<div class="row equal-height">
													<div class="col-md-3 equal-height-in">
														<ul class="list-unstyled equal-height-list">
															<li><h3>게시판 목록</h3></li>
															<li><a href="noticeboard.jsp">공지사항</a></li>
															<li><a href="fboard.jsp">자유게시판</a></li>
															<li><a href="../../mvcboard/list.do">자료실</a></li>
															<%
															if ("관리자".equals(session.getAttribute("UserName"))) {
															%>
															<li><a href="adboard.jsp">관리자 게시판</a></li>
															<%
															} else {
															%>
															<li><a href="popup.jsp">관리자 게시판</a></li>
															<%
															}
															%>
														</ul>
													</div>
												</div>
											</div>
										</div></li>
								</ul></li>
							<li><a href="mapb.jsp">지도</a></li>
							<li class="dropdown "><a href="javascript:void(0);"
								class="dropdown-toggle" data-toggle="dropdown">더 보기</a>
								<ul class="dropdown-menu">
									<li><a href="mapb.jsp">위치</a></li>
									<li><a href="#">채팅</a></li>
									<li><a href="#">신고</a></li>
								</ul></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<form action="/logout" method="post" id="logout_form">
			<input type='hidden' value='%2Fboard%2Flist%2Fall' name="next">
		</form>

		<div class="container content">
			<div style="width: 100%;" class="no-print">
				<script async src="" crossorigin="anonymous"></script>
				<ins class="adsbygoogle" style="display: block;"
					data-ad-client="ca-pub-8806842758252812" data-ad-slot="1129585289"
					data-ad-format="horizontal" data-full-width-responsive="true"></ins>
				<script>
					/*
						최하측 검정라인 위치고정
					*/
					(adsbygoogle = window.adsbygoogle || []).push({});
				</script>
			</div>
			<div class="margin-bottom-20 no-print"></div>
			<div class="row">
				<div class="col-md-12">
					<ul class="nav nav-pills">
						<li><a href="main.jsp">전체게시판</a></li>
						<li><a href="noticeboard.jsp">공지사항</a></li>
						<li><a href="fboard.jsp">자유게시판</a></li>
						<li><a href="../../mvcboard/list.do">자료실</a></li>
					</ul>
				</div>
				<div class="margin-bottom-30"></div>
				<div class="col-md-12">

					<!-- view view view view view view view view view view view view -->
					<form name="writeFrm">
		<!--
			게시물 삭제를 위해 hidden타입의 input상자에 
		 -->
		<input type="hidden" name="num" value="<%=num%>" />
		<table class="table table-bordered table-striped"
							style="width: 100%;">
			<tr>
				<td>번호</td>
				<td><%=dto.getNum()%></td>
				<td>작성자</td>
				<td><%=dto.getName()%></td>
			</tr>
			<tr>
				<td>작성일</td>
				<td><%=dto.getPostdate()%></td>
				<td>조회수</td>
				<td><%=dto.getVisitcount()%></td>
			</tr>
			<tr>
				<td>제목</td>
				<td colspan="3"><%=dto.getTitle()%></td>
			</tr>
			<tr>
				<td>내용</td>
				<td colspan="3" height="100">
				<%=dto.getContent().replace("\r\n", "<br/>")%>
				</td>
			</tr>
			<tr>
				<td colspan="4" align="center">
				<%
				if(session.getAttribute("UserId")!=null
				&& session.getAttribute("UserId").toString().equals(dto.getId())){
				%>
					<button type="button" class="btn" onclick="location.href='noticeeboard.jsp?num=<%=dto.getNum()%>';">수정하기</button>
					<button type="button" class="btn" onclick="deletePost();">삭제하기</button> <% } %>
					<button type="button" class="btn" onclick="location.href='../board/noticeboard.jsp';">
						돌아가기</button>
				</td>
			</tr>
		</table>
	</form>
				</div>
				<div class="col-md-12 text-center"><br />
					<form class="form-inline" role="form" 
						method="post">
						<div class="form-group">
							<select class="form-control" name="searchField">
								<option value="title">제목</option>
								<option value="content">내용</option>
								<option value="id">작성자</option>
							</select>
						</div>
						<div class="form-group">
							<input type="text" class="form-control" name="searchWord"
								placeholder="" value="">
						</div>
						<input type="hidden" value="all" name="search_category">
						<button type="submit" class="btn-u btn-u-blue">검색</button>
						<button type="button" class="btn-u btn-u-blue" onclick="location.href='noticewboard.jsp'">글쓰기</button>
					</form>
				</div>
			</div>
		</div>

		<div class="footer-v3 no-print">
			<div class="footer">
				<div class="container">
					<div class="row">
						<div class="col-sm-3 md-margin-bottom-40">
							<ul class="list-unstyled simple-list margin-bottom-10">
								<li><a href="mapb.jsp">찾아오는길</a></li>
								<li><a href="#">신고하기</a></li>
							</ul>
							<h2>게시판입니다.</h2>
						</div>
						<ul class="list-inline simple-list margin-bottom">
							<li><a href="#">문의하기</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>