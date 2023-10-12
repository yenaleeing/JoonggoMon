package org.jgmon.admin.service;

import java.util.List;
import java.util.Map;

import org.jgmon.admin.domain.NoticeBoardVO;
import org.jgmon.admin.domain.NoticeImageFileVO;
import org.springframework.web.multipart.MultipartFile;

public interface NoticeBoardService {
	  //페이징 처리및 조회
	  public Map<String, Object> listAll(int currentPage,String keyWord) throws Exception;
	  
	  
	  //글쓰기 
	  public int writeNoti_Board(NoticeBoardVO notice,List<MultipartFile> images) throws Exception;

	  //글상세 보기 및 조회수 증가 
	  public NoticeBoardVO detailNoti_Board(Integer noti_board_id) throws Exception;
	  
	  //글삭제하기
	  public int deleteNoti_board(Integer noti_board_id) throws Exception;
	  
	  //글 수정하기
	  public int editNoti_board(NoticeBoardVO notice,List<MultipartFile> vo,List<String> existingImages) throws Exception;
	  
	  //게시글 사진 가져오기
	  public List<NoticeImageFileVO> getNoti_board_img(int notice_board_id) throws Exception;
	  

}
 