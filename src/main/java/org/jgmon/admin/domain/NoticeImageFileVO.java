package org.jgmon.admin.domain;

public class NoticeImageFileVO {
	public int noti_file_id;                                                                 
	public int noti_board_id;                                                                      
	public String manager_id ;                                                                      
	public String n_imgname;
	public String n_originafile;
	
	public int getNoti_file_id() {
		return noti_file_id;
	}
	public void setNoti_file_id(int noti_file_id) {
		this.noti_file_id = noti_file_id;
	}
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
	public String getN_imgname() {
		return n_imgname;
	}
	public void setN_imgname(String n_imgname) {
		this.n_imgname = n_imgname;
	}
	public String getN_originafile() {
		return n_originafile;
	}
	public void setN_originafile(String n_originafile) {
		this.n_originafile = n_originafile;
	}
	
 
}
