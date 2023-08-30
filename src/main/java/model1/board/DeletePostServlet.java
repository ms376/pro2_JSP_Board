package model1.board;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import model1.board.BoardDAO;  // 게시판 DAO 클래스 임포트

public class DeletePostServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String postId = request.getParameter("postId"); // 게시글 ID 파라미터 가져오기
        
        // 애플리케이션 컨텍스트 객체 얻기
        ServletContext application = getServletContext();

        BoardDAO dao = new BoardDAO(application); // DAO 객체 생성
        
        // 게시글 삭제 로직
        boolean success = dao.AddeletePost(postId); // deletePost 메소드는 실제로 게시글을 삭제하는 로직입니다.
        
        dao.close(); // DAO 자원 정리
        
        if (success) {
            response.setStatus(200); // 삭제 성공
        } else {
            response.setStatus(500); // 삭제 실패 또는 오류
        }
    }
}
