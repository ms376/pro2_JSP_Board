<%@page import="java.io.File"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.List"%>
<%@ page import="fileupload.MyfileDAO"%>
<%@ page import="fileupload.MyfileDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>DB 등록 파일목록</h2>
	<a href="FileUploadMain.jsp">파일 등록하기</a>
	<%
	// DAO 생성을 통해 DBCP로 커넥션한다.
	MyfileDAO dao = new MyfileDAO();
	List<MyfileDTO> fileLists = dao.myFileList();
	// 커넥션 객체를 반납
	dao.close();
	%>
	<table border="1">
		<tr>
			<th>No</th>
			<th>작성자</th>
			<th>제목</th>
			<th>카테고리</th>
			<th>원본 파일명</th>
			<th>저장된 파일명</th>
			<th>작성일</th>
			<th></th>
		</tr>
		<%
		for (MyfileDTO f : fileLists)
		{
		%>
		<tr>
			<td><%=f.getIdx()%></td>
			<td><%=f.getName()%></td>
			<td><img src="../Uploads/<%=f.getSfile()%>" width="100" /> <%=f.getTitle()%></td>
			<td><%=f.getCate()%></td>
			<td><%=f.getOfile()%></td>
			<td><%=f.getSfile()%></td>
			<td><%=f.getPostdate()%></td>
			<td><a
				href="Download.jsp?oName=<%=URLEncoder.encode(f.getOfile(), "UTF-8")%>
			&sName=<%=URLEncoder.encode(f.getSfile(), "UTF-8")%>">[다운로드]</a></td>
		</tr>
		<%
		}
		%>
	</table>
	<h2>업로드된 파일 리스트 보기</h2>
	<%
	// 파일이 저장된 디렉토리의 물리적 경로를 얻어온다.
	String dir = application.getRealPath("/Uploads");
	// 물리적 경로를 인수로 File객체를 생성한다.
	File file = new File(dir);
	// 디렉토리의 파일목록을 읽어와서 배열형태로 반환
	File[] fileArr = file.listFiles();
	int fileCnt = 1;
	//파일의 갯수만큼 반복한다.
	for (File f : fileArr)
	{
	%>
	<li>파일명<%=fileCnt%> : <%=f.getName()%> 파일크기 : <%=(int) Math.ceil(f.length() / 1024.0)%>kb
	</li>
	<%
	fileCnt++;
	}
	%>

</body>
</html>