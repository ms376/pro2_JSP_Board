package membership;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteMemberServlet extends HttpServlet {
    private MemberDAO memberDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        memberDAO = new MemberDAO(getServletContext());
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("doget받아옴");
    	String memberId = request.getParameter("memberId");
        System.out.println(memberId);
            
        int deleteCount = memberDAO.deleteMember(memberId);
        System.out.println(memberDAO.deleteMember(memberId));
        try
		{
        	if (deleteCount > 0) {
        		response.sendRedirect("../ms/board/adboard.jsp");
        	} else {
        		response.getWriter().println("삭제에 실패하였습니다.");
        	}
			
		} catch (Exception e)
		{
			System.out.println("홀리몰리과카몰리");
			e.printStackTrace();
			// TODO: handle exception
		}
    }

}
