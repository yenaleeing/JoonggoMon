package org.jgmon.controller;


 

import java.io.File;
import java.net.BindException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.jgmon.domain.K_BoardVO;
import org.jgmon.domain.MemberVO;
import org.jgmon.domain.ProductVO;
import org.jgmon.persistence.MemberDAO;
import org.jgmon.service.K_BoardService;
import org.jgmon.service.MemberService;
import org.jgmon.service.ProductService;
import org.jgmon.service.WantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import io.netty.handler.codec.http.HttpRequest;
import org.jgmon.util.FileUtil;

@Controller
public class MemberController {
 
	@Autowired
	private MemberService memberService; //MemberDAO dao = new MemberDAO();
	
	@Autowired
	private WantService wantService;
	
	@Autowired
	private K_BoardService boardService;
	
	@Autowired
	private ProductService productService;
 
	
	@RequestMapping(value="/member/login.do" , method = RequestMethod.POST)
	public ModelAndView Login(HttpServletRequest req, HttpSession session) throws Exception {
		MemberVO member = new MemberVO();
		member.setUser_id((String)req.getParameter("login_user_id"));
		member.setU_pwd((String)req.getParameter("login_u_pwd"));
		
		Map<String, String> key= memberService.login(member, session);
		System.out.println("user id = " + key.get("user_id"));
		System.out.println("AuthKey = " + key.get("AuthKey"));
		ModelAndView mav = new ModelAndView();
		if(key.get("user_id") != null) {
			 if(key.get("AuthKey").equals("0")){
					mav.addObject("msg" , "이메일 인증을 완료해주세요!");
					mav.addObject("url","/home");
				}else {
			mav.addObject("msg","로그인 성공");
			mav.addObject("url","/home");
				}
		}else {
			mav.addObject("msg" , "아이디 또는 비밀번호가 일치 하지 않습니다.");
			mav.addObject("url","/home");
		}
		mav.setViewName("alert");
		
		return mav;
	}
	
	 @RequestMapping("/member/logout.do")
	 public ModelAndView logout(HttpSession session, ModelAndView mav) {
		 try {
			memberService.logout(session);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 

	  mav.addObject("msg", "로그아웃했습니다."); 
	  mav.addObject("url","/home");
	  mav.setViewName("alert"); 
	   return mav;
	   }
	 
	
	@RequestMapping(value="/member/regist", method = RequestMethod.GET)
	public String regist() {
		
		return "registAcc";
	}

	@Transactional
	@RequestMapping(value="/myPage/memRemove", method = RequestMethod.GET)
	public String MemRemove(MemberVO vo, Model model, HttpSession session) throws Exception {
	    System.out.println("memRemove user_id " + vo.getUser_id());
	    memberService.memRemove(vo);
	    memberService.logout(session);
	    model.addAttribute("message", "정말 회원탈퇴를 진행하시겠습니까?");
	    return "/home"; // 컨펌 페이지로 이동
	}	
	
	//회원가입 버튼 클릭시
	@RequestMapping(value="/member/regist.do",method =  RequestMethod.POST)
	public ModelAndView registSubmit(@ModelAttribute("member") MemberVO member,BindingResult result,HttpServletRequest req) {
	//																			registAcc 에서 입력한 값들을 memberVO로받아옴	, 파일을받아오기위해 썻음 , 주소와 핸드폰번호를 합치기 위헤 req 작성
	member.setAddress(req.getParameter("address")+","+req.getParameter("inputAddress1")+","+req.getParameter("inputAddress2"));
	member.setPhonenum(req.getParameter("tel1") + "-" + req.getParameter("tel2")+"-" + req.getParameter("tel3"));
 
	
		ModelAndView model = new ModelAndView();
		 	 
		 	try {
		 		//아이디 중복체크
		 		int idchk = memberService.idChk(member);
		 		int emchk = memberService.emChk(member);
		 		System.out.println(member.getUser_id());
		 		//중복된 아이디가 없을시 
		 		if(idchk== 0) {
		 			
					//회원가입 성공시
					if(memberService.regist(member)==1) {		
					
					model.addObject("msg", "회원가입이 완료되었습니다. 이메일 확인을 통해 이메일 인증을 완료해주세요");
					model.addObject("url", "/home");
					}else {
						model.addObject("msg", "회원가입 실패");
						model.addObject("url", "/home");
					}
					
		 		}else {
		 			if (idchk != 0 && emchk != 0) {
		 	            model.addObject("msg", "아이디와 이메일 모두 중복된 값이 있습니다");
		 	        } else if (idchk != 0) {
		 	            model.addObject("msg", "중복된 아이디가 있습니다");
		 	        } else {
		 	            model.addObject("msg", "중복된 이메일이 있습니다");
		 	        }
		 	        model.addObject("url", "/member/regist.do");
		 	    }
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			model.setViewName("alert");

		return (ModelAndView)model;
	}
	
	
	//아이디 중복체크
	@ResponseBody
	@RequestMapping(value="/member/regist/idChk.do" , method = RequestMethod.POST)
	public int idChk(MemberVO vo ) throws Exception{
		
		int result = memberService.idChk(vo);
		
		return result;
	}

	@ResponseBody
	@RequestMapping(value="/member/regist/emChk.do" , method = RequestMethod.POST)
	public int emChk(MemberVO vo ) throws Exception{
		
		int result = memberService.emChk(vo);
		
		return result;
	}
	
	
	//이메일 인증완료시 나오는 구문 
	@RequestMapping(value="/member/registerEmail", method=RequestMethod.GET)
	public ModelAndView emailConfirm(String memberEmail,String key )throws Exception{
		ModelAndView model = new ModelAndView();
		int result  = memberService.emailVerify(memberEmail,key);
		
		if(result == 0 ) {
			System.out.println("오류 발생");
		}else {
			model.addObject("msg", "이메일 인증이 완료되었습니다.");
			model.addObject("url", "/home");
		}
		model.setViewName("alert");

			return (ModelAndView) model;
	}
	
	
	//비밀번호 찾기 페이지 경로 
	@RequestMapping(value="/member/forgotpassword" , method = RequestMethod.GET)
	public String forgotPwd() {
		
		return "ForgotPwd";
	}
	
	//이메일 입력후 클릭시 비밀번호 초기화 및 새로운 비밀번호 전송 
	@RequestMapping(value="/member/resetpassword", method = RequestMethod.POST)
	public ModelAndView resetPwd(HttpServletRequest req) throws Exception {
		ModelAndView model = new ModelAndView();
		String email = req.getParameter("email");
		int result = memberService.resetPassword(email);
		
		if(result == 0 ) {
			System.out.println("오류 발생");
		}else {
			model.addObject("msg", "비밀번호가 초기화 되었습니다.");
			model.addObject("url", "/home");
		}
		model.setViewName("alert");
		
		
		return (ModelAndView)model;
	}
	
	//마이페이지 이동 
	@RequestMapping(value="/member/myPage" , method = RequestMethod.GET)
	public ModelAndView myPage(HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		int number = wantService.countAllWant((String)session.getAttribute("user_id"));
		int BoardNumber = boardService.countBoardByUser_id((String)session.getAttribute("user_id"));
		int ProductNumber =  productService.countProductByUser_Id((String)session.getAttribute("user_id"));	
		
		mav.addObject("ProductNumber",ProductNumber);
		mav.addObject("BoardNumber",BoardNumber);
		mav.addObject("wantCount",number);
		mav.setViewName("myPage");
		return mav;
	}
	
	
	
	//회원정보 수정 이동 
	@RequestMapping(value = "/member/editInfo" , method = RequestMethod.GET)
	public ModelAndView editInfo(HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		MemberVO member = memberService.read((String)session.getAttribute("user_id"));
		int number = wantService.countAllWant((String)session.getAttribute("user_id"));
		int BoardNumber = boardService.countBoardByUser_id((String)session.getAttribute("user_id"));
		int ProductNumber =  productService.countProductByUser_Id((String)session.getAttribute("user_id"));	
		
		mav.addObject("ProductNumber",ProductNumber);
		mav.addObject("BoardNumber",BoardNumber);
		mav.addObject("wantCount",number);
		mav.addObject("member",member);
		mav.setViewName("editInfo");
		return mav;
	}
	
	@RequestMapping(value="/member/editInfo.do", method = RequestMethod.POST)
	public ModelAndView updateInfo(@ModelAttribute("member") MemberVO member,BindingResult result,HttpServletRequest req)throws Exception{
		System.out.println("업데이트 패스");
		ModelAndView mav = new ModelAndView();
		//																			registAcc 에서 입력한 값들을 memberVO로받아옴	, 파일을받아오기위해 썻음 , 주소와 핸드폰번호를 합치기 위헤 req 작성
		member.setAddress(req.getParameter("address")+","+req.getParameter("inputAddress1")+","+req.getParameter("inputAddress2"));
		member.setPhonenum(req.getParameter("tel1") + "-" + req.getParameter("tel2")+"-" + req.getParameter("tel3"));
		
	
		if(memberService.update(member) == 1) {
			mav.addObject("msg", "회원정보 수정이 완료되었습니다.");
			mav.addObject("url", "/home");
		}
		
		mav.setViewName("alert");
		
		return mav;
	}
	
	@RequestMapping(value="/member/changePassword", method = RequestMethod.POST)
	public ModelAndView changePassword(HttpServletRequest req,HttpSession session) throws Exception{
		ModelAndView mav = new ModelAndView();
		MemberVO vo = memberService.read((String)session.getAttribute("user_id"));	
		String prePassword = (String) req.getParameter("prepassword");
			String newPassword = (String) req.getParameter("newpassword");
			String chkPassword = (String) req.getParameter("chkpassword");
			
			
			System.out.println("새로운 : " + newPassword + ", 체킹비번 : " + chkPassword);
			
		if(memberService.checkPassword(vo, prePassword) == 1 ) {
			if(newPassword.equals(chkPassword)) {
				memberService.changePassword(vo,newPassword);
				mav.addObject("msg", "비밀번호가 변경되었습니다.");
				mav.addObject("url", "/member/editInfo");
			}else {
				mav.addObject("msg", "변경할 비밀번호가 일치하지않습니다.");
				mav.addObject("url", "/member/editInfo");
			}
		}else {
			mav.addObject("msg", "현재 비밀번호가 일치하지않습니다.");
			mav.addObject("url", "/member/editInfo");
		}

				mav.setViewName("alert");
			
 		
		
		return mav;
		
		
	}
	
	  @RequestMapping(value="/member/myBoard", method=RequestMethod.GET)
	  public ModelAndView myBoard(HttpSession session) throws Exception {
		  ModelAndView mav = new ModelAndView();
		  
			int number = wantService.countAllWant((String)session.getAttribute("user_id"));
			int BoardNumber = boardService.countBoardByUser_id((String)session.getAttribute("user_id"));
			List<K_BoardVO> board = boardService.getBoardByUser_id((String)session.getAttribute("user_id"));
			int ProductNumber =  productService.countProductByUser_Id((String)session.getAttribute("user_id"));	
			
			mav.addObject("ProductNumber",ProductNumber);
			mav.addObject("boardList",board);
			mav.addObject("BoardNumber",BoardNumber);
			mav.addObject("wantCount",number);
		  mav.setViewName("myPageBoard");
		  return mav;
		  
	  }
	  
	  
	  @RequestMapping(value="/member/myProduct", method=RequestMethod.GET)
	  public ModelAndView myProduct(HttpSession session) throws Exception {
		  ModelAndView mav = new ModelAndView();
		  String user_id = (String)session.getAttribute("user_id");
			int number = wantService.countAllWant(user_id);
			int BoardNumber = boardService.countBoardByUser_id(user_id);
			int ProductNumber =  productService.countProductByUser_Id(user_id);
			List<ProductVO> productList = productService.getProductByUser_id(user_id);
 
			mav.addObject("ProductNumber",ProductNumber);
			mav.addObject("productList",productList);
			mav.addObject("BoardNumber",BoardNumber);
			mav.addObject("wantCount",number);
		  mav.setViewName("myPageProduct");
		  return mav;
		  
	  }
//****************************************************Admin*****************************************************//
	@RequestMapping(value="/admin/member",method = RequestMethod.GET)
	public ModelAndView adminMember(HttpSession session,@RequestParam(value="pageNum",defaultValue="1") int currentPage,@RequestParam(value="keyWord",defaultValue="") String keyWord) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		Map<String , Object> pagingMap;
		pagingMap = memberService.listAll(currentPage,keyWord);
		  
		mav.addObject("count",pagingMap.get("count"));
		mav.addObject("list",pagingMap.get("list"));
		mav.addObject("pagingHtml",pagingMap.get("pagingHtml"));
		mav.setViewName("admin/memberBoard");
		
		return mav;
	}
	
	
	@RequestMapping(value="/admin/memberEdit" , method = RequestMethod.GET)
	public ModelAndView adminEditMember() throws Exception{
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("admin/edit-member");
		return mav;
	}
	
	
	
	
	
}
