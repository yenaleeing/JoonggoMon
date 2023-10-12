package org.jgmon.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.jgmon.domain.WantVO;
import org.jgmon.service.K_BoardService;
import org.jgmon.service.WantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Component
@Controller
public class WantController {

    @Autowired
    private WantService wantService;
    
    @Autowired
    private K_BoardService boardService;

    // 찜 버튼 클릭했을 경우
    //@RequestMapping(value = "/member/wishlist", method = RequestMethod.POST)
    @RequestMapping(value = "/member/wishlist", method = RequestMethod.GET)
    public ModelAndView showWishList(HttpSession session,@RequestParam(value="pageNum",defaultValue="1") int currentPage) throws Exception {
        ModelAndView mav = new ModelAndView();
    	
        System.out.println("/member/wishlist 요청중(showWishList호출됨!)");
			
    	String user_id = (String) session.getAttribute("user_id");
		Map<String, Object> pagingMap;
		pagingMap= wantService.listAll(currentPage, user_id);
			
			
			List<WantVO> list = (List<WantVO>) pagingMap.get("list"); // "list" 키로 저장된 데이터 가져오기
			int number = wantService.countAllWant((String)session.getAttribute("user_id"));
			int BoardNumber = boardService.countBoardByUser_id((String)session.getAttribute("user_id"));

			mav.addObject("BoardNumber",BoardNumber);
			mav.addObject("wantCount",number);
			mav.setViewName("wishlist");
			mav.addObject("count",pagingMap.get("count"));
	    	mav.addObject("list", list);
	    	mav.addObject("pagingHtml",pagingMap.get("pagingHtml"));
			
			System.out.println("pagingMap데이터=>"+pagingMap);
			System.out.println("list데이터=>"+list);
    	
	    	return mav; // wishList.jsp로 결과를 전달합니다.
    }
    
    @RequestMapping(value="/member/addWishList.do", method = RequestMethod.POST)
    public ResponseEntity<String> addWishList(HttpSession session, WantVO want) throws Exception{
    	 boolean success = false; // 성공 여부에 따라 수정
    	want.setUser_id((String)session.getAttribute("user_id"));
    	
    	if(wantService.regist(want) == 1) {
    		success = true;
    	}else {
    		success = false;
    	}
    	
    	if (success) {
            return new ResponseEntity<String>("Wishlist added successfully", HttpStatus.OK);
        } else {
            return new ResponseEntity<String>("Failed to add wishlist", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    
    	
    }
    
    @RequestMapping(value ="/member/removeFromWishlist", method=RequestMethod.GET)
    public String removeFromWishlist(@RequestParam("want_id") int want_id) throws Exception {
       
     System.out.println("컨트롤러에서 removeFromWishlist 메서드 호출: " +"삭제할 want_id=>"+want_id);
        wantService.removeFromWishlist(want_id);
       
        return "redirect:/member/wishlist";
    }

    @RequestMapping(value = "/deleteAll", method = RequestMethod.GET)
    public String deleteAll(HttpSession session) {
        System.out.println("deleteAll용 user_id => " + session.getAttribute("user_id"));

        try {
            wantService.deleteAll((String)session.getAttribute("user_id"));
        	
        	int deletedCount = wantService.deleteAll((String)session.getAttribute("user_id"));
            System.out.println("Wishlist deleted successfully for user: " + session.getAttribute("user_id") + ", Deleted Count: " + deletedCount);
        } catch (Exception e) {
            System.out.println("Error while deleting wishlist for user " + session.getAttribute("user_id") + ": " + e.getMessage());
            // 오류 처리 로직 추가
        }

        // 삭제 결과를 보여주는 페이지로 리다이렉트
        return "redirect:/member/wishlist";
    }


    
}