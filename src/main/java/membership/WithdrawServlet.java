package membership;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import membership.MemberDAO;
import membership.MemberDTO;

public class WithdrawServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("userId");
        String userPw = request.getParameter("user_pw");
        String userName = request.getParameter("user_name");

        MemberDAO memberDAO = new MemberDAO(getServletContext());
        
        if (userId != null) { // 로그인 상태인지 확인
            // 세션을 통해 저장된 userId를 이용하여 회원 탈퇴 시도
            int withdrawResult = memberDAO.deleteMember(userId, userPw, userName); // 회원 탈퇴 시도
            
            if (withdrawResult == 1) {
                session.invalidate(); // 세션을 무효화하여 로그아웃 처리
                response.sendRedirect("../ms/board/main.jsp"); // 탈퇴 성공 시 메인 페이지로 이동
            } else {
                response.getWriter().write("회원 탈퇴 실패");
            }
        } else {
            response.getWriter().write("로그인 상태가 아닙니다.");
        }
    }
}
