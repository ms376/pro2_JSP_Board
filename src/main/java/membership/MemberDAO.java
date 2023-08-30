package membership;

import javax.servlet.ServletContext;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import common.JDBConnect;
import model1.board.BoardDTO;
/*
	DAO(data access object) : 실제 DB에 접근하여 여러가지 CRUD작업을
		하기위한 객체(Create Read Update Delete)
*/
public class MemberDAO extends JDBConnect
{
	// 생성자 메서드
	// 매개변수가 4개인 부모의 생성자를 호출하여 DB에 연결한다.
	public MemberDAO(String drv, String url, String id, String pw)
	{
		super(drv, url, id, pw);
	}
	// application 내장객체만 매개변수로 전달한 후 DB에 연결한다.
	public MemberDAO(ServletContext application)
	{
		super(application);
	}
	
	/*
		사용자가 입력한 아이디, 패스워드를 통해 회원테이블을 select한 후
		존재하는 정보인 경우 DTO객체에 그 정보를 담아 반환한다.
	*/
	public MemberDTO getMemberDTO(String uid, String upass)
	{
		// 로그인을 위한 쿼리문을 실행한 후 회원정보를 저장하기 위해 생성
		MemberDTO dto = new MemberDTO();
		// 로그인을 위해 인파라미터가 있는 동적 쿼리문 작성
		String query = "Select * from member where id=? and pass=?";
		try
		{
			// 쿼리문 실행을 위한 prepared객체 생성 및 인파라미터 생성
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			// select 쿼리문을 실행한 후 ResultSet으로 반환받는다.
			rs = psmt.executeQuery();

			// 반환된 ResultSet객체를 통해 회원정보가 있는지 확인한다.
			if (rs.next())
				// 정보가 있다면 DTO객체에서 회원정보를 저장
			{
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
				dto.setRegidate(rs.getString(4));
			}
		} catch (Exception e)
		{
			e.printStackTrace();
		}
		// 호출한 지점으로 DTO객체를 반환한다.
		return dto;
	}
	
    public int insertMember(MemberDTO member) {
    	
        String id = member.getId();
        String pass = member.getPass();
        String name = member.getName();
        String regidate = member.getRegidate();

        // 아이디 중복 체크
        if (isIdDuplicated(id)) {
            return -1; // id가 중복됨
        }

        // 이름 중복 체크
        if (isNameDuplicated(name)) {
            return -2; // name이 중복됨
        }

        // 중복이 아니라면 회원 정보 삽입
        String query = " INSERT INTO member (id, pass, name, regidate) VALUES (?, ?, ?, ?) ";
        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, member.getId());
            psmt.setString(2, member.getPass());
            psmt.setString(3, member.getName());
            
            // 현재 시간을 가져와서 regidate에 설정
            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            psmt.setTimestamp(4, timestamp);

            int result = psmt.executeUpdate();
            return result; // 0이상 값이 return된 경우 성공
        } catch (Exception e) {
        	System.out.println("MemberDAO SQL에러");
            e.printStackTrace();
        }
        return -3; // DB 오류
    }

    /*
        아이디 중복 체크 메서드
    */
    public boolean isIdDuplicated(String id) {
        String query = "SELECT id FROM member WHERE id = ?";
        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, id);
            rs = psmt.executeQuery();
            return rs.next(); // 결과가 존재하면 중복
        } catch (Exception e) {
        	System.out.println("아이디중복 SQL에러");
            e.printStackTrace();
        }
        return false; // DB 오류로 중복 처리 불가
    }

    /*
        이름 중복 체크 메서드
    */
    public boolean isNameDuplicated(String name) {
        String query = "SELECT name FROM member WHERE name = ?";
        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, name);
            rs = psmt.executeQuery();
            return rs.next(); // 결과가 존재하면 중복
        } catch (Exception e) {
        	System.out.println("이름중복 SQL 에러");
            e.printStackTrace();
        }
        return false; // DB 오류로 중복 처리 불가
    }

    public int deleteMember(String userId, String userPw, String userName) {
        String SQL = "DELETE FROM member WHERE id=? AND pass=? AND name=?";
        
        try {
            psmt = con.prepareStatement(SQL);
            psmt.setString(1, userId);
            psmt.setString(2, userPw);
            psmt.setString(3, userName);
            
            return psmt.executeUpdate(); // 1이면 삭제 성공, 0이면 삭제 실패
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return -1; // DB 오류
    }
    public int update(String userId, String userPassword, String userName) {
		String SQL="UPDATE MEMBER SET pass=?, name=? WHERE id=?"; 
		try {
            psmt = con.prepareStatement(SQL);
			psmt.setString(1, userPassword);
			psmt.setString(2, userName);
			psmt.setString(3, userId);
			
			return psmt.executeUpdate();		
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
    
	public int updateID(String id, String pass, String name) {
		String SQL="UPDATE MEMBER set id=? where pass=? AND name=?";
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, id);
			psmt.setString(2,pass);
			psmt.setString(3, name);
			return psmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}
	
    //insert문장의 결과는 0이상의 숫자가 발현되기 떄문에 -1이 아닌경우는 성공적인 회원가입이 이뤄졌다.
	public int join(MemberDTO user) {
		String SQL = "INSERT INTO MEMBER VALUES (?,?,?)";
		try {
			psmt=con.prepareStatement(SQL);
			psmt.setString(1, user.getId());
			psmt.setString(2, user.getPass());
			psmt.setString(3, user.getName());
			return psmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();//예외처리
		}
		return -1;//데이터베이스 오류
	}

	
//	//특정한 아이디에 해당하는 제목과 내용을 바꿔준다. 
//	public int update(String userID, String userPassword, String userName, String userGender, String userEmail ) {
//		String SQL="update MEMBER set pass = ?, name = ? where id = ?";
//		try {
//			psmt = con.prepareStatement(SQL);
//			psmt.setString(1, userPassword);
//			psmt.setString(2, userName);
//			psmt.setString(3, userID);
//			return psmt.executeUpdate();		
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
//		return -1;//데이터베이스 오류
//	}
	
	//특정한 아이디에 해당하는 제목과 내용을 바꿔준다. 
	public int delete(String userID) {
		String SQL="delete from MEMBER where id = ?";
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, userID);
			return psmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;//데이터베이스 오류
	}

	
	public MemberDTO getUser(String userID) {//하나의 글 내용을 불러오는 함수
		String SQL="SELECT * from MEMBER where id = ?";
		try {
			psmt = con.prepareStatement(SQL);
			psmt.setString(1, userID);//물음표
			rs=psmt.executeQuery();//select
			if(rs.next()) {//결과가 있다면
				MemberDTO dto = new MemberDTO();
				dto.setId(rs.getString(1));//첫 번째 결과 값
				dto.setPass(rs.getString(2));
				dto.setName(rs.getString(3));
				return dto;//6개의 항목을 user인스턴스에 넣어 반환한다.
			}			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public List<MemberDTO> adviewmember() {
	    List<MemberDTO> memberList = new ArrayList<>();
	    String query = "SELECT id, pass, name, regidate FROM member";
	    try {
	        psmt = con.prepareStatement(query);
	        rs = psmt.executeQuery();
	        
	        while (rs.next()) {
	            MemberDTO member = new MemberDTO();
	            member.setId(rs.getString("id"));
	            member.setPass(rs.getString("pass"));
	            member.setName(rs.getString("name"));
	            member.setRegidate(rs.getString("regidate"));
	            memberList.add(member);
	        }
	    } catch (Exception e) {
	        System.out.println("관리자 맴버보기 SQL 에러");
	        e.printStackTrace();
	    }
	    return memberList;
	}
	 public int deleteMember(String memberId) {
	        MemberDTO user = getUser(memberId);
	        
	        if (user == null) {
	        	System.out.println("user가 null임");
	            return -1; // 사용자 정보 없음
	        }else {
	        
	            String SQL = "DELETE FROM member WHERE id=?";
	        
	            try {
	                psmt = con.prepareStatement(SQL);
	                psmt.setString(1, memberId);
	                
	                return psmt.executeUpdate(); // 1이면 삭제 성공, 0이면 삭제 실패
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	        
	        return 0; // 사용자가 "아니오"를 선택한 경우나 DB 오류
	    }
	    
	}

