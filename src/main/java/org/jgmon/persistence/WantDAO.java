package org.jgmon.persistence;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.jgmon.domain.WantVO;


public interface WantDAO {
	
	//찜목록의 총갯수 가져오기
	public int countWant(Map<String,Object> map);
	
	//마지막 저장된 찜목록
	public int countPublicWant();
	
	// 마지막 번호 구하기
	public int getMaxUser_Want_Id() throws Exception;
	
	//페이징 처리 이후 찜목록 가져오기
	public List<WantVO> listAll(Map<String, Object> map) throws Exception;
	
	//공통 테이블에 넣기
	public int insert(WantVO want_id) throws Exception;	
	//회원 아이디에 맞게 넣기
	public int insertUser_want(WantVO want) throws Exception;
	
	//갯수 구하기
	
	public int countAllwant(String want_id) throws Exception;
	
	//찜 목록 삭제
	public int removeFromWishlist(int want_id) throws Exception;
	//찜한 상품 목록 유저 아이디에 따라서 목록을 가져오도록 함
	
	//찜한 상품을 모두 삭제
	public int deleteAll(String user_id) throws Exception;


}
