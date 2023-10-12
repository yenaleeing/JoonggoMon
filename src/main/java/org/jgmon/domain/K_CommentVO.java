package org.jgmon.domain;

import java.sql.Date;

public class K_CommentVO {

	private int cmnt_id;				// 댓글 글번호
    private int board_id;				// 게시글 번호
    private String user_id;			// 댓글 작성자
    private Date c_regdate;			// 댓글 작성일
    private String c_contents;		// 댓글 내용
    private String u_picture; //프로파일 사진 

    
	public int getCmnt_id() {
		return cmnt_id;
	}

	public void setCmnt_id(int cmnt_id) {
		this.cmnt_id = cmnt_id;
	}

	public int getBoard_id() {
		return board_id;
	}

	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Date getC_regdate() {
		return c_regdate;
	}

	public void setC_regdate(Date c_regdate) {
		this.c_regdate = c_regdate;
	}

	public String getC_contents() {
		return c_contents;
	}

	public void setC_contents(String c_contents) {
		this.c_contents = c_contents;
	}
	
	@Override
	public String toString() {
		return "K_CommentVO [cmnt_id="+cmnt_id+", board_id"+board_id+", user_id"+user_id
					+", c_regdate"+c_regdate+", c_contents"+c_contents+"]";
	}

	public String getU_picture() {
		return u_picture;
	}

	public void setU_picture(String u_picture) {
		this.u_picture = u_picture;
	}
	
}
