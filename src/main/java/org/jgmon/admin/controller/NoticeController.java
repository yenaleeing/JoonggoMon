package org.jgmon.admin.controller;

 

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jgmon.admin.domain.NoticeBoardVO;
import org.jgmon.admin.domain.NoticeImageFileVO;
import org.jgmon.admin.service.NoticeBoardService;
import org.jgmon.domain.MemberVO;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;

 

@Controller
@Component
public class NoticeController {

	  /**
	   * Simply selects the home view to render by returning its name.
	   */
	@Inject
	NoticeBoardService noticeBoardService;
	
	
	  @RequestMapping(value = "/admin/noticeboard", method = RequestMethod.GET)
	  public ModelAndView noticeboard(HttpSession session,@RequestParam(value="pageNum",defaultValue="1") int currentPage,@RequestParam(value="keyWord",defaultValue="") String keyWord) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		  System.out.println("managerid -> " + session.getAttribute("managerid"));
		  if(session.getAttribute("managerid") != null) {
		  mav.setViewName("/admin/adminNoticePage"); 
		  }else { 
		  mav.addObject("msg","로그인한 유저만 접속할수있습니다"); 
		  mav.addObject("url", "/home");
		  mav.setViewName("alert"); 
		  }
		 
		
		Map<String , Object> pagingMap;
		pagingMap = noticeBoardService.listAll(currentPage,keyWord);
		  
		mav.addObject("count",pagingMap.get("count"));
		mav.addObject("list",pagingMap.get("list"));
		mav.addObject("pagingHtml",pagingMap.get("pagingHtml"));
			
	    return (ModelAndView) mav;
	  }
	  
 
	  //글 작성 클릭시 오는 코드
	  @RequestMapping(value="/admin/writeBoard" , method = RequestMethod.GET)
	  public String viewWriteNoticeBoard(HttpSession session) {
			ModelAndView mav = new ModelAndView();
			
			/****이부분은 로그인 관련 코드라 세션을 가져온다는것만 알아두시면 됩니다*****/
			/*
			 * System.out.println("managerid -> " + session.getAttribute("managerid"));
			 * if(session.getAttribute("managerid") != null) {
			 * mav.setViewName("admin/write-notice"); }else { mav.addObject("msg",
			 * "로그인한 유저만 접속할수있습니다"); mav.addObject("url", "/controller/home");
			 * mav.setViewName("alert"); }
			 */
			/***여기까지 ****/
			
 
			 
		  return  "admin/write-notice";
	  }
	  
	  
	  //												글작성 완료 버튼 클릭시 가는 링크							POST method
	  @RequestMapping(value="/admin/writeboard/write.do", method = RequestMethod.POST)
	  public ModelAndView writeNoticeBoard(NoticeBoardVO notice,BindingResult result, MultipartHttpServletRequest multipartFile) throws Exception {
		  														// write-notice 에있는 input 값들을 VO 로 받아와서 처리할수 있게 넣어준 매개변수입니다.
		  List<MultipartFile> images = multipartFile.getFiles("AddImgs");
		  
		  for (int i = 0; i < images.size(); i++) {
			System.out.println(images.get(i));
		}
		  
		  //담을 객체 생성
		  ModelAndView mav = new ModelAndView();
		  // noticeBoardService 에있는 insert 관련 구문 호출 
		  noticeBoardService.writeNoti_Board(notice,images);
		  
		  	//ModelAndView 객체 안에 alert 구문 및 이동 페이지 작성후 alert.jsp 이동하며 alert 호출후 원하는 페이지로 이동
			 mav.addObject("msg", "글작성 완료");
			 mav.addObject("url", "/admin/noticeboard");
			 mav.setViewName("alert");
			 
		  return mav;
	  }
	  //글 상세보기 코드
	  @RequestMapping(value="/admin/detailNotiBoard.do" , method = RequestMethod.GET)
	  public ModelAndView detailNoticeBoard(int noti_board_id) throws Exception{
		  														// 클릭시 누른버튼에 담겨져있는 noti_board_id 가 넘어와서 sql 구문에 쓸수있게 됩니다.
		  ModelAndView mav = new ModelAndView();
		  
		  //1.게시글 가져오기 및 조회수 증가가되는 service 호출
		  NoticeBoardVO notice = noticeBoardService.detailNoti_Board(noti_board_id);
		  List<NoticeImageFileVO> imgList = noticeBoardService.getNoti_board_img(noti_board_id);
		  //페이지 및 noticeVO 값 반환 
		  
 
		  
		  mav.addObject("notice",notice);
		  mav.addObject("imgList",imgList);
		  mav.setViewName("/admin/NoticeBoardDetail");
		  
		  return mav;
		  
		  
	  }
	  //글 아이디를 가져와서 수정페이지를 보여주는 코드 
	  @RequestMapping(value="/admin/editNotiBoard" , method =RequestMethod.GET)
	  public ModelAndView editNoticeBoard(int noti_board_id) throws Exception{
		  ModelAndView mav = new ModelAndView();
		  NoticeBoardVO notice = noticeBoardService.detailNoti_Board(noti_board_id);
		  List<NoticeImageFileVO> imgList = noticeBoardService.getNoti_board_img(noti_board_id);
		  
 
		  
		  mav.addObject("notice",notice);
		  mav.addObject("imgList",imgList);
		  mav.setViewName("/admin/edit-notice");
		  
		  return mav;
		  
	  }
	  //글 수정클릭버튼시 오는 코드 
	  @RequestMapping(value="/admin/editNotiBoard/edit.do" , method = RequestMethod.POST)
	  public ModelAndView updateNoticeBoard(NoticeBoardVO notice, MultipartHttpServletRequest multipartFile , @RequestParam(value="existingImages",required=false) List<String> existingImages) throws Exception{
		  ModelAndView mav = new ModelAndView();
		  List<MultipartFile> images = multipartFile.getFiles("AddImgs"); 
		  
		  //SQL 구문작성이 완료되고나서 한번더 확인하고 싶으면 넣으면되는 코드입니다. 성공시 1 을 반환 하고 실패시 2를 반환하기에 
		  int result = noticeBoardService.editNoti_board(notice,images,existingImages);
		  
		  if(result == 1) {
			  mav.addObject("msg","수정성공");
			  mav.addObject("url","/admin/noticeboard");
		  }else {
			  mav.addObject("msg","수정 실패");
			  mav.addObject("url","/admin/noticeboard");
		  }
		  
		  mav.setViewName("alert");
		  
		  return mav;
	  }
	  
	  //글 삭제 버튼 클릭시 되는 코드
	  @RequestMapping(value ="/admin/deleteNotiBoard.do",method=RequestMethod.GET)
	  public ModelAndView detailDeleteNoticeBoard(int noti_board_id) throws Exception{
		  ModelAndView mav = new ModelAndView();
		  //삭제 Method 호출 
		  noticeBoardService.deleteNoti_board(noti_board_id);
		  
		  //ModelAndView 객체에 넘길 값 전송
		  mav.addObject("msg","글 삭제완료");
		  mav.addObject("url","/admin/noticeboard");
		  mav.setViewName("alert");
		  
		  return mav;
		  
	  }
	  
	  /**
	   * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	   */
	  @RequestMapping(value = "/noticeboard", method = RequestMethod.GET)
	  public ModelAndView noticeboard(@RequestParam(value="pageNum",defaultValue="1") int currentPage,@RequestParam(value="keyWord",defaultValue="") String keyWord) throws Exception {
 
			ModelAndView mav = new ModelAndView();
			
 
			
			Map<String , Object> pagingMap;
			pagingMap = noticeBoardService.listAll(currentPage,keyWord);
			  System.out.println(pagingMap.get("list"));
			mav.addObject("count",pagingMap.get("count"));
			mav.addObject("list",pagingMap.get("list"));
			mav.addObject("pagingHtml",pagingMap.get("pagingHtml"));
	 
			mav.setViewName("/noticeboard");
		    return  mav;
	  }
	  
	  
	  
	  
		//글 상세보기 코드
	  @RequestMapping(value="/noticeboardDetail" , method = RequestMethod.GET)
	  public ModelAndView detailNotiBoard(int noti_board_id) throws Exception{
		  														// 클릭시 누른버튼에 담겨져있는 noti_board_id 가 넘어와서 sql 구문에 쓸수있게 됩니다.
		  ModelAndView mav = new ModelAndView();

 
		  //1.게시글 가져오기 및 조회수 증가가되는 service 호출
		  NoticeBoardVO notice = noticeBoardService.detailNoti_Board(noti_board_id);
		  List<NoticeImageFileVO> imgList = noticeBoardService.getNoti_board_img(noti_board_id);
		  //페이지 및 noticeVO 값 반환 
		  
 
		  
		  mav.addObject("notice",notice);
		  mav.addObject("imgList",imgList);
		  mav.setViewName("/noticeboardDetail");
		  
		  return mav;
		  
		  
	  }
	  
	  

	  
	  
}
