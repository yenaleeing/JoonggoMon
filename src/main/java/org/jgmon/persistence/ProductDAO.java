package org.jgmon.persistence;

import java.util.List; 
import java.util.Map;

import org.jgmon.domain.ProductCategoryVO;
import org.jgmon.domain.ProductImageVO;
import org.jgmon.domain.ProductVO;
import org.springframework.web.multipart.MultipartFile;

public interface ProductDAO {
	
	//게시물의 총갯수
	public int countProduct(Map<String,Object> map);
	// TODO Auto-generated method stub
	
	//페이징 처리후 게시글 조회
	public List<ProductVO> productList(Map<String,Object> map) throws Exception;
	  
	//게시물의 마지막 번호 조회
	public int getMaxProductNum() throws Exception;
	  
	//게시물 작성
	public int writeProduct(ProductVO pvo) throws Exception;
	
	//조회수 증가
	public void updateCount(Integer pro_num) throws Exception;
	  
	//게시물 가져오기
	public ProductVO getOneProduct(Integer pro_num) throws Exception;
	  
	//게시물 삭제
	public int deleteOneProduct(Integer pro_num) throws Exception;
	  
	//게시물 수정
	public int updateOneProduct(ProductVO pvo) throws Exception;
	
	//카테고리 가져오기 
	public List<ProductCategoryVO> productCategory() throws Exception;
	
	
	//이미지파일 관련 추가
	//게시물 사진 업로드 및 데이터 업로드 
	public void uploadProductImage(ProductImageVO ivo) throws Exception;
	  
	//사진 테이블 마지막 번호 가져오기
	public int getMaxProductImageId() throws Exception;
	  
	//게시판 글에 맞게 사진 가져오기
	public List<ProductImageVO> getProductImage(Integer pro_num) throws Exception;
	
	//게시글 사진 수정또는 삭제
	public int delProductImage(String p_imgname) throws Exception; 
	
	//게시물 사진 선택을 하지않았을경우
	public int delAllProduct_img(Integer pro_num) throws Exception;
	
	//게시물 갯수 아이디에 비례해 가져오기
	public int countProductByUser_id(String user_id) throws Exception;
	
	//게시물 아이디에 비례해 가져오기
	public List<ProductVO> getProductByUser_id(String user_id) throws Exception;

	//메인노출용 최신 6개 정렬
	public List<ProductVO> getProductsByRegDate();
}

