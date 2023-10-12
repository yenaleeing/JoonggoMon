package org.jgmon.controller;

 

import java.util.List;
//import java.util.HashMap;
//import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.jgmon.domain.K_BoardVO;
import org.jgmon.domain.K_CommentVO;
import org.jgmon.domain.K_ImageFileVO;
import org.jgmon.service.K_BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

 

@Controller
public class BoardController {

	  /**
	   * Simply selects the home view to render by returning its name.
	   */
	@Inject
	K_BoardService k_BoardService;
	
	
	  @RequestMapping(value = "/normalboard", method = RequestMethod.GET)
	  public ModelAndView normalboard(HttpSession session,@RequestParam(value="pageNum",defaultValue="1") int currentPage,@RequestParam(value="keyWord",defaultValue="") String keyWord) throws Exception {
		  ModelAndView mav = new ModelAndView();
		
		Map<String , Object> pagingMap;
		pagingMap = k_BoardService.listAll(currentPage,keyWord);
		  
		mav.addObject("count",pagingMap.get("count"));
		mav.addObject("list",pagingMap.get("list"));
		mav.addObject("pagingHtml",pagingMap.get("pagingHtml"));
		mav.setViewName("K_NormalPage");
	    return (ModelAndView) mav;
	  }
	  
	  @RequestMapping(value="/normalboard.do" , method = RequestMethod.GET)
	  public String normalboard() {
		  return "normalboard";
	  }
	  //글 작성 클릭시 오는 코드
	  @RequestMapping(value="/member/writeBoard" , method = RequestMethod.GET)
	  public ModelAndView viewWriteBoard(HttpSession session) {
		  ModelAndView mav = new ModelAndView();
		  mav.setViewName("K_write-normal");
		  return  (ModelAndView) mav;
	  }
	  
	  //								글작성 완료 버튼 클릭시 가는 링크							POST method
	  @RequestMapping(value="/member/writeboard/write.do", method = RequestMethod.POST)
	  public ModelAndView writeBoard(K_BoardVO notice, HttpSession session, BindingResult result, MultipartHttpServletRequest multipartFile) throws Exception { //HttpSession session-> 로그인 정보를 가지고온다
		  
		  List<MultipartFile> images = multipartFile.getFiles("AddImgs");
		  
		  for (int i = 0; i < images.size(); i++) {
			System.out.println(images.get(i));
		}
		  
		  //담을 객체 생성
		  ModelAndView mav = new ModelAndView();
		  notice.setUser_id((String)session.getAttribute("user_id")); //로그인 정보 가지고온다
		  //System.out.println(notice.getUser_id()); 확인 사살하기 위한 코드
		  k_BoardService.writeBoard(notice,images);
		  
		  	//ModelAndView 객체 안에 alert 구문 및 이동 페이지 작성후 alert.jsp 이동하며 alert 호출후 원하는 페이지로 이동
			 mav.addObject("msg", "글작성 완료");
			 mav.addObject("url", "/normalboard");
			 mav.setViewName("alert");
			 
		  return mav;
	  }
	  //글 상세보기 코드
	  @RequestMapping(value="/detailBoard.do" , method = RequestMethod.GET)
	  public ModelAndView detailBoard(int board_id) throws Exception{
 
		  ModelAndView mav = new ModelAndView();
		  //1.게시글 가져오기 및 조회수 증가가되는 service 호출
		  K_BoardVO notice = k_BoardService.detailBoard(board_id);	 
		  List<K_ImageFileVO> imgList = k_BoardService.getBoard_img(board_id);
	 
		  //페이지 및 noticeVO 값 반환
		  mav.addObject("notice",notice);
 
		  mav.addObject("imgList",imgList);
		  mav.setViewName("/K_NormalBoardDetail");
		  return mav;
		  		  
	  }
	  
	  @GetMapping("/path/to/getCommentList")
	    @ResponseBody // JSON 응답을 위한 어노테이션
	    public List<K_CommentVO> getCommentList(@RequestParam int board_id) throws Exception {
	        // board_id를 기반으로 데이터베이스에서 댓글 목록을 가져와서 List<Comment> 형태로 반환
	        List<K_CommentVO> comments = k_BoardService.getCommentByBoard(board_id);
	        return comments;
	    }
	    
	    
		  @PostMapping("/path/to/deleteComment")
		    @ResponseBody // JSON 응답을 위한 어노테이션
		    public String deleteComment(@RequestParam int cmnt_id) throws Exception {
		        String result = "";
		        if(k_BoardService.deleteComment(cmnt_id) == 1) {
		        	result = "success";
		        }
		        
		        return result;
		    }
	  
	  //글 아이디를 가져와서 수정해주는 코드 
	  @RequestMapping(value="/member/editBoard" , method =RequestMethod.GET)
	  public ModelAndView editBoard(int board_id) throws Exception{
		  
		  ModelAndView mav = new ModelAndView();
		  K_BoardVO notice = k_BoardService.detailBoard(board_id);
		  List<K_ImageFileVO> imgList = k_BoardService.getBoard_img(board_id);
		  
		  mav.addObject("notice",notice);
		  mav.addObject("imgList",imgList);
		  mav.setViewName("/K_edit-normal");
		  return mav;
		  
	  }
	  
	  //글 수정클릭버튼시 오는 코드 
	  @RequestMapping(value="/member/editBoard/edit.do" , method = RequestMethod.POST)
	  public ModelAndView updateBoard(K_BoardVO notice, MultipartHttpServletRequest multipartFile , @RequestParam(value="existingImages",required=false) List<String> existingImages, HttpSession session) throws Exception{
		  ModelAndView mav = new ModelAndView();
		  List<MultipartFile> images = multipartFile.getFiles("AddImgs");
		  notice.setUser_id((String)session.getAttribute("user_id"));
		  
		  //SQL 구문작성이 완료되고나서 한번 더 확인하고 싶으면 넣으면 되는 코드입니다. 성공시 1 을 반환하고 실패시 2를 반환하기에 
		  int result = k_BoardService.editBoard(notice, images, existingImages);
		  
		  if(result == 1) {
			  mav.addObject("msg","수정을 완료했습니다");
			  mav.addObject("url","/normalboard"); // -> /controller/normalboard  // -> /normalboard  // -> /K_NormalPage
		  }else {
			  mav.addObject("msg","수정에 실패했습니다");
			  mav.addObject("url","/normalboard");
		  }
		  
		  mav.setViewName("alert");
		  
		  return mav;
	  }
	  
	  //글 삭제 버튼 클릭시 되는 코드
	  @RequestMapping(value ="/member/deleteBoard.do",method=RequestMethod.GET)
	  public ModelAndView detailDeleteBoard(int board_id) throws Exception{
		  ModelAndView mav = new ModelAndView();
		  //삭제 Method 호출 
		  k_BoardService.deleteBoard(board_id);
		  
		  //ModelAndView 객체에 넘길 값 전송
		  mav.addObject("msg","글을 삭제하였습니다");
		  mav.addObject("url","/normalboard");
		  mav.setViewName("alert");
		  
		  return mav;
		  
	  }
	  
	// 확인 받기, 댓글 구현 중:
 

			// 글작성 완료 버튼 클릭시 가는 링크 POST method
			@RequestMapping(value = "/member/writecomment/writecomment.do", method = RequestMethod.POST)
			@ResponseBody
			public String writeComment(K_CommentVO comment, HttpSession session) throws Exception { // HttpSession session-> 로그인 정보를 가지고온다
	 
				
				String result ="";
				// 담을 객체 생성
			
				comment.setUser_id((String) session.getAttribute("user_id")); // 로그인 정보 가지고온다		
				
				if(session.getAttribute("user_id") != null) {
				if(k_BoardService.writeComment(comment) == 1) {
				// ModelAndView 객체 안에 alert 구문 및 이동 페이지 작성후 alert.jsp 이동하며 alert 호출후 원하는 페이지로 이동
				result ="success";
				} 
				}else {
					result ="로그인이 필요합니다";
				}

				return result;
			}


			// 글 수정클릭버튼시 오는 코드
			@RequestMapping(value = "/member/editComment/editcomment.do", method = RequestMethod.POST)
			@ResponseBody
			public String updateCommnet(K_CommentVO comment) throws Exception {
 
				String result = "";
				
				System.out.println(comment.getCmnt_id() +" 내용 ~ " + comment.getC_contents()+comment.getUser_id());
		 
				if( k_BoardService.editComment(comment) == 1 ) {
					result = "success";
				}

				  // 댓글 수정이 성공했을 때 "success" 문자열 반환
			    return result;
 
			}

			// 글 삭제 버튼 클릭시 되는 코드
			@RequestMapping(value = "/member/deleteComment.do", method = RequestMethod.GET)
			public ModelAndView detailDeleteComment(int board_id) throws Exception {
				ModelAndView mav = new ModelAndView();
				// 삭제 Method 호출
				k_BoardService.deleteComment(board_id);

				// ModelAndView 객체에 넘길 값 전송
				mav.addObject("msg", "댓글을 삭제하였습니다");
				mav.addObject("url", "/normalboard");
				mav.setViewName("alert");

				return mav;

			}
	  
	  
	  
	  /***************************Admin 구역*******************************/
	  @RequestMapping(value = "/admin/normalBoard", method = RequestMethod.GET)
	  public ModelAndView Adminnormalboard(HttpSession session,@RequestParam(value="pageNum",defaultValue="1") int currentPage,@RequestParam(value="keyWord",defaultValue="") String keyWord) throws Exception {
		  ModelAndView mav = new ModelAndView();
		
		Map<String , Object> pagingMap;
		pagingMap = k_BoardService.listAll(currentPage,keyWord);
		  
		mav.addObject("count",pagingMap.get("count"));
		mav.addObject("list",pagingMap.get("list"));
		mav.addObject("pagingHtml",pagingMap.get("pagingHtml"));
		mav.setViewName("admin/adminNormalPage");
	    return (ModelAndView) mav;
	  }
	  
	  @RequestMapping(value="/admin/normalBoard.do",method=RequestMethod.GET)
	  public ModelAndView AdminNormalBoardDetail(int board_id) throws Exception {
		  System.out.println("보드 아이디 ~ " + board_id);
		  ModelAndView mav = new ModelAndView();
		  //1.게시글 가져오기 및 조회수 증가가되는 service 호출
		  K_BoardVO notice = k_BoardService.detailBoard(board_id);	 
		  List<K_ImageFileVO> imgList = k_BoardService.getBoard_img(board_id);
	 
		  //페이지 및 noticeVO 값 반환
		  mav.addObject("notice",notice);
 
		  mav.addObject("imgList",imgList);
		  
		  mav.setViewName("admin/NormalBoardDetail");
		  
		  return mav;
		  
	  }
	  
	  
	  //글 삭제 버튼 클릭시 되는 코드
	  @RequestMapping(value ="/admin/deleteBoard.do",method=RequestMethod.GET)
	  public ModelAndView AdminDeleteBoard(int board_id) throws Exception{
		  ModelAndView mav = new ModelAndView();
		  //삭제 Method 호출 
		  k_BoardService.deleteBoard(board_id);
		  
		  //ModelAndView 객체에 넘길 값 전송
		  mav.addObject("msg","글을 삭제하였습니다");
		  mav.addObject("url","/admin/normalBoard");
		  mav.setViewName("alert");
		  
		  return mav;
		  
	  }
	  
	  
}
