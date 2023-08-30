 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="captcha.CaptCha"%>
<%
    new CaptCha().getCaptCha(request, response); 
%>