package org.jgmon.admin.persistence;

import java.util.List;
import java.util.Map;

import org.jgmon.admin.domain.NoticeBoardVO;
import org.jgmon.admin.domain.NoticeImageFileVO;

public interface NoticeBoardDAO {
	  //게시물의 총갯수
	  public int countNotiBoard(Map<String,Object> map);
	
	  //페이징 처리후 게시글 조회
	  public List<NoticeBoardVO> listAll(Map<String,Object> map) throws Exception;
	  
	  //게시물의 마지막 번호 조회
	  public int getMaxNotiNum() throws Exception;
	  
	  //게시물 작성
	  public int writeNoti_board(NoticeBoardVO notice) throws Exception;
	  
	  //조회수 증가
	  public void updateCount(Integer noti_board_id) throws Exception;
	  
	  //게시물 가져오기
	  public NoticeBoardVO getNoti_board(Integer noti_board_id) throws Exception;
	  
	  //게시물 삭제
	  public int deleteNoti_board(Integer noti_board_id) throws Exception;
	  
	  //게시물 수정
	  public int updateNoti_board(NoticeBoardVO notice) throws Exception;
	  
	  //게시물 사진 업로드 및 데이터 업로드 
	  public void uploadImages(NoticeImageFileVO vo) throws Exception;
	  
	  //사진 테이블 마지막 번호 가져오기
	  public int getMaxImgNoti() throws Exception;
	  
	  //게시판 글에 맞게 사진 가져오기
	  public List<NoticeImageFileVO> getnoti_board_img(Integer noti_board_Id) throws Exception;
	  
	  //게시글 사진 수정또는 삭제
	  public int delNoti_board_img(String noti_img_name) throws Exception; 
	  
	  //게시물 사진 선택을 하지않았을경우
	  public int delAllNoti_board_img(Integer noti_board_id) throws Exception;
}
