package org.jgmon.service;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.jgmon.domain.WantVO;
import org.jgmon.persistence.WantDAO;
import org.jgmon.util.PagingUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class WantServiceImpl implements WantService {
	
	@Inject
	private WantDAO wantDAO;
	
	@Override
    public Map<String, Object> listAll(int currentPage, String user_id) throws Exception {
        
		//pagingMap객체를 받아오기 위한 생성자 생성 
		Map<String, Object> pagingMap = new HashMap<String, Object>();
		//map 객체를 받아오기 위한 생성자 생성
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_id",user_id);
        
		int count = wantDAO.countWant(map); // 전체 게시물 수 가져오기

        PagingUtil page = new PagingUtil(currentPage, count, 6, 5, "wishlist");
        //start = > 페이지당 맨 첫번째 나오는 게시물 번호
      	//end = > 마지막 게시물 번호
        map.put("start", page.getStartCount()); // start를  Map에 추가
        //<-> map.get("start") => #{start}
        map.put("end", page.getEndCount());	// end를  Map에 추가
        
        List<WantVO> list = null;
        if (count > 0) {  
            list= wantDAO.listAll(map);// user_id,start,end
        } else {
            list = Collections.EMPTY_LIST; // 0 적용
        }

        pagingMap.put("list", list);
        pagingMap.put("count", count);
        pagingMap.put("pagingHtml", page.getPagingHtml());
        
        
        return pagingMap;
    }
	
	@Override
	public int regist(WantVO wantVO) throws Exception {
		System.out.println("WANT_ID 등록됨"+wantVO);
		int result = 0 ;
		wantVO.setWant_id(wantDAO.countPublicWant()+1);
			if(wantDAO.insert(wantVO) == 1) {
				wantVO.setUser_want_id((wantDAO.getMaxUser_Want_Id()+1));
				System.out.println(wantVO.getUser_id());
				System.out.println(wantVO.getUser_want_id());
				System.out.println(wantVO.getWant_id());
				wantDAO.insertUser_want(wantVO);
				
				result = 1;
			}else {
				result = 0;
		}
		return result;
		
	}
	
	@Override
	public int countAllWant(String want_id) throws Exception {
		// TODO Auto-generated method stub
		return wantDAO.countAllwant(want_id);
	}
	
	//찜 목록에서 하트 눌려있는 것을 눌렀을 때 해당 찜목록을 삭제하는 구문
	@Override
	 public int removeFromWishlist(int want_id) throws Exception {
	        System.out.println("removeFromWishlist 실행됨, 데이터 " + want_id + " 삭제됨!");
	       int result = wantDAO.removeFromWishlist(want_id);
	       return result;
	    }

	@Override
    @Transactional
    public int deleteAll(String user_id) throws Exception {

            System.out.println("Deleting wishlist for user: " + user_id);
            
            // 찜목록 데이터 삭제
            int deletedCount = wantDAO.deleteAll(user_id);
            
            return deletedCount;
       
        }
    }


