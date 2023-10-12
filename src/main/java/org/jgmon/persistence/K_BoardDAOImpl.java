package org.jgmon.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.jgmon.domain.K_BoardVO;
import org.jgmon.domain.K_CommentVO;
import org.jgmon.domain.K_ImageFileVO;
import org.springframework.stereotype.Repository;

@Repository
public class K_BoardDAOImpl implements K_BoardDAO{

	@Inject
	SqlSession sqlSession;
	
	private static String namespace = "k_BoardMapper"; 
	
	
	@Override
	public List<K_BoardVO> listAll(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace +".listAll",map);
	}


	@Override
	public int countBoardByUser_id(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".countBoardByUser_id",user_id);
	}
	
	
	@Override
	public List<K_BoardVO> getBoardByUser_id(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".getBoardByUser_id",user_id);
	}
	
	@Override
	public int countBoard(Map<String,Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".countBoard",map);
	}


	@Override
	public int getMaxNum() throws Exception {
		// TODO Auto-generated method stub
		Integer result = sqlSession.selectOne(namespace+".getNewBoardId");
		if(result == null ) {
			result = 1;
		}else {
			
		}
		
		return result; 
	}


	@Override
	public int writeBoard(K_BoardVO notice) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".writeBoard",notice);
	}


	@Override
	public void updateCount(Integer board_id) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(namespace+".updateCount",board_id);
	}


	@Override
	public K_BoardVO getBoard(Integer board_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".getOneBoard",board_id);
	}


	@Override
	public int deleteBoard(Integer board_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".deleteOneBoard",board_id);
	}


	@Override
	public int updateBoard(K_BoardVO notice) throws Exception {
		return sqlSession.update(namespace+".updateOneBoard",notice);
	}
	
	
	@Override
	public void uploadImages(K_ImageFileVO vo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(namespace+".uploadImage",vo);
		
	}
	
	
	@Override
	public int getMaxImgNoti() throws Exception {
		Integer result = sqlSession.selectOne(namespace+".getMaxImageId");
		if(result == null) {
			result = 0;
		}
		// TODO Auto-generated method stub
		return result;
	}


	@Override
	public List<K_ImageFileVO> getboard_img(Integer board_Id) throws Exception {
		List<K_ImageFileVO> list = sqlSession.selectList(namespace+".getBoard_img",board_Id);
		return list;
	}


	@Override
	public int delBoard_img(String b_filename) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".delBoard_img",b_filename); 
	}
	
	@Override
	public int delAllBoard_img(Integer board_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".dellAllboard_img",board_id);
	}
	
	@Override
	public int getMaxComment() throws Exception {
		// TODO Auto-generated method stub
		Integer result = sqlSession.selectOne(namespace+".getMaxCommentId");
		if(result == null) {
			result = 0;
		}
		return result; 
	}
	
	@Override
	public List<K_CommentVO> getCommentByBoard(int board_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".getCommentByBoard" , board_id);
	}
	
	@Override
	public int writeComment(K_CommentVO comment) throws Exception {
		//TODO Auto-generated method stub
		return sqlSession.insert(namespace+".writeComment",comment);
	}
	
	@Override
	public int deleteComment(Integer comment_id) throws Exception {
		//TODO Auto-generated method stub
		return sqlSession.delete(namespace+".deleteOneComment",comment_id);
	}
	
	@Override
	public int updateComment(K_CommentVO comment) throws Exception {
		return sqlSession.update(namespace+".updateOneComment",comment);
	}

	
}
