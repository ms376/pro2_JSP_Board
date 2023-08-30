<%@ page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
/*
	로그인 체크를 위한 파일로 섹션영역에 UserId라는 
*/
    if(session.getAttribute("UserId")== null){
    	JSFunction.alertLocation("로그인 후 이용해 주십시오.","../memb/LoginForm.jsp", out);
    	return;
    }
    %>
