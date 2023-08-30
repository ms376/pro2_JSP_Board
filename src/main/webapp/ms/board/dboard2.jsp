<%@ page import="utils.BoardPage"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="model1.board.BoardDAO"%>
<%@ page import="model1.board.BoardDTO"%>
<%@ page import="model2.mvcboard.MVCBoardDAO"%>
<%@ page import="model2.mvcboard.MVCBoardDTO"%>
<%@ page import="model2.mvcboard.MVCBoardDAO"%>
<%@ page import="model2.mvcboard.MVCBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%-- core 라이브러리 적용 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<%
BoardDAO dao = new BoardDAO(application);
Map<String, Object> param = new HashMap<String, Object>();
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
if (searchWord != null) {
	param.put("searchField", searchField);
	param.put("searchWord", searchWord);
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

MVCBoardDAO mdao = new MVCBoardDAO();
List<MVCBoardDTO> mboardLists = mdao.selectListPage(param);
mdao.close();
%>
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
						<a href="#">회원가입</a>&nbsp;&nbsp;&nbsp;
						<a href="../memb/LoginForm.jsp">로그인</a>
						<%
						} else {
						%>
						<b>안녕하세요.</b>&nbsp;&nbsp;
						<a href="#"><%=session.getAttribute("UserName")%></a>
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
						<a class="navbar-brand" href="/"><img id="logo-header"
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
									<li><a href="/lectures">위치</a></li>
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
			<div class="margin-bottom-20 no-print"></div>
			<div class="row">
				<div class="col-md-12">
					<ul class="nav nav-pills">
						<li><a href="../ms/board/main.jsp">전체게시판</a></li>
						<li><a href="../ms/board/noticeboard.jsp">공지사항</a></li>
						<li><a href="../ms/board/fboard.jsp">자유게시판</a></li>
						<li class="active"><a href="dboard2.jsp">자료실</a></li>
						<li><a href="../ms/board/hboard.jsp">Hot 게시판</a></li>
						<li><a href="../ms/board/rectop.jsp">top 댓글</a></li>
					</ul>
				</div>
				<div class="margin-bottom-30"></div>
				<div class="col-md-12">
					<div class="table-responsive">
						<table class="table table-bordered table-striped"
							style="width: 100%;">
							<thead>
								<tr>
									<th style="width: 6%;">번호</th>
									<th style="width: 40%;">제목</th>
									<th style="width: 8%;">작성자</th>
									<th style="width: 7%;">조회수</th>
									<!-- 따봉 -->
									<th style="width: 5%;"><span
										class="glyphicon glyphicon-thumbs-up"></span></th>
									<th style="width: 20%;">작성일</th>
									<th style="width: 14%;">다운로드</th>
								</tr>
								<c:choose>
									<c:when test="${ empty boardLists }">
										<!-- 게시물을 저장하고 있는 boardLists 컬렉션에 내용이 없다면 아래부분을 출력한다. -->
										<tr>
											<td colspan="6" align="center">등록된 게시물이 없습니다^^*</td>
										</tr>
									</c:when>
									<c:otherwise>
										<!-- 게시물이 있을 때ㅣ 컬렉션에 저장된 목록의 갯수만큼 반복한다. -->
										<c:forEach items="${ boardLists }" var="row" varStatus="loop">
											<!-- 가상번호 계산하기 -->
											<tr align="center">
												<!-- 번호 -->
												<td>${ map.totalCount - (((map.pageNum-1) * map.pageSize) + loop.index)}
												</td>
												<!-- 제목 -->
												<td align="left">
													<!-- 제목을 클릭할 경우 내용보기 페이지로 이동한다. --> <a
													href="../mvcboard/view.do?idx=${ row.idx }">${ row.title }</a>
												</td>
												<!-- 작성자 -->
												<td>${ row.name }</td>
												<!-- 조회수 -->
												<td>${ row.visitcount }</td>
												<!-- 따봉 -->
												<td>#</td>
												<!-- 작성일 -->
												<td>${ row.postdate }</td>
												<!-- 다운로드 -->
												<td>
												<c:if test="${ not empty row.ofile }">
													<a href="../mvcboard/download.do?ofile=${ row.ofile }&sfile=${ row.sfile }&idx=${ row.idx }">[Down]</a>
												</c:if>
												</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</thead>
						</table>
					</div>
				</div>
	<div class="col-md-12 margin-bottom-20">
					<h6>
					<!-- 페이징 -->
					 ${ map.pagingImg }
					</h6>
				<!-- 서치포인트 -->
			</div>
			<div class="col-md-12 text-center">
				<form class="form-inline" role="form" method="post">
					<div class="form-group">
						<select class="form-control" name="searchField">
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="#">작성자</option>
						</select>
					</div>
					<div class="form-group">
						<input type="text" class="form-control" name="searchWord"
							placeholder="" value="">
					</div>
					<input type="hidden" value="all" name="search_category">
					<button type="submit" class="btn-u btn-u-blue">검색</button>
					<button type="button" onclick="location.href='../mvcboard/write.do';" class="btn-u btn-u-blue">글쓰기</button>
				</form>
			</div>
		</div>
	</div>

	<!-- 하단 하단 하단 하단 하단 하단 하단 하단 하단 하단 하단 하단 하단 하단  -->
		<div class="footer-v3 no-print">
			<div class="footer">
				<div class="container">
					<div class="row">
						<div class="col-sm-3 md-margin-bottom-40">
							<ul class="list-unstyled simple-list margin-bottom-10">
								<li><a href="mapb.jsp">찾아오는길</a></li>
								<li><a href="#">102</a></li>
							</ul>
							<h2>홀리몰리 과카몰리</h2>
						</div>
						<ul class="list-inline simple-list margin-bottom">
							<li><a href="#">ㅁㅁㅁㅁㅁ</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>