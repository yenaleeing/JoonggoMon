package org.jgmon.domain;

import org.springframework.web.multipart.MultipartFile;

public class MemberVO {
	private String USER_ID;
	 private String U_PWD;
	 private String U_NAME;
	 private String U_NICKNAME;
	 private MultipartFile upload;
	 private String U_PICTURE;
	 private String EMAIL;
	 private String BIRTHDATE ;
	 private String PHONENUM;
	 private String ADDRESS;
	 private String AUTHPATH;
 
 
	 
	public String getUser_id() {
		return USER_ID;
	}
	public void setUser_id(String user_id) {
		this.USER_ID = user_id;
	}
	public String getU_pwd() {
		return U_PWD;
	}
	public void setU_pwd(String u_pwd) {
		this.U_PWD = u_pwd;
	}
	public String getU_name() {
		return U_NAME;
	}
	public void setU_name(String u_name) {
		this.U_NAME = u_name;
	}
	public String getU_nickname() {
		return U_NICKNAME;
	}
	public void setU_nickname(String u_nickname) {
		this.U_NICKNAME = u_nickname;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	public String getEmail() {
		return EMAIL;
	}
	public void setEmail(String email) {
		this.EMAIL = email;
	}
	public String getBirthdate() {
		return BIRTHDATE;
	}
	public void setBirthdate(String birthdate) {
		this.BIRTHDATE = birthdate;
	}
	public String getPhonenum() {
		return PHONENUM;
	}
	public void setPhonenum(String phonenum) {
		this.PHONENUM = phonenum;
	}
	public String getAddress() {
		return ADDRESS;
	}
	public void setAddress(String address) {
		this.ADDRESS = address;
	}
 
	public String getU_PICTURE() {
		return U_PICTURE;
	}
	public void setU_PICTURE(String u_PICTURE) {
		U_PICTURE = u_PICTURE;
	}
	public String getAUTHPATH() {
		return AUTHPATH;
	}
	public void setAUTHPATH(String aUTHPATH) {
		AUTHPATH = aUTHPATH;
	}
	 
	 
 

 
 
 
}
