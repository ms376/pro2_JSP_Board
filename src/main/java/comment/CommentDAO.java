package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class CommentDAO extends JDBConnect
{
	public CommentDAO() {
	    conn = super.con;
	}
	private Connection conn;// 데이터베이스에 접근하게 해주는 하나의 객체
	private ResultSet rs;// 정보를 담을 수 있는 객체

	public String getDate()
	{ 
		// 현재 서버 시간 가져오기
		String SQL = "select sysdate from dual"; // 현재 시간을 가져오는 SQL문
		try
		{
			stmt = con.createStatement();
			rs = stmt.executeQuery(SQL);	//실행결과 가져오기
			if (rs.next())
			{
				return rs.getString(1);	//현재 날짜 반환
			}

		} catch (Exception e)
		{
			e.printStackTrace();	//오류 발생
			System.out.println("시간가져오기 오류");
		}
		return "";	//데이터베이스 오류
	}

	public int getNext()
	{
		String SQL = "SELECT commentID from commentt order by commentID DESC";	//마지막 게시물 반환
		try
		{
			PreparedStatement stmt = conn.prepareStatement(SQL);
			rs = stmt.executeQuery();
			if (rs.next())
			{
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 게시물인 경우

		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return -1;	//데이터베이스 오류
	}

	public int write(String commentContent, String userID, int bbsID)
	{
		String SQL = "insert into commentt VALUES (?, ?, ?, ?, ?, ?, ?)";
		try
		{
			PreparedStatement stmt = conn.prepareStatement(SQL);
			stmt.setString(1, commentContent);
			stmt.setInt(2, getNext());
			stmt.setString(3, userID);
			stmt.setInt(4, 1);
			stmt.setString(5, getDate());
			stmt.setInt(6, bbsID);
			stmt.setInt(7, getLikeCount(bbsID));
			return stmt.executeUpdate();

		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return -1;
	}

	public ArrayList<Comment> getList(int bbsID)
	{
		//특정한 리스트를 받아서 반환
		//마지막 게시물을 가져옴
		String SQL = "SELECT * FROM ( SELECT * FROM commentt WHERE bbsID = :1 AND commentAvailable = 1 ORDER BY bbsID DESC ) WHERE ROWNUM <= 10";
		ArrayList<Comment> list = new ArrayList<Comment>();
		try
		{
			PreparedStatement stmt = conn.prepareStatement(SQL);
			stmt.setInt(1, bbsID);
			rs = stmt.executeQuery();
			while (rs.next())
			{
				Comment comment = new Comment();
				comment.setCommentContent(rs.getString(1));
				comment.setCommentID(rs.getInt(2));
				comment.setUserID(rs.getString(3));
				comment.setCommentAvailable(rs.getInt(4));
				comment.setCommentDate(rs.getString(5));
				comment.setBbsID(rs.getInt(6));
				list.add(comment);
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return list; //댓글 리스트 반환
	}

	public Comment getComment(int commentID) {
		//하나의 댓글 내용을 불러오는 함수
		String SQL = "SELECT * from commentt where commentID = ?";
		try
		{
			PreparedStatement stmt = conn.prepareStatement(SQL);
			stmt.setInt(1, commentID);
			rs = stmt.executeQuery();// select
			if (rs.next())
			{ //결과가 있다면
				Comment comment = new Comment();
				comment.setCommentContent(rs.getString(1));
				comment.setCommentID(rs.getInt(2));
				comment.setUserID(rs.getString(3));
				comment.setCommentAvailable(rs.getInt(4));
				comment.setCommentDate(rs.getString(5));
				comment.setBbsID(rs.getInt(6));
				return comment;
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	public int update(int bbsID, int commentID, String commentContent)
	{
		//특정한 아이디에 해당하는 제목과 내용을 바꿔줌
		String SQL = "UPDATE commentt SET commentContent = ? WHERE bbsID = ? AND commentID = ?";
		try
		{
			PreparedStatement stmt = conn.prepareStatement(SQL);
			//물음표의 순서
			stmt.setString(1, commentContent); 
			stmt.setInt(2, bbsID);
			stmt.setInt(3, commentID);
			// insert,delete,update
			return stmt.executeUpdate();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return -1;
	}

	public int delete(int commentID)
	{
		String SQL = "UPDATE commentt SET commentAvailable = 0 WHERE commentID = ?";
		try
		{
			PreparedStatement stmt = conn.prepareStatement(SQL);
			stmt.setInt(1, commentID);
			return stmt.executeUpdate();
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		return -1;
	}
	
	public int getLikeCount(int bbsID) {
	    String SQL = "SELECT likeCount FROM commentt WHERE bbsID = ?";
	    try {
	        PreparedStatement stmt = conn.prepareStatement(SQL);
	        stmt.setInt(1, bbsID);
	        rs = stmt.executeQuery();
	        if (rs.next()) {
	            return rs.getInt("likeCount");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return 0;
	}

	public int likeComment(int bbsID, int commentID, String userID) {
	    String SQL = "INSERT INTO comment_like (bbsID, commentID, userID) VALUES (?, ?, ?)";
	    try {
	        PreparedStatement stmt = conn.prepareStatement(SQL);
	        stmt.setInt(1, bbsID);
	        stmt.setInt(2, commentID);
	        stmt.setString(3, userID);
	        return stmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return -1;
	}
	public void likeComment(int commentID) {
		String SQL = "UPDATE commentt SET likeCount = likeCount + 1 WHERE commentID = ?";

        try {
        	PreparedStatement stmt = conn.prepareStatement(SQL);
            stmt = conn.prepareStatement(SQL);
            stmt.setInt(1, commentID);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 좋아요 정보를 좋아요 테이블에 추가하는 메서드
    public void insertLike(int bbsID, int commentID, String userID) {
        String SQL = "INSERT INTO comment_like (bbsID, commentID, userID) VALUES (?, ?, ?)";
        try {
        	PreparedStatement stmt = conn.prepareStatement(SQL);
            stmt = conn.prepareStatement(SQL);
            stmt.setInt(1, bbsID);
            stmt.setInt(2, commentID);
            stmt.setString(3, userID);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
