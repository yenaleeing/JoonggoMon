package org.jgmon.service;

import java.io.File;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.jgmon.domain.K_BoardVO;
import org.jgmon.domain.K_CommentVO;
import org.jgmon.domain.K_ImageFileVO;
import org.jgmon.persistence.K_BoardDAO;
import org.jgmon.util.FileUtil;
import org.jgmon.util.PagingUtil;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;


@Service
public class K_BoardServiceImpl implements K_BoardService {

	@Inject
	K_BoardDAO k_boardDAO;
	 
	@Override
	public Map<String,Object> listAll(int currentPage,String keyWord) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String,Object> pagingMap = new HashMap<String, Object>();
		
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("keyWord", keyWord); //검색어
		
		int count = k_boardDAO.countBoard(map);
		//검색분야 , 검색어  -> parameterType = " map " (Map객체)

		
		// 4.블럭당 페이지 수 ( 10 ) 5.요청명령어 지정 
		PagingUtil page = new PagingUtil(currentPage, count, 10, 5, "normalboard");
		//start = > 페이지당 맨 첫번째 나오는 게시물 번호
		//end = > 마지막 게시물 번호
		map.put("start", page.getStartCount());
		//<-> map.get("start") => #{start}
		map.put("end", page.getEndCount());
		
		List<K_BoardVO> list = null; 
		if(count > 0 ) {
			list = k_boardDAO.listAll(map); // keyWord,start,end 
		}else {
			list = Collections.EMPTY_LIST; // 0 적용 
		}
		
		pagingMap.put("list", list);
		pagingMap.put("count",count);
		pagingMap.put("pagingHtml",page.getPagingHtml());
		
		
		return pagingMap;
	}
	
	@Override
	public List<K_BoardVO> getBoardByUser_id(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return k_boardDAO.getBoardByUser_id(user_id);
	}

	@Override
	public int writeBoard(K_BoardVO notice, List<MultipartFile> images) throws Exception {
		// TODO Auto-generated method stub
		K_ImageFileVO vo = new K_ImageFileVO();
		int maxNormal_id =  k_boardDAO.getMaxNum();
		if(maxNormal_id != 0) {
			notice.setBoard_id(maxNormal_id+1);
		}else {
			notice.setBoard_id(1);
		}
		
		int result =  k_boardDAO.writeBoard(notice);
		
		if(null != images && images.size() > 0) {
			for(MultipartFile multipartFile : images) {
			
				String filename = FileUtil.rename(multipartFile.getOriginalFilename());
				
				vo.setUser_id(notice.getUser_id());
				vo.setBoard_id(notice.getBoard_id());
				vo.setBoard_filename(filename);
				vo.setBoard_file_id(k_boardDAO.getMaxImgNoti()+1);
				vo.setBoard_originafile(filename);
				
				if(!multipartFile.isEmpty()) {
					
					k_boardDAO.uploadImages(vo);
					File file = new File(FileUtil.UPLOAD_PATH+"/normalboardPic/"+filename);
					multipartFile.transferTo(file);
				}
				
			}
		}
		
		return result;
	}
	
	@Override
	public int countBoardByUser_id(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return k_boardDAO.countBoardByUser_id(user_id);
	}

	@Override
	public K_BoardVO detailBoard(Integer board_id) throws Exception {
		//조회수 증가
		k_boardDAO.updateCount(board_id);
		//번호에 맞게 게시판글 가져오기
		K_BoardVO notice = k_boardDAO.getBoard(board_id);
		return notice;
	}

	@Override
	public int deleteBoard(Integer board_id) throws Exception {
		//글삭제 sql 불러오기 
		int result = k_boardDAO.deleteBoard(board_id);
		return result;
	}

	@Override
	public int editBoard(K_BoardVO notice, List<MultipartFile> images, List<String> existingImages) throws Exception {
		//글 수정 sql 불러오기 
		List<K_ImageFileVO> oldImages = k_boardDAO.getboard_img(notice.getBoard_id());
		
		if((existingImages != null)) {
			   // 새로운 이미지와 비교하며 이전 이미지 중에서 삭제해야 할 것들을 삭제합니다.
		    for (K_ImageFileVO oldImage : oldImages) {
		        boolean found = false;
		        
		        for (String existingImage : existingImages) {
		            if (existingImage.equals(oldImage.getBoard_filename())) {
		                found = true;
		                break;
		            }
		        }
		        
		        if (!found) {
		            k_boardDAO.delBoard_img(oldImage.getBoard_filename());
		            FileUtil.removeFile("/normalboardPic/" + oldImage.getBoard_filename());
		        }
		    }



			}else {
				k_boardDAO.delAllBoard_img(notice.getBoard_id());
			}
			  
		    // 새로운 이미지를 추가합니다.
		    for (MultipartFile image : images) {
		        if (!image.isEmpty()) {
		            String filename = FileUtil.rename(image.getOriginalFilename());
		            K_ImageFileVO vo = new K_ImageFileVO();
		            vo.setUser_id(notice.getUser_id());
		            vo.setBoard_id(notice.getBoard_id());
		            vo.setBoard_filename(filename);
		            vo.setBoard_file_id(k_boardDAO.getMaxImgNoti() + 1);
		            vo.setBoard_originafile(filename);
		            k_boardDAO.uploadImages(vo);

		            File file = new File(FileUtil.UPLOAD_PATH + "normalboardPic/" + filename);
		            image.transferTo(file);
		        }
		    }
		
		
		int result = k_boardDAO.updateBoard(notice);
		return result;
	}
	
	@Override
	public List<K_ImageFileVO> getBoard_img(int board_id) throws Exception {
		List<K_ImageFileVO> list  = k_boardDAO.getboard_img(board_id);
		return list;
	} 
	
	//확인 받기, 댓글 구현 중:
	@Override
	public int writeComment(K_CommentVO comment) throws Exception {
		// TODO Auto-generated method stub
		comment.setCmnt_id(k_boardDAO.getMaxComment()+1);
	 
		
		int result =  k_boardDAO.writeComment(comment);
		
	 
		
		return result;
	}
	
	@Override
	public List<K_CommentVO> getCommentByBoard(int board_id) throws Exception {
		// TODO Auto-generated method stub
		return k_boardDAO.getCommentByBoard(board_id);
	}
	
	
	@Override
	public int deleteComment(Integer board_id) throws Exception {
		//글삭제 sql 불러오기 
		int result = k_boardDAO.deleteComment(board_id);
		return result;
	}

	@Override
	public int editComment(K_CommentVO comment) throws Exception {
 
		int result = k_boardDAO.updateComment(comment);
		return result;
	}

}
