package org.jgmon.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.jdbc.SQL;
import org.apache.ibatis.session.SqlSession;
import org.jgmon.domain.MemberVO;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class MemberDAOImpl implements MemberDAO{

	@Inject
	private SqlSession session;
	
	  private static String namespace = "memberMapper";

	  
	@Override
	public String login(MemberVO vo) throws Exception {
		 
		String user_id = session.selectOne(namespace+".login",vo);
		
		return user_id;
	}
	
	@Override
	public String getPwd(MemberVO vo) throws Exception {
		String u_pwd = session.selectOne(namespace + ".getPwd",vo);
		return u_pwd;
	}
	
	@Override
	public String getStatus(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		String AuthKey = session.selectOne(namespace +".getAuthKey",vo);
		return AuthKey;
	}
 

		
	  
	@Override
	@Transactional
	public int create(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("memberDAOImpl 통과");
		session.insert(namespace+".create",vo);
		return session.insert(namespace+".regist",vo);

	}
	
	@Override
	public int emailVerification(String memberEmail, String key) throws Exception {
		// TODO Auto-generated method stub
		Map<String,String>map = new HashMap<String,String>();
		map.put("memberEmail", memberEmail);
		map.put("key", key);
		int result =  session.update(namespace+".verify",map);
		return result;
	}
	
	

	@Override
	public MemberVO read(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".getOneMember",user_id);
	}
	
	@Override
	public int  idChk(MemberVO vo) {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".idChk",vo);
	}

	@Override
	public int emChk(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		return session.selectOne(namespace+".emChk",vo);
	}


	@Override
	public int update(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		int result;
		result =session.update(namespace+".updateOneMember",vo); 
		return  result;
		
	}

	@Override
	public void delete(String user_id) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void memRemove(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		session.delete(namespace+".memberRemove", vo);
	}

	@Override
	public List<MemberVO> listAll(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".memberList",map);
	}

	@Override
	public List<MemberVO> listPage(int page) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@Transactional
	public int resetPassword(String email, String resetPassword) throws Exception {
		// TODO Auto-generated method stub
		Map<String,String>map = new HashMap<String,String>();
		map.put("email", email);
		map.put("resetPassword", resetPassword);
		session.update(namespace + ".mresetpassword",map);
		return session.update(namespace+".resetpassword",map);
	}

	@Override
	@Transactional
	public int changePassword(String user_id, String newPassword) throws Exception {
		// TODO Auto-generated method stub
		Map<String,String>map = new HashMap<String, String>();
		map.put("user_id", user_id);
		map.put("newPassword", newPassword);
		session.update(namespace + ".mchangepassword",map);
		return session.update(namespace+".changepassword",map);
	}

	
	@Override
	public int countMember(Map<String, Object> map) throws Exception {
		
		return session.selectOne(namespace+".countMember",map);
	}






}
