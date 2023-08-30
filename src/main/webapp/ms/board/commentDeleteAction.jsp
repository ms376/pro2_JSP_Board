<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="comment.Comment" %>
<%
    String bbsID = request.getParameter("bbsID");
    String commentID = request.getParameter("commentID");

    CommentDAO commentDAO = new CommentDAO();
    int result = commentDAO.delete(Integer.parseInt(commentID));
    
    if (result > 0) {
        response.sendRedirect("vboard.jsp?num=" + bbsID);
    } else {
%>
        <script>
            alert("댓글 삭제에 실패하였습니다.");
            history.go(-1);
        </script>
<%
    }
%>
