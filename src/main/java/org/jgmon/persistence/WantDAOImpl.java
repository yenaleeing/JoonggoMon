package org.jgmon.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.jgmon.domain.WantVO;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class WantDAOImpl implements WantDAO {
	
	@Inject
	private SqlSession sqlSession;
	private static String namespace = "wantMapper";
	
	@Override // USER_ID에 따라 리스트 정렬
	public List<WantVO> listAll(Map<String, Object> map) throws Exception {
		System.out.println("listByUserId()호출됨");
		return sqlSession.selectList(namespace + ".listAll",map);
	}
	
	@Override
	public int countWant(Map<String,Object> map) {
		// TODO Auto-generated method stub
		System.out.println("countWant,listAll메서드 map=>"+map);
		return sqlSession.selectOne(namespace+".countWant",map);
		
	}
	
	@Override
	public int countAllwant(String want_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".countNumWant",want_id);
	}
	
	@Override
	public int countPublicWant() {
		// TODO Auto-generated method stub
		Integer result = sqlSession.selectOne(namespace+".countPublicWant") ;
		if(result == null ) {
			result = 0;
		}else {
		
		}
		
		return result;
	}
	
	@Override
	public int getMaxUser_Want_Id() throws Exception {
		Integer result = sqlSession.selectOne(namespace +".maxUser_want");
		if(result == null ) {
			result = 0;
		}else {
			
		}

		
		return result;
	}
	
	  @Override
	public int insert(WantVO want_id) throws Exception {
	    // TODO Auto-generated method stub
	    System.out.println("WantDAOImpl 통과");
	    return sqlSession.insert(namespace + ".regist", want_id);
	}
	  
	  
	 @Override
	public int insertUser_want(WantVO want) throws Exception {
		
		return sqlSession.insert(namespace+".regist_user_want" ,want);
	}
	
	@Override
	public int removeFromWishlist(int want_id) throws Exception {
		System.out.println("removeFromWishlist실행됨, 데이터"+want_id+"삭제됨!");
		sqlSession.delete(namespace + ".removeFromWishlist", want_id);
		return sqlSession.delete(namespace+".removeFromWishListUser_want",want_id);
		
	}

	@Override
	@Transactional
	public int deleteAll(String user_id) throws Exception {
		System.out.println("WantDAOImpl의 deleteAll실행! 사용자의 찜목록 모두삭제완료");
		return sqlSession.delete(namespace + ".deleteAll", user_id);
	}



}
