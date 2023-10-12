package org.jgmon.admin.service;

import java.io.File;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.io.FilenameUtils;
import org.jgmon.admin.domain.NoticeBoardVO;
import org.jgmon.admin.domain.NoticeImageFileVO;
import org.jgmon.admin.persistence.NoticeBoardDAO;
import org.jgmon.util.FileUtil;
import org.jgmon.util.PagingUtil;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

 

@Service
public class NoticeBoardServiceImpl implements NoticeBoardService {

	@Inject
	NoticeBoardDAO noticeboardDAO;
	 
	@Override
	public Map<String,Object> listAll(int currentPage,String keyWord) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String,Object> pagingMap = new HashMap<String, Object>();
		
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("keyWord", keyWord); //검색어
		
		int count = noticeboardDAO.countNotiBoard(map);
		//검색분야 , 검색어  -> parameterType = " map " (Map객체)

		// 4.블럭당 페이지 수 ( 10 ) 5.요청명령어 지정 
		PagingUtil page = new PagingUtil(currentPage, count, 10, 5, "noticeboard");
		//start = > 페이지당 맨 첫번째 나오는 게시물 번호
		//end = > 마지막 게시물 번호
		map.put("start", page.getStartCount());
		//<-> map.get("start") => #{start}
		map.put("end", page.getEndCount());
		
		List<NoticeBoardVO> list = null; 
		if(count > 0 ) {
			list = noticeboardDAO.listAll(map); // keyWord,start,end 
		}else {
			list = Collections.EMPTY_LIST; // 0 적용 
		}
		
		pagingMap.put("list", list);
		pagingMap.put("count",count);
		pagingMap.put("pagingHtml",page.getPagingHtml());
				
		return pagingMap;
	}

	@Override
	public int writeNoti_Board(NoticeBoardVO notice, List<MultipartFile> images) throws Exception {
		NoticeImageFileVO vo = new NoticeImageFileVO();
		int maxNoti_id =  noticeboardDAO.getMaxNotiNum();
		if(maxNoti_id == 0) {
			notice.setNoti_board_id(1);
		}else {
			notice.setNoti_board_id(maxNoti_id+1);
		}
		
		
		
		int result =  noticeboardDAO.writeNoti_board(notice);
		
		if(null != images && images.size() > 0) {
			for(MultipartFile multipartFile : images) {
			
				
	            String filename = FileUtil.rename(multipartFile.getOriginalFilename());
	            NoticeImageFileVO fileVO = new NoticeImageFileVO();
	            fileVO.setManager_id(notice.getManager_id());
	            fileVO.setNoti_board_id(notice.getNoti_board_id());
	            fileVO.setN_imgname(filename);
	            fileVO.setNoti_file_id(noticeboardDAO.getMaxImgNoti() + 1);
	            fileVO.setN_originafile(filename);
	           
 
				 
				
					if(!multipartFile.isEmpty()) {
					
					noticeboardDAO.uploadImages(fileVO);
					File file = new File(FileUtil.UPLOAD_PATH+"noticeboardPic/"+filename);
					multipartFile.transferTo(file);
				}

			}
		}
		
		
	
		return result;
	}

	@Override
	public NoticeBoardVO detailNoti_Board(Integer noti_board_id) throws Exception {
		//조회수 증가
		noticeboardDAO.updateCount(noti_board_id);
		//번호에 맞게 게시판글 가져오기
		NoticeBoardVO notice = noticeboardDAO.getNoti_board(noti_board_id);
		return notice;
	}

	@Override
	public int deleteNoti_board(Integer noti_board_id) throws Exception {
		//글삭제 sql 불러오기 
		List<NoticeImageFileVO> oldImages = noticeboardDAO.getnoti_board_img(noti_board_id);
		int result = noticeboardDAO.deleteNoti_board(noti_board_id);
		if(result == 1) {
			for (NoticeImageFileVO noticeImageFileVO : oldImages) {
				 FileUtil.removeFile("/noticeboardPic/" + noticeImageFileVO.getN_imgname());
			}
		}
		return result;
	}

	@Override
	public int editNoti_board(NoticeBoardVO notice , List<MultipartFile> images,List<String> existingImages) throws Exception {
		//글 수정 sql 불러오기 
		List<NoticeImageFileVO> oldImages = noticeboardDAO.getnoti_board_img(notice.getNoti_board_id());
		 
		
		if((existingImages != null)) {
		   // 새로운 이미지와 비교하며 이전 이미지 중에서 삭제해야 할 것들을 삭제합니다.
	    for (NoticeImageFileVO oldImage : oldImages) {
	        boolean found = false;
	        
	        for (String existingImage : existingImages) {
	            if (existingImage.equals(oldImage.getN_imgname())) {
	                found = true;
	                break;
	            }
	        }
	        
	        if (!found) {
	            noticeboardDAO.delNoti_board_img(oldImage.getN_imgname());
	            FileUtil.removeFile("/noticeboardPic/" + oldImage.getN_imgname());
	        }
	    }


		}else {
			noticeboardDAO.delAllNoti_board_img(notice.getNoti_board_id());
		}
		  
	    // 새로운 이미지를 추가합니다.
	    for (MultipartFile image : images) {
	        if (!image.isEmpty()) {
	            String filename = FileUtil.rename(image.getOriginalFilename());
	            NoticeImageFileVO vo = new NoticeImageFileVO();
	            vo.setManager_id(notice.getManager_id());
	            vo.setNoti_board_id(notice.getNoti_board_id());
	            vo.setN_imgname(filename);
	            vo.setNoti_file_id(noticeboardDAO.getMaxImgNoti() + 1);
	            vo.setN_originafile(filename);
	            noticeboardDAO.uploadImages(vo);

	            File file = new File(FileUtil.UPLOAD_PATH + "noticeboardPic/" + filename);
	            image.transferTo(file);
	        }
	    }
		
		int result = noticeboardDAO.updateNoti_board(notice);
		return result;
	}

	@Override
	public List<NoticeImageFileVO> getNoti_board_img(int notice_board_id) throws Exception {
		List<NoticeImageFileVO> list  = noticeboardDAO.getnoti_board_img(notice_board_id);
		return list;
	} 

}
