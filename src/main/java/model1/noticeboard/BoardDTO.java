package model1.noticeboard;


public class BoardDTO
{

	// 맴버변수 생성 : board 테이블에 생성된 컬럼과 동일
	private String num;
	private String title;
	private String content;
	private String id;
	private java.sql.Date postdate;
	private java.sql.Date regiDate;
	private String visitcount;
	private String name;
	private String pass;
	private String isAdmin;

	
	public String getIsAdmin()
	{
		return isAdmin;
	}

	public void setIsAdmin(String isAdmin)
	{
		this.isAdmin = isAdmin;
	}

	public java.sql.Date getRegiDate()
	{
		return regiDate;
	}

	public void setRegiDate(java.sql.Date regiDate)
	{
		this.regiDate = regiDate;
	}

	public String getPass()
	{
		return pass;
	}

	public void setPass(String pass)
	{
		this.pass = pass;
	}

	public String getNum()
	{
		return num;
	}

	public void setNum(String num)
	{
		this.num = num;
	}

	public String getTitle()
	{
		return title;
	}

	public void setTitle(String title)
	{
		this.title = title;
	}

	public String getContent()
	{
		return content;
	}

	public void setContent(String content)
	{
		this.content = content;
	}

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public java.sql.Date getPostdate()
	{
		return postdate;
	}

	public void setPostdate(java.sql.Date postdate)
	{
		this.postdate = postdate;
	}

	public String getVisitcount()
	{
		return visitcount;
	}

	public void setVisitcount(String visitcount)
	{
		this.visitcount = visitcount;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

}
