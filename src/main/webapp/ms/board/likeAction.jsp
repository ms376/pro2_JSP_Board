<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="comment.CommentDAO" %>
<%
    String bbsID = request.getParameter("bbsID");
    String commentID = request.getParameter("commentID");
    String userID = (String) session.getAttribute("UserID");

    CommentDAO commentDAO = new CommentDAO();
    commentDAO.likeComment(Integer.parseInt(commentID)); // 댓글의 좋아요 수 증가

    // 좋아요 테이블에 좋아요 정보를 추가한다 (bbsID, commentID, userID)
    commentDAO.insertLike(Integer.parseInt(bbsID), Integer.parseInt(commentID), userID);
%>
<script>
    alert("좋아요 처리되었습니다.");
    location.href = "vboard.jsp?num=<%=bbsID%>";
</script>
