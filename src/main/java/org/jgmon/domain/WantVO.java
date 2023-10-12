package org.jgmon.domain;

public class WantVO {
	
	private int want_id;
	private String  w_url;
	private String  w_img;
	private String user_id;
	private int user_want_id;
	
	//더미 데이터용
	
	public int getWant_id() {
		return want_id;
	}
	public void setWant_id(int want_id) {
		this.want_id = want_id;
	}
	public String getW_url() {
		return w_url;
	}
	public void setW_url(String w_url) {
		this.w_url = w_url;
	}
	public String getW_img() {
	    return w_img;
	}
	public void setW_img(String w_img) {
		this.w_img = w_img;
	}
	public String toString() {
		return "WantVO [want_id="+want_id+",w_url="+w_url+
				"w_img="+w_img+"]";
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getUser_want_id() {
		return user_want_id;
	}
	public void setUser_want_id(int user_want_id) {
		this.user_want_id = user_want_id;
	}
}
