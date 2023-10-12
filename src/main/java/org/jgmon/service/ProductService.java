package org.jgmon.service;

import java.util.List;
import java.util.Map;

import org.jgmon.domain.ProductCategoryVO;
import org.jgmon.domain.ProductImageVO;
import org.jgmon.domain.ProductVO;
import org.springframework.web.multipart.MultipartFile;

public interface ProductService {


	//페이징 처리및 조회
	public Map<String, Object> productList(int currentPage,String keyWord,String category) throws Exception;
	  
	//글쓰기 
	public int writeProduct(ProductVO pvo,List<MultipartFile> images) throws Exception;

	//글상세 보기 및 조회수 증가 
	public ProductVO detailProduct(Integer pro_num) throws Exception;
	  
	//글삭제하기
	public int deleteOneProduct(Integer pro_num) throws Exception;
	  
	//글 수정하기
	public int updateOneProduct(ProductVO pvo,List<MultipartFile> vo,List<String> existingImages) throws Exception;
	
	//카테고리 불러오기
	public List<ProductCategoryVO> productCategoryList() throws Exception;

	//게시글 사진 가져오기 (???)
	public List<ProductImageVO> getProductImage(int pro_num) throws Exception;
	
	//게시글 아이디비례해 갯수 구하기
	public int countProductByUser_Id(String user_id) throws Exception;
	
	//게시글 아이에비례해 가져오기
	public List<ProductVO> getProductByUser_id(String user_id) throws Exception;

	//메인 노출용 6개 정렬
	public List<ProductVO> getProductsByRegDate();



}