package membership;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import membership.MemberDAO;
import membership.MemberDTO;

public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String userId = request.getParameter("id");
        String userPw = request.getParameter("pass");
        String userName = request.getParameter("name");

        MemberDTO dto = new MemberDTO();
        dto.setId(userId);
        dto.setPass(userPw);
        dto.setName(userName);
        
        MemberDAO memberDAO = new MemberDAO(getServletContext());
        int result = memberDAO.insertMember(dto);
        
        if (result == 1) {
            response.sendRedirect("../ms/memb/LoginForm.jsp"); // 회원가입 성공 시 메인 페이지로 이동
        } else if (result == -1) {
            // 아이디 중복
            response.getWriter().write("아이디가 이미 존재합니다.");
        } else if (result == -2) {
            // 이름 중복
            response.getWriter().write("이름이 이미 존재합니다.");
        } else {
            // 기타 오류
            response.getWriter().write("회원가입 실패");
        }
        
        
    }
}