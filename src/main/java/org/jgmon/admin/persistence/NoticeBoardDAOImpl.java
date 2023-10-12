package org.jgmon.admin.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.jgmon.admin.domain.NoticeBoardVO;
import org.jgmon.admin.domain.NoticeImageFileVO;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeBoardDAOImpl implements NoticeBoardDAO{

	@Inject
	SqlSession sqlSession;
	
	private static String namespace = "noticeBoardMapper";
	  
	
	
	
	
	@Override
	public List<NoticeBoardVO> listAll(Map<String,Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace +".noticeList",map);
	}





	@Override
	public int countNotiBoard(Map<String,Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".countNotiBoard",map);
	}





	@Override
	public int getMaxNotiNum() throws Exception {
		Integer result = sqlSession.selectOne(namespace+".getNewNoticeBoardId")  ;
		// TODO Auto-generated method stub
		if( result == null) {
			result = 0 ;
		}else {

		}
		return result; 
	}





	@Override
	public int writeNoti_board(NoticeBoardVO notice) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".writeNotiboard",notice);
	}





	@Override
	public void updateCount(Integer noti_board_id) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(namespace+".updateCount",noti_board_id);
	}





	@Override
	public NoticeBoardVO getNoti_board(Integer noti_board_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".getOneNotiBoard",noti_board_id);
	}





	@Override
	public int deleteNoti_board(Integer noti_board_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".deleteOneNotiBoard",noti_board_id);
	}





	@Override
	public int updateNoti_board(NoticeBoardVO notice) throws Exception {
		return sqlSession.update(namespace+".updateOneNotiBoard",notice);
	}





	@Override
	public void uploadImages(NoticeImageFileVO vo) throws Exception {
	 
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
	public List<NoticeImageFileVO> getnoti_board_img(Integer noti_board_Id) throws Exception {
		List<NoticeImageFileVO> list = sqlSession.selectList(namespace+".getNoti_img",noti_board_Id);
		return list;
	}





	@Override
	public int delNoti_board_img(String n_imgname) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".delNoti_img",n_imgname); 
	}





	@Override
	public int delAllNoti_board_img(Integer noti_board_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".delAllNoti_img",noti_board_id);
	}  

}
