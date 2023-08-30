<%@ page import="membership.MemberDTO"%>
<%@ page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
// 로그인 폼에서 입력한 아이디, 패스워드를 받는다;
String userId = request.getParameter("user_id");
String userPwd = request.getParameter("user_pw");

// web.xml에 입력한 컨텍스트 초기화 파라미터를 읽어온다.
// 해당정보는 오라클에 접속하기 위한 값으로 구성되어 있다.
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

// 위 정보를 통해 DAO객체를 생성하고 이때 오라클에 연결된다.
MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
// 폼값으로 받은 아이디, 패스워드를 인수로 전달하여 로그인 처리를 위한 쿼리를 
// 실행한다.
MemberDTO memberDTO = dao.getMemberDTO(userId, userPwd);
// 자원해제
dao.close();

// 로그인
if (memberDTO.getId() != null)
{
	// 성공
	// 세션영역에 회원 ID,NAME 저장
	session.setAttribute("UserId", memberDTO.getId());
	session.setAttribute("UserPass", memberDTO.getPass());
	session.setAttribute("UserName", memberDTO.getName());
	session.setAttribute("UserRegidate", memberDTO.getRegidate());
	// 로그인 페이지로 이동
	response.sendRedirect("../board/main.jsp");
} else
{
	// 실패
	response.sendRedirect("LoginForm2.jsp");
}
%>
<%-- $('#catpcha').html('<img src="<%=ctx%>/ms/board/captcha/CaptChaImg.jsp?rand= --%>
