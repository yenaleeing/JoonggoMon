package org.jgmon.admin.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.jgmon.admin.domain.ManagerVO;
import org.springframework.stereotype.Repository;

@Repository
public class ManagerDAOImpl implements ManagerDAO {

	  private static String namespace = "managerMapper";
	  
	  
	@Inject
	SqlSession sqlSession;
	
	@Override
	public String managerChk(ManagerVO manager) {
		// TODO Auto-generated method stub
		String name = sqlSession.selectOne(namespace+".loginCheck",manager);
		return name ;
	}

}
