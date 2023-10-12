package org.jgmon.admin.domain;

public class NoticeBoardVO {

	private int noti_board_id;
	private String manager_id;
	private String n_regdate;
	private String n_title;
	private String n_contents;
	private int archive;
	private int n_count;
	private int n_important;
	
	
	public int getNoti_board_id() {
		return noti_board_id;
	}
	public void setNoti_board_id(int noti_board_id) {
		this.noti_board_id = noti_board_id;
	}
	public String getManager_id() {
		return manager_id;
	}
	public void setManager_id(String manager_id) {
		this.manager_id = manager_id;
	}
	public String getN_regdate() {
		return n_regdate;
	}
	public void setN_regdate(String n_regdate) {
		this.n_regdate = n_regdate;
	}
 
	public String getN_title() {
		return n_title;
	}
	public void setN_title(String n_title) {
		this.n_title = n_title;
	}
	public String getN_contents() {
		return n_contents;
	}
	public void setN_contents(String n_contents) {
		this.n_contents = n_contents;
	}
	public int getArchive() {
		return archive;
	}
	public void setArchive(int archive) {
		this.archive = archive;
	}
	public int getN_count() {
		return n_count;
	}
	public void setN_count(int n_count) {
		this.n_count = n_count;
	}
	public int getN_important() {
		return n_important;
	}
	public void setN_important(int n_important) {
		this.n_important = n_important;
	}
	
}
