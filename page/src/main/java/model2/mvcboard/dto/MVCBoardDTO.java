package model2.mvcboard.dto;

public class MVCBoardDTO {
	
	private String idx ;
	private String name ;
	private String title ;
	private String content ;
	private String postdate ;
	private String ofile ;
	private String sfile ;
	private String downcount ;
	private String pass ;
	private String visitcount ;
	
	public MVCBoardDTO(String idx, String name, String title, String content, String postdate, String ofile,
			String sfile, String downcount, String pass, String visitcount) {
		super();
		this.idx = idx;
		this.name = name;
		this.title = title;
		this.content = content;
		this.postdate = postdate;
		this.ofile = ofile;
		this.sfile = sfile;
		this.downcount = downcount;
		this.pass = pass;
		this.visitcount = visitcount;
	}

	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
		this.idx = idx;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPostdate() {
		return postdate;
	}

	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}

	public String getOfile() {
		return ofile;
	}

	public void setOfile(String ofile) {
		this.ofile = ofile;
	}

	public String getSfile() {
		return sfile;
	}

	public void setSfile(String sfile) {
		this.sfile = sfile;
	}

	public String getDowncount() {
		return downcount;
	}

	public void setDowncount(String downcount) {
		this.downcount = downcount;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getVisitcount() {
		return visitcount;
	}

	public void setVisitcount(String visitcount) {
		this.visitcount = visitcount;
	}

	public MVCBoardDTO() {
		// TODO Auto-generated constructor stub
	}

}
