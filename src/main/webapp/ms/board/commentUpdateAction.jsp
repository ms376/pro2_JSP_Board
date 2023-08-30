<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="comment.CommentDAO" %>
<%
    String bbsID = request.getParameter("bbsID");
    String commentID = request.getParameter("commentID");
    String commentContent = request.getParameter("commentContent");

    CommentDAO commentDAO = new CommentDAO();
    int result = commentDAO.update(Integer.parseInt(bbsID), Integer.parseInt(commentID), commentContent);
    
    if (result > 0) {
%>
        <script>
            alert("댓글이 수정되었습니다.");
            location.href = "vboard.jsp?num=<%=bbsID%>";
        </script>
<%
    } else {
%>
        <script>
            alert("댓글 수정에 실패하였습니다.");
            history.go(-1);
        </script>
<%
    }
%>
