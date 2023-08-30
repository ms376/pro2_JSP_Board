<%@ page import="fileupload.MyfileDAO"%>
<%@ page import="fileupload.MyfileDTO"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.io.File"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
/*
	파일 업로드를 위한 디렉토리의 물리적경로(절대경로)를 얻어온다.
	물리적경로가 필요한 이유는 운영체제에 따라 경로를 표현하는 방식이
	다르기 때문이다.
*/
// String saveDirectory = application.getRealPath("/Uploads");
String saveDirectory = request.getRealPath("/Uploads");
// 업로드할 파일의 최대용량제한 (1mb로 지정함)
int maxPostSize = 1024 * 1000;
// 인코딩 방식 지정
String encoding = "UTF-8";

try{
	/*
		앞에서 준비한 3개의 인수과 request내장객체 까지를 이용해서
		MultipartRequest 객체를 생성한다. 해당객체가 정상적으로 생성되면
		파일업로드는 완료됩니다.
	*/
	MultipartRequest mr = new MultipartRequest(request,saveDirectory,maxPostSize,encoding);
	
	//mr 객체를 통해 서버에 저장된 파일명을 가져온다.
	String fileName = mr.getFilesystemName("attachedFile");
	/*
		파일명에서 앞의 "."을 찾아 인덱스를 확인한 후 확장자를 잘라낸다.
		확장자는 파일의 용도를 나타내는 부분이므로 중요하다.
		파일명에 "." 을 여러개 사용할 수 있으므로 끝에서부터 찾는다.
	*/
	String ext = fileName.substring(fileName.lastIndexOf("."));
	// 현재 날짜와 시간 및 밀리세컨즈까지 이용해서 파일명으로 사용할 문자열을 만든다.
	String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
	// 확장자와 파일명을 합쳐서 서버에 저장할 파일명을 만들어준다.
	String newFileName = now +ext;
	
	/*
		서버에 저장된 파일의 파일명을 새로운 파일명으로 변경 해준다.
		여기서 사용된 separator는 경로를 표시할 때 사용하는 구분기호로
		윈도우의 경우 \(역슬래시), 리눅스의 경우 /(슬래시)를 자동으로 부여해준다.
		File객체를 각각 생성한 후 renameTo()메서드를 통해 변경한다.
	*/
	
	File oldFile = new File(saveDirectory + File.separator + fileName);
	File newFile = new File(saveDirectory + File.separator + newFileName);
	oldFile.renameTo(newFile);
	/*
		파일을 제외한 나머지 폼값을 받는다. 단 이떄 request객체
	*/
	String name = mr.getParameter("name");
	String title = mr.getParameter("title");
	String[] cateArray = mr.getParameterValues("cate");
	StringBuffer cateBuf = new StringBuffer();
	if(cateArray == null){
		cateBuf.append("선택없음");
	}else{
		// 체크한 항목의 갯수만큼 반복하여 StringBuffer에 추가한다.
		for(String s : cateArray){
			cateBuf.append(s+", ");
		}
	}
	
	// DTO 생성 및 폼값을 세팅한다.
	MyfileDTO dto = new MyfileDTO();
	dto.setName(name);
	dto.setTitle(title);
	// 입력전 StringBuffer객체를 String으로 변환해 준다.
	dto.setCate(cateBuf.toString());
	dto.setOfile(fileName);
	dto.setSfile(newFileName);
	
	// DAO를 통해 DB에 입력한다.
	MyfileDAO dao = new MyfileDAO();
	dao.insertFile(dto);
	// 자원반납 (커넥션풀에 Connection객체를 반납한다.)
	dao.close();
	
	// 파일 업로드에 성공한 경우 파일목록으로 이동한다.
	response.sendRedirect("FileList.jsp");
}
catch(Exception e){
	/*
		파일 업로드에 실패한 경우 request영역에 에러메세지를 저장한 후
		업로드 폼으로 포워드한다.
	*/
	e.printStackTrace();
	request.setAttribute("errorMessage", "파일 업로드 오류");
	request.getRequestDispatcher("FileUploadMain.jsp").forward(request, response);
}
%>