package org.jgmon.domain;

public class ProductImageVO {
	
	private Integer pro_imgid;
	private Integer pro_num; // 글번호
	private String pro_category_id; // 카테고리
	private String user_id; // 작성자ID
	private String p_imgname; // 파일이름
	private String p_originalfilename; // 이미지 원본파일이름
	
	
	
	public Integer getPro_imgid() {
		return pro_imgid;
	}
	public void setPro_imgid(Integer pro_imgid) {
		this.pro_imgid = pro_imgid;
	}
	public Integer getPro_num() {
		return pro_num;
	}
	public void setPro_num(Integer pro_num) {
		this.pro_num = pro_num;
	}
	public String getPro_category_id() {
		return pro_category_id;
	}
	public void setPro_category_id(String pro_category_id) {
		this.pro_category_id = pro_category_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getP_imgname() {
		return p_imgname;
	}
	public void setP_imgname(String p_imgname) {
		this.p_imgname = p_imgname;
	}
	public String getP_originalfilename() {
		return p_originalfilename;
	}
	public void setP_originalfilename(String p_originalfilename) {
		this.p_originalfilename = p_originalfilename;
	}


}
