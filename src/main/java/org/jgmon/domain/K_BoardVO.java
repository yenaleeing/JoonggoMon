package org.jgmon.domain;

public class K_BoardVO {

	private int board_id;
	private String user_id;
	private String b_regdate;
	private String b_name;
	private String b_content;
	private int count;
	private int archive;	
	
	
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

	public String getB_regdate() {
		return b_regdate;
	}

	public void setB_regdate(String b_regdate) {
		this.b_regdate = b_regdate;
	}

	public String getB_name() {
		return b_name;
	}

	public void setB_name(String b_name) {
		this.b_name = b_name;
	}

	public String getB_content() {
		return b_content;
	}

	public void setB_content(String b_content) {
		this.b_content = b_content;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getArchive() {
		return archive;
	}

	public void setArchive(int archive) {
		this.archive = archive;
	}

	@Override
	public String toString() {
		return "K_BoardVO [board_id="+board_id+", user_id"+user_id+", b_regdate"+b_regdate
					+", b_name"+b_name+", b_content"+b_content+", count"+count+", archive"+archive+"]";
	}
}
