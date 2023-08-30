<%@ page import="model1.noticeboard.BoardDAO"%>
<%@ page import="model1.noticeboard.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn2.jsp"%>
<%
String num = request.getParameter("num");
String title = request.getParameter("title");
String content = request.getParameter("content");

BoardDTO dto = new BoardDTO();
dto.setNum(num);
dto.setTitle(title);
dto.setContent(content);

// DAO객체 생성을 통해 오라클에 연결한다.
BoardDAO dao = new BoardDAO(application);
// update 쿼리문을 실행하여 게시물을 수정한다.
int affected = dao.updateEdit(dto);
// 자원해제
dao.close();

if (affected==1)
{
	/*
		수정이 완료되었으면 수정된 내용을 확인하기 위해 주로 내용보기
		페이지로 이동한다.
	*/
	response.sendRedirect("../board/noticevboard.jsp?num="+dto.getNum());
}else{
	/*
		
	*/
	JSFunction.alertBack("수정하기에 실패하였습니다.", out);
}
%>
