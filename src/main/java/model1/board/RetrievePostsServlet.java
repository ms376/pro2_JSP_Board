package model1.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RetrievePostsServlet extends HttpServlet {
    private BoardDAO dao; // BoardDAO 객체를 멤버 변수로 선언

    @Override
    public void init() throws ServletException {
        super.init();
        ServletContext context = getServletContext();
        dao = new BoardDAO(context); // DAO 객체 초기화
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String authorId = request.getParameter("authorId");

        List<BoardDTO> postList = dao.selectListByAuthor(authorId);

        request.setAttribute("postList", postList);
        request.getRequestDispatcher("/ms/board/adboard2.jsp").forward(request, response);
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // GET 요청에 대한 처리 코드
        String authorId = request.getParameter("authorId");

        List<BoardDTO> postList = dao.selectListByAuthor(authorId);

        request.setAttribute("postList", postList);
        request.getRequestDispatcher("/ms/board/adboard2.jsp").forward(request, response);
    }
}

