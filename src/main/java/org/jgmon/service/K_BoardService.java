package org.jgmon.service;

import java.util.List;
import java.util.Map;

import org.jgmon.domain.K_BoardVO;
import org.jgmon.domain.K_CommentVO;
import org.jgmon.domain.K_ImageFileVO;
import org.springframework.web.multipart.MultipartFile;

public interface K_BoardService {
	  //페이징 처리 및 조회
	  public Map<String, Object> listAll(int currentPage,String keyWord) throws Exception;
	    
	  //글쓰기 
	  public int writeBoard(K_BoardVO notice, List<MultipartFile> images) throws Exception;

	  //글상세 보기 및 조회수 증가 
	  public K_BoardVO detailBoard(Integer board_id) throws Exception;
	  
	  //글삭제하기
	  public int deleteBoard(Integer board_id) throws Exception;
	  
	  //글 수정하기
	  public int editBoard(K_BoardVO notice, List<MultipartFile> vo, List<String> existingImages) throws Exception;
	  
	  //게시글 사진 가져오기
	  public List<K_ImageFileVO> getBoard_img(int board_id) throws Exception;
	  
	  //게시글 user_id 에 맞게 갯수 구하기 
	  public int countBoardByUser_id (String user_id) throws Exception;
	  
	  //게시글 user_id 에 맞게 가져오기
	  public List<K_BoardVO> getBoardByUser_id (String user_id) throws Exception;
	  
	  //댓글 쓰기			//images를 사용하나?
	  public int writeComment(K_CommentVO comment) throws Exception;
	  
	  //게시판에 맞게 댓글 가져오기
	  public List<K_CommentVO> getCommentByBoard(int board_id) throws Exception;
	  
	  //댓글 삭제하기
	  public int deleteComment(Integer comment_id) throws Exception;
	  
	  //댓글 수정하기	//images를 사용하나?
	  public int editComment(K_CommentVO comment) throws Exception;
	  
}
 