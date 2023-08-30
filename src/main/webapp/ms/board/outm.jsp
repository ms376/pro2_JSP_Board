<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Scanner"%>
<%@ page import="utils.BoardPage"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="model1.board.BoardDAO"%>
<%@ page import="model1.board.BoardDTO"%>
<%@ page import="membership.MemberDAO"%>
<%@ page import="membership.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
// DB연결 및 CRUD작업을 위한 DAO객체를 생성한다.
BoardDAO dao = new BoardDAO(application);

// 검색어가 있는 경우 클라가 선택한 필드명과 검색어를 저장할 Map컬렉션을 생성한다.
Map<String, Object> param = new HashMap<String, Object>();
/*
	검색폼에서 입력한 검색어와 필드명을 파라미터로 받아온다.
	해당 <form>의 전송방식은 get, action속성은 없는 상태이므로
	현재 페이지로 폼값이 전송된다.
*/
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
String searchId = request.getParameter("searchId");
// 사용자가 입력한 검색어가 있다면...
if (searchWord != null) {
	// Map컬렉션에 컬럼명과 검색어를 추가한다.
	param.put("searchField", searchField);
	param.put("searchWord", searchWord);
	param.put("searchId", searchId);
}
// Map컬렉션을 인수로 게시물의 갯수를 count한다.
int totalCount = dao.selectCount(param);

/*** 페이징 코드 추가 부분 ***/
// web.xml에 설정한 컨텍스트 초기화 파라미터를 읽어와서 산술연산을 위해
// 정수(int)로 변환한다. 
int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
/*
	전체 페이지수를 계산한다.
	(전체 게시물 갯수 / 페이지당 출력할 게시물 갯수) => 결과값의 올림처리
	가령 게시물의 갯수가 51개라면 나눳을때 결과가 5.1이 된다. 이때 무조건
	올림처리 하여 6페이지가 나오게 된다.
	만약 totalcount를 double로 형변환하지 않으면 정수의 결과가 나오게되므로,
	6페이지가 아니라 5페이지가 된다. 따라서 주의해야 한다.
*/
int totalPage = (int) Math.ceil((double) totalCount / pageSize); // 전체페이지 수
/*
	목록에 처음 진입했을 때는 페이지관련 파라미터가 없는 상태이므로 무조건
	1page로 지정한다. 만약 파라미터 pageNum이 있다면 request내장객체를 통해
	받아온 후 페이지 번호로 지정한다.
	List.jsp = > 이와 같이 파라미터가 없는 상태일때는 null
	List.hsp?pageNum=> 이와 같이 파라미터는 있는데 값이 없을 때는 빈값으로
	체크된다.
*/

int pageNum = 1;
String pageTemp = request.getParameter("pageNum");
if (pageTemp != null && !pageTemp.equals(""))
	pageNum = Integer.parseInt(pageTemp);
/*
	게시물의 구간을 계산한다.
	각 페이지의 시작번호와 종료번호를 현재페이지번호와 페이지사이즈를 통해
	계산한 후 DAO로 전달하기 위해 Map컬렉션에 추가한다.
*/
int start = (pageNum - 1) * pageSize + 1;
int end = pageNum * pageSize;
param.put("start", start);
param.put("end", end);
// 페이지 처리 end

// 목록에 출력할 게시물을 추출하여 반환받는다.
List<BoardDTO> boardLists = dao.selectListPage(param);
// 자원해제
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
<link rel="stylesheet" type="text/css" href="css/style.css">
<link rel="stylesheet"
	href="https://ddo7jzca0m2vt.cloudfront.net/unify/css/theme-colors/blue.css?version=20230101">
<link rel="stylesheet" type="text/css" href="css/animate.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:700"
	rel="stylesheet">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
						<a href="../memb/join.jsp">회원가입</a>&nbsp;&nbsp;&nbsp;
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
				<div class="card animated fadeIn">
					<div style="text-align: center;">
						<h3>회원탈퇴</h3>
					</div>
					<h3>
						<strong>회원정보 재확인</strong>
					</h3>
					<form action="../../membership/WithdrawServlet.do" method="post">

						<%
						String UserId = null;
						if (session.getAttribute("UserId") != null) {
							UserId = (String) session.getAttribute("UserId");
						}
						if (UserId == null) {
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('로그인을 하세요.')");
							script.println("location.href='../memb/LoginForm.jsp'");
							script.println("</script>");
						}

						MemberDAO memberDAO = new MemberDAO(application);
						int result = memberDAO.delete(UserId);
						if (result == -1) {
							//데이터 베이스 오류가 날 때
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('회원탈퇴에 실패했습니다.')");
							script.println("history.back()");
							script.println("</script>");
						} else {
							session.invalidate();
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('회원탈퇴에 성공했습니다.')");
							script.println("location.href='../board/main.jsp'");
							script.println("</script>");
						}
						%>
					</form>
					<br />
				</div>
				<br /> <br /> <br />
				<script>
					/*
						최하측 검정라인 위치고정
					 */
					(adsbygoogle = window.adsbygoogle || []).push({});
				</script>

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