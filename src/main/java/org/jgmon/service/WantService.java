package org.jgmon.service;

import java.util.Map;

import org.jgmon.domain.WantVO;

public interface WantService {
	
	//페이징 이후의 찜목록 가져오기 public 생략
	public Map<String, Object> listAll(int currentPage, String user_id) throws Exception;
	
	//찜 목록 추가
	public int regist(WantVO wantVO) throws Exception;
	
	//찜(하트)을 눌렀을 때 찜 목록을 삭제하는 메서드
	public int removeFromWishlist(int want_id) throws Exception;
	
	//저장된 갯수 카운트
	public int countAllWant(String want_id) throws Exception;
	
	//버튼을 눌렀을 때 전체목록을 데이터베이스에서 지우는 메서드
	public int deleteAll(String user_id) throws Exception;

}
