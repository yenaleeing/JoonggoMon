package org.jgmon.persistence;

import java.util.List;
import java.util.Map;

import org.jgmon.domain.MemberVO;

public interface MemberDAO {

	public int create(MemberVO vo) throws Exception;
	
	public String login(MemberVO vo) throws Exception;

	public MemberVO read(String user_id) throws Exception;
	
	public String getPwd(MemberVO vo) throws Exception;
	
	public String getStatus(MemberVO vo) throws Exception;

	public int idChk(MemberVO vo) throws Exception;

	public int emChk(MemberVO vo) throws Exception;

	public int update(MemberVO vo) throws Exception;

	public void memRemove(MemberVO vo) throws Exception;

	public void delete(String user_id) throws Exception;

	public List<MemberVO> listAll(Map<String,Object> map) throws Exception;

	public List<MemberVO> listPage(int page) throws Exception;
	
	public int  emailVerification(String memberEmail,String key) throws Exception;
 
	public int resetPassword(String email,String resetPassword) throws Exception;
	
	public int changePassword(String user_id, String oldPassword) throws Exception;
	
	public int countMember(Map<String,Object> map) throws Exception; 
	
	 
}
