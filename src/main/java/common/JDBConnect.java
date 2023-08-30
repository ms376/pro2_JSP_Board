package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.Servlet;
import javax.servlet.ServletContext;

// DB 연결을 위한 클래스 생성
public class JDBConnect
{
	// 멤버변수 : 연결, 쿼리문 실행 및 전송, 결과셋 반환
	public Connection con; // DB와 연결
	public Statement stmt; // 인파라미터가 없는 정적 쿼리문을 사용할때 사용
	public PreparedStatement psmt; // 인파라미터가 없는 동적 쿼리문을 사용할때 사용
	public ResultSet rs; // SELECT 쿼리문의 결과를 저장할때 사용
	
	// 기본 생성자 : 매개변수가 없는 생성자
	public JDBConnect()
	{
		try
		{
			// 오라클 드라이브 로드
			Class.forName("oracle.jdbc.OracleDriver");
			// 커넥션 URL, 계정 아이디와 패스워드 기술
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String id = "musthave";
			String pwd = "1234";
			// 오라클 DB 연결
			con = DriverManager.getConnection(url, id, pwd);

			// 연결 성공시 console 로그
			System.out.println("DB연결 성공 ( 기본 생성자 )");

		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	public JDBConnect(String driver, String url, String id, String pwd)
	{
		try
		{
			// JDBC 드라이버 로드
			Class.forName(driver);
			// DB에 연결
			con = DriverManager.getConnection(url, id, pwd);
			System.out.println("DB연결 성공(인수 생성자1)");
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	// 인수생성자2 : application내장객체 사용을 위한 매개변수 선언
	public JDBConnect(ServletContext application)
	{
		/*
			JSP의 내장객체는 메서드에서는 즉시 사용할 수 없고 반드시 매개변수로
			참조값을 받은 후 사용해야 한다.
		*/
		try
		{
			// web.xml에 정의된 컨텍스트 초기화 파라미터를 직접 얻어와서 드라이버 로드
			// 및 연결을 진행.
			String driver = application.getInitParameter("OracleDriver");
			Class.forName(driver);
			String url = application.getInitParameter("OracleURL");
			String id = application.getInitParameter("OracleId");
			String pwd = application.getInitParameter("OraclePwd");
			con = DriverManager.getConnection(url, id, pwd);
			System.out.println("DB연결 성공 (인수 생성자2)");
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

	// 연결 해제(자원 반납)
	public void close()
	{
		try
		{
			if (rs != null)
				rs.close();
			if (stmt != null)
				stmt.close();
			if (psmt != null)
				psmt.close();
			if (con != null)
				con.close();

			System.out.println("JDBC 자원 해제");
		} catch (Exception e)
		{
			e.printStackTrace();
		}
	}

}
