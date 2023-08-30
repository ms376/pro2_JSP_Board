package model2.mvcboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.BoardPage;

public class ListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//DAO객체 생성을 통해 커넥션 풀로 DB에 연결한다.
		MVCBoardDAO dao = new MVCBoardDAO();
		
		//Model(데이터베이스),View(JSP페이지)로 파라미터 및 데이터를 전달하기 위해 생성한다.
		Map<String,Object> map = new HashMap<String, Object>();
		
		//request 내장객체를 통해 파라미터를 받아온다.
		String searchField = request.getParameter("searchField");
		String searchWord = request.getParameter("searchWord");
		
		if (searchWord!= null) {
			//검색어가 있는 경우 Map에 파라미터를 저장한다.
			map.put("searchField",searchField);
			map.put("searchWord", searchWord);
		}
		//전체게시물의 갯수를 카운터하여 반환한다.
		//게시물의 갯수를 통해 가상번호를 부여하거나 전체 페이지수를 계산한다.
		int totalCount = dao.selectCount(map);
		
		/*페이지 처리 start*/
		/*
			서블릿에서 application내장객체를 얻어온 후 web.xml에 설정한
				컨텍스트 초기화 파라미터를 읽어온다.
			한페이지에 출력할 게시물의 갯수와 한블럭당 출력할 페이지번호의 갯수이다.
		 */
		ServletContext application = getServletContext();
		int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
		int blocPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
		/*
		  	목록에 첫지잆히 무조건 1페이지로 가정한 후 게시물을 얻오안다.
		  	특정 페이지로 진입한 경우에는 파라미터를 받아서 구간을 게산한다.
		 */
		int pageNum = 1;
		//파라미터로 넘어오는 pageNum이 있다면 값을 얻어온다.
		String pageTemp = request.getParameter("pageNum");
		//값이 있다면 정수로 변환한 후 페이지 번호로 지정한다.
		if(pageTemp!= null && !pageTemp.equals(""))
			pageNum = Integer.parseInt(pageTemp);
		
		//게시물 구간을 계산한다.
		int start = (pageNum-1)*pageSize+1;
		int end = pageNum*pageSize;
		//계산된 값은 Model로 전달되기 위해 Map컬렉션에 저장한다.
		map.put("start",start);
		map.put("end",end);
		/*페이지 처리 end*/

		//현재 페이지에 출력할 게시물 셀렉
		List<MVCBoardDTO> boardLists = dao.selectListPage(map);
		//자원반납(커넥션풀)
		dao.close();
		//페이지 번호 생성을 위한 유틸리티 클래스 메소드 호출
		//모딜1방식의 게시판에서 사용했던 메소드 그대로 사용
		String pagingImg = BoardPage.pagingStr(totalCount,pageSize,blocPage,pageNum,"../mvcboard/list.do");
		//View로 전달할 데이터 Map에 저장
		//ㅁ록록 하단에 출력할 페이지 번호
		map.put("pagingImg",pagingImg);
		//전체 게시물 갯수
		map.put("totalCount",totalCount);
		//페이지당 나올 게시물 갯수(설정값)
		map.put("pageSize",pageSize);
		//현재 페이지 번호
		map.put("pageNum",pageNum);
		
		//view로 전달할 객체들을 request영역에 저장한다.
		request.setAttribute("boardLists",boardLists);
		request.setAttribute("map",map);
		request.getRequestDispatcher("/ms/board/dboard.jsp").forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
