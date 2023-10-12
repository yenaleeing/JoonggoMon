package org.jgmon.persistence;

import java.util.List; 
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.jgmon.domain.ProductCategoryVO;
import org.jgmon.domain.ProductImageVO;
import org.jgmon.domain.ProductVO;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

@Repository	
public class ProductDAOImpl implements ProductDAO {

	@Inject
	SqlSession sqlSession;
	
	private static String namespace = "ProductMapper";
	
	@Override
	public int countProduct(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".countProduct",map);
	}

	@Override
	public List<ProductVO> productList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace +".productList",map);
	}

	@Override
	public int getMaxProductNum() throws Exception {
		// TODO Auto-generated method stub
		Integer result = sqlSession.selectOne(namespace+".getNewProductNumber");
		if(result == null) {
			result = 0 ;
		}
		
		return result;
	}

	@Override
	public int writeProduct(ProductVO pvo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert(namespace+".writeProduct",pvo);
	}

	@Override
	public void updateCount(Integer pro_num) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(namespace+".updateCount",pro_num);
	}
	
	
	@Override
	public ProductVO getOneProduct(Integer pro_num) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".getOneProduct",pro_num);
	}

	@Override
	public int deleteOneProduct(Integer pro_num) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".deleteOneProduct",pro_num);
	}

	@Override
	public int updateOneProduct(ProductVO pvo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update(namespace+".updateOneProduct",pvo);
 
	}

	@Override
	public List<ProductCategoryVO> productCategory() throws Exception {
		return sqlSession.selectList(namespace+".productCategoryList");
	}
	
	@Override
	public int countProductByUser_id(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".countProductByUser_id",user_id);
	}
	
	@Override
	public List<ProductVO> getProductByUser_id(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace+".getProductByUser_id",user_id);
	}
	
	
	
	//이미지파일 관련 추가
	@Override
	public void uploadProductImage(ProductImageVO ivo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update(namespace+".uploadProductImage",ivo);
	}
	
	@Override
	public int getMaxProductImageId() throws Exception {
		// TODO Auto-generated method stub
		Integer result = sqlSession.selectOne(namespace+".getMaxProductImageId");
		if(result == null) {
			result = 0;
		}
		return result;
	}
	
	@Override
	public List<ProductImageVO> getProductImage(Integer pro_num) throws Exception {
		// TODO Auto-generated method stub
		List<ProductImageVO> list = sqlSession.selectList(namespace+".getProductImage",pro_num);
		return list;
	}
	
	@Override
	public int delProductImage(String p_imgname) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".delPro_img",p_imgname);
	}

	@Override
	public int delAllProduct_img(Integer pro_num) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete(namespace+".delAllPro_img",pro_num);
	}



    @Override
    public List<ProductVO> getProductsByRegDate() {
        return sqlSession.selectList(namespace + ".getProductsByRegDate");
    }
}

	


