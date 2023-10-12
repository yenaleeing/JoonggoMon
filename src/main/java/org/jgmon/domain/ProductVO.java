package org.jgmon.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class ProductVO {
	
	private Integer pro_num; // 글번호
	private String p_title; // 제목
	private Integer p_price; // 가격
	private String pro_category_id; // 카테고리
	private String pro_category; // 카테고리
	private String p_state; // 상품상태(새상품,중고)
	private String p_exchange; // 교환가능여부(가능,불가능)
	private String p_dfee; // 배송비포함여부(배송비포함,미포함)
	private String p_contact; // 판매자연락처
	private String p_content; // 내용
	private String user_id; // 작성자ID
	private Integer archive; // 숨김처리여부
	private Date p_regdate; // 작성일자
	private Integer p_count; // 조회수
	private String p_imgname; //사진이름 

	
	
	public Integer getPro_num() {
		return pro_num;
	}



	public void setPro_num(Integer pro_num) {
		this.pro_num = pro_num;
	}



	public String getP_title() {
		return p_title;
	}



	public void setP_title(String p_title) {
		this.p_title = p_title;
	}



	public Integer getP_price() {
		return p_price;
	}



	public void setP_price(Integer p_price) {
		this.p_price = p_price;
	}





	public String getPro_category_id() {
		return pro_category_id;
	}



	public void setPro_category_id(String pro_category_id) {
		this.pro_category_id = pro_category_id;
	}



	public String getPro_category() {
		return pro_category;
	}



	public void setPro_category(String pro_category) {
		this.pro_category = pro_category;
	}



	public String getP_state() {
		return p_state;
	}



	public void setP_state(String p_state) {
		this.p_state = p_state;
	}



	public String getP_exchange() {
		return p_exchange;
	}



	public void setP_exchange(String p_exchange) {
		this.p_exchange = p_exchange;
	}



	public String getP_dfee() {
		return p_dfee;
	}



	public void setP_dfee(String p_dfee) {
		this.p_dfee = p_dfee;
	}



	public String getP_contact() {
		return p_contact;
	}



	public void setP_contact(String p_contact) {
		this.p_contact = p_contact;
	}



	public String getP_content() {
		return p_content;
	}



	public void setP_content(String p_content) {
		this.p_content = p_content;
	}



	public String getUser_id() {
		return user_id;
	}



	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}



	public Integer getArchive() {
		return archive;
	}



	public void setArchive(Integer archive) {
		this.archive = archive;
	}



	public Date getP_regdate() {
		return p_regdate;
	}



	public void setP_regdate(Date p_regdate) {
		this.p_regdate = p_regdate;
	}



 


	public Integer getP_count() {
		return p_count;
	}



	public void setP_count(Integer p_count) {
		this.p_count = p_count;
	}



	public String getP_imgname() {
		return p_imgname;
	}



	public void setP_imgname(String p_imgname) {
		this.p_imgname = p_imgname;
	}



 


 



 

}
