<%@page import="java.util.concurrent.TimeUnit"%>
<%@ page import="utils.BoardPage"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="model1.board.BoardDAO"%>
<%@ page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
BoardDAO dao = new BoardDAO(application);
Map<String, Object> param = new HashMap<String, Object>();
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
if (searchWord != null)
{
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
%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://ddo7jzca0m2vt.cloudfront.net/unify/css/theme-colors/blue.css?version=20230101">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
body {
	font-size: 12px; /* 원하는 폰트 크기로 설정 */
}
</style>
</head>
<body>
	<div class="margin-bottom-30"></div>
	<div class="col-md-12">
		<div class="table-responsive">
			<table class="table table-bordered table-striped"
				style="width: 100%;">
				<thead>
					<%
					if (boardLists.isEmpty())
					{
					%>
					<tr>
						<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
					</tr>
					<%
					} else
					{
					int virtualNum = 0;
					int countNum = 0;
					for (BoardDTO dto : boardLists)
					{
						virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
					%>
					<tr align="center" >
						<td style="width: 5%;"><%=virtualNum%></td>
						<td style="width: 35%;" align="left"><a
							href="vboard.jsp?num=<%=dto.getNum()%>"><%=dto.getTitle()%></a></td>
						<td style="width: 15%;">자유게시판</td>
						<td style="width: 13%;" align="center"><%=dto.getId()%></td>
						<td style="width: 7%;" align="center"><%=dto.getVisitcount()%></td>
						<td style="width: 10%;" align="center"><%=dto.getPostdate()%>
							<%
							// 최신글표시임
							java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
							java.util.Date currentDate = new java.util.Date();
							java.util.Date postDate = sdf.parse(sdf.format(dto.getPostdate()));
							long diffInMillies = Math.abs(currentDate.getTime() - postDate.getTime());
							long diffInDays = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
							if (diffInDays <= 1)
							{
								out.print("&nbsp;<a class='jb-red2'>NEW</a>");
							}
							%></td>
					</tr>
					<%
					}
					}
					%>
				</thead>
			</table>
		</div>
	</div>
</body>
</html>