package org.jgmon.admin.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.jgmon.admin.domain.ManagerVO;
import org.jgmon.admin.service.ManagerService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ManagerController {

	@Inject
	ManagerService managerService;
	
	 @RequestMapping(value ="/admin/login" , method = RequestMethod.GET)
	 public String AdminLogin() {
		 
		 return "admin/adminLogin";
	 }
	 
	 @RequestMapping(value = "/admin/login_check.do" , method =RequestMethod.POST)
	 public ModelAndView login_check(ManagerVO manager , HttpSession session) {
	  String name =   managerService.ManagerCheck(manager,session);
	  ModelAndView mav = new ModelAndView();
	   if (name != null) { // 로그인 성공 시
		   mav.addObject("msg", "로그인 성공");
		   mav.addObject("url", "/admin/noticeboard");
 
	    } else { // 로그인 실패 시
	    	mav.addObject("msg", "아이디 또는 비밀번호가 일치 하지않습니다.");
	    	mav.addObject("url", "/admin/login");
	      }
	   		mav.setViewName("alert");
	      return mav;
	    }
	 
	 @RequestMapping("/admin/logout.do")
	 public ModelAndView logout(HttpSession session, ModelAndView mav) {
		 managerService.logout(session); 

	  mav.addObject("msg", "로그아웃했습니다."); 
	  mav.addObject("url","/admin/login");
	  mav.setViewName("alert"); 
	   return mav;
	   }
	 
}
