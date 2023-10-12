package org.jgmon.persistence;

import java.util.List;
import java.util.Map;

import org.jgmon.domain.K_BoardVO;
import org.jgmon.domain.K_CommentVO;
import org.jgmon.domain.K_ImageFileVO;

public interface K_BoardDAO {
	  //게시물의 총 갯수
	  public int countBoard(Map<String,Object> map);
	
	  //페이징 처리 후 게시글 조회
	  public List<K_BoardVO> listAll(Map<String,Object> map) throws Exception;
	  
	  //게시물의 마지막 번호 조회		//혹시 이거는 왜 쓰는 건지?
	  public int getMaxNum() throws Exception;
	  
	  //게시물 작성
	  public int writeBoard(K_BoardVO notice) throws Exception;
	  
	  //조회수 증가
	  public void updateCount(Integer board_id) throws Exception;
	  
	  //게시물 가져오기
	  public K_BoardVO getBoard(Integer board_id) throws Exception;
	  
	  //게시물 삭제
	  public int deleteBoard(Integer board_id) throws Exception;
	  
	  //게시물 수정
	  public int updateBoard(K_BoardVO notice) throws Exception;
	  
	  //게시물 사진 업로드 및 데이터 업로드 
	  public void uploadImages(K_ImageFileVO vo) throws Exception;
	  
	  //사진 테이블 마지막 번호 가져오기
	  public int getMaxImgNoti() throws Exception;
	  
	  //게시판 글에 맞게 사진 가져오기
	  public List<K_ImageFileVO> getboard_img(Integer board_Id) throws Exception;
	  
	  //게시글 사진 수정또는 삭제
	  public int delBoard_img(String b_filename) throws Exception;
	  
	  //게시글 사진 모두 삭제
	  public int delAllBoard_img(Integer board_id) throws Exception;
	  
	  //아이디에 맞게 게시글 갯수 가져오기
	  public int countBoardByUser_id(String user_id) throws Exception;
	  
	  //아이디에 맞게 게시글 가져오기
	  public List<K_BoardVO> getBoardByUser_id(String user_id) throws Exception;
	  
	  //댓글 마지막 번호 조회
	  public int getMaxComment() throws Exception;
	  
	  //게시판에 맞게 댓글 조회
	  public List<K_CommentVO> getCommentByBoard(int board_id) throws Exception;
	  
	  //댓글 작성
	  public int writeComment(K_CommentVO comment) throws Exception;
	  
	  //댓글 삭제
	  public int deleteComment(Integer comment_id) throws Exception;
	  
	  //댓글 수정
	  public int updateComment(K_CommentVO comment) throws Exception;
	  
	  
}
