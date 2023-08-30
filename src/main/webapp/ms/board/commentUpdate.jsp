<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="comment.Comment" %>
<%
    String bbsID = request.getParameter("bbsID");
    String commentID = request.getParameter("commentID");

    CommentDAO commentDAO = new CommentDAO();
    Comment comment = commentDAO.getComment(Integer.parseInt(commentID));
    
    if (comment == null) {
%>
        <script>
            alert("댓글을 찾을 수 없습니다.");
            history.go(-1);
        </script>
<%
    } else {
%>
        <!DOCTYPE html>
        <html>
        <head>
            <title>댓글 수정</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta charset="utf-8">
        </head>
        <body>
            <h1>댓글 수정</h1>
            <form action="commentUpdateAction.jsp" method="post">
                <input type="hidden" name="bbsID" value="<%=bbsID%>">
                <input type="hidden" name="commentID" value="<%=commentID%>">
                <textarea name="commentContent" rows="4" cols="50"><%=comment.getCommentContent()%></textarea><br>
                <input type="submit" value="수정">
            </form>
        </body>
        </html>
<%
    }
%>
