<%@page import="membership.MemberDAO"%>
<%@page import="membership.MemberDTO"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="utils.BoardPage"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Date"%>
<%@ page import="model1.board.BoardDAO"%>
<%@ page import="model1.board.BoardDTO"%>
<%@ page import="model2.mvcboard.MVCBoardDAO"%>
<%@ page import="model2.mvcboard.MVCBoardDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
BoardDAO dao = new BoardDAO(application);
Map<String, Object> param = new HashMap<String, Object>();
MemberDAO memberDAO = new MemberDAO(application);
List<MemberDTO> memberList = memberDAO.adviewmember();
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
String searchId = request.getParameter("searchId");
if (searchWord != null) {
	param.put("searchField", searchField);
	param.put("searchWord", searchWord);
	param.put("searchId", searchId);
}
int totalCount = dao.selectCount(param);
int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
int totalPage = (int) Math.ceil((double) totalCount / pageSize); // 전체페이지 수
int pageNum = 1;
String pageTemp = request.getParameter("pageNum");
if (pageTemp != null && !pageTemp.equals(""))
	pageNum = Integer.parseInt(pageTemp);
int start = (pageNum - 1) * pageSize + 1;
int end = pageNum * pageSize;
param.put("start", start);
param.put("end", end);
List<BoardDTO> boardLists = dao.selectListPage(param);
dao.close();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>게시판 전체</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="utf-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://ddo7jzca0m2vt.cloudfront.net/unify/css/style.css?version=20230101">
<link rel="stylesheet"
	href="https://ddo7jzca0m2vt.cloudfront.net/unify/css/custom.css?version=20230101">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.css">
<link rel="stylesheet"
	href="https://ddo7jzca0m2vt.cloudfront.net/unify/css/theme-colors/blue.css?version=20230101">
<meta name="username" content="">
<style>
.jb-red {
	color: red;
}

.jb-red2 {
	color: red;
	font-size: 3px;
}

th {
	text-align: center;
}
</style>
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
							src="../ms/board/ddabongmain.jpg" alt="Logo" data-retina></a>
					</div>
					<div class="collapse navbar-collapse navbar-responsive-collapse">
						<ul class="nav navbar-nav">
							<li class="dropdown mega-menu-fullwidth "><a
								class="dropdown-toggle" data-toggle="dropdown">문제</a>
								<ul class="dropdown-menu">
									<li><div class="mega-menu-content">
											<div class="container">
												<div class="row equal-height">
													<div class="col-md-3 equal-height-in">
														<ul class="list-unstyled equal-height-list">
															<li><h3>게시판1123123123</h3></li>
															<li><a href="/problemset">게시판1</a></li>
															<li><a href="/category">게시판1</a></li>
															<li><a href="/step">게시판1</a></li>
															<li><a href="/problem/ranking">게시판1</a></li>
														</ul>
													</div>
												</div>
											</div>
										</div></li>
								</ul></li>
							<li><a href="/workbook/top">게시판1</a></li>
							<li class="dropdown "><a href="javascript:void(0);"
								class="dropdown-toggle" data-toggle="dropdown">더 보기</a>
								<ul class="dropdown-menu">
									<li><a href="mapb.jsp">위치</a></li>
									<li><a href="/blog/list">채팅</a></li>
									<li><a href="/change">신고</a></li>
								</ul></li>
							<li><a href="/search"><i class="fa fa-search search-btn"></i></a></li>
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
			<div>
				<a class="jb-red" style="font-size: 20px;"
					href="../ms/board/adboard.jsp">관리자 페이지1</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a class="jb-red" style="font-size: 20px;" href="adboard2.">관리자
					페이지2</a>
			</div>
			<div class="margin-bottom-30"></div>
			<div class="col-md-12">
				<div class="table-responsive">
					<table class="table table-bordered table-striped"
						style="width: 100%;">
						<form action="RetrievePostsServlet.do" method="post">
							<label for="authorId">작성자 ID:</label> <input type="text"
								id="authorId" name="authorId">
							<button type="submit">조회</button>
						</form>
						<div class="margin-bottom-30"></div>
						<div class="col-md-12">
							<div class="table-responsive">
								<table class="table table-bordered table-striped"
									style="width: 100%;">
									<thead>
										<tr>
											<th style="width: 35%;">게시판 제목</th>
											<th style="width: 25%;">작성 날짜</th>
											<th style="width: 20%;">삭제하기</th>
										</tr>
									</thead>
									<tbody>
										<%
										List<BoardDTO> postList = (List<BoardDTO>) request.getAttribute("postList");
										for (BoardDTO post : postList) {
										%>
										<tr>
											<td><%=post.getTitle()%></td>
											<td><%=post.getPostdate()%></td>
											<script>
												function AddeletePost(postId) {
													if (confirm("정말로 게시글을 삭제하시겠습니까?")) {
														var xhr = new XMLHttpRequest();
														xhr.onreadystatechange = function() {
															if (xhr.readyState === XMLHttpRequest.DONE) {
																if (xhr.status === 200) {
																	alert("게시글이 삭제되었습니다.");
																	location
																			.reload();
																} else {
																	alert("게시글 삭제 중 오류가 발생했습니다.");
																}
															}
														};

														// 서블릿 주소를 올바르게 수정
														xhr
																.open(
																		"POST",
																		"model1.board/DeletePostServlet.do",
																		true);
														xhr
																.setRequestHeader(
																		"Content-type",
																		"application/x-www-form-urlencoded");
														xhr
																.send("postId="
																		+ encodeURIComponent(postId));
													}
												}
											</script>
											<td>
												<button style="align-content: center;" class="btn"
													onclick="AddeletePost('<%=post.getId()%>');">삭제하기</button>
											</td>
										</tr>
										<%
										}
										%>
									</tbody>
								</table>
							</div>
							<br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
							<br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
							<br /> <br /> <br /> <br /> <br /> <br />


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
</html>