package org.jgmon.service;

import java.util.Map;

import javax.servlet.http.HttpSession;
	
import org.jgmon.domain.MemberVO;

public interface MemberService {
	  public int regist(MemberVO vo) throws Exception;

	  public MemberVO read(String user_id) throws Exception;
	  
	  public int  idChk(MemberVO vo) throws Exception;

	  public int  emChk(MemberVO vo) throws Exception;
	  
	  public int update(MemberVO vo) throws Exception;

	  public void modify(MemberVO vo) throws Exception;

	  public void memRemove(MemberVO vo) throws Exception;
	  
	  public Map<String, String> login(MemberVO vo, HttpSession session) throws Exception;

	  public void logout(HttpSession session) throws Exception;
	  
	  public Map<String,Object> listAll(int currentPage,String keyWord) throws Exception;
	  
	  public int emailVerify(String memberEmail,String key) throws Exception;
	  
	  public int resetPassword(String email) throws Exception;
	  
	  public int checkPassword(MemberVO vo, String oldPassword) throws Exception;
	  
	  public int changePassword(MemberVO vo, String newPassword) throws Exception;

}
