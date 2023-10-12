package org.jgmon.service;

import java.io.File; 
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.jgmon.admin.domain.NoticeBoardVO;
import org.jgmon.admin.domain.NoticeImageFileVO;
import org.jgmon.domain.ProductCategoryVO;
import org.jgmon.domain.ProductImageVO;
import org.jgmon.domain.ProductVO;
import org.jgmon.persistence.ProductDAO;
import org.jgmon.util.FileUtil;
import org.jgmon.util.PagingUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ProductServiceImpl implements ProductService {

	@Inject
	ProductDAO productDAO;
	
	
	@Override
	public Map<String, Object> productList(int currentPage, String keyWord,String category) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String,Object> pagingMap = new HashMap<String, Object>();
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("keyWord", keyWord); //검색어
		map.put("category", category);
		int count = productDAO.countProduct(map);
		//검색분야 , 검색어  -> parameterType = " map " (Map객체)
		
		//페이징 처리(1.현재페이지 2.총레코드수 3.페이지당 게시물수(10) 4.블럭당 페이지수(10) 5.요청명령어 지정
		PagingUtil page = new PagingUtil(currentPage, count, 6, 3, "productMain");
		//start = > 페이지당 맨 첫번째 나오는 게시물 번호
		//end = > 마지막 게시물 번호
		map.put("start", page.getStartCount());
		//<-> map.get("start") => #{start}
		map.put("end", page.getEndCount());
		
		List<ProductVO> list = null; 
		if(count > 0 ) {
			list = productDAO.productList(map); // keyWord,start,end 
		}else {
			list = Collections.EMPTY_LIST; // 0 적용 
		}
		
		pagingMap.put("list", list);
		pagingMap.put("count",count);
		pagingMap.put("pagingHtml",page.getPagingHtml());
		
		
		return pagingMap;
	}

	@Override
	public int writeProduct(ProductVO pvo, List<MultipartFile> images) throws Exception {
		// TODO Auto-generated method stub
		ProductImageVO ivo = new ProductImageVO();
		
		int maxProductID =  productDAO.getMaxProductNum();
		if(maxProductID != 0) {
		pvo.setPro_num(maxProductID + 1);
		}else {
			pvo.setPro_num(1);
		}
		
		int result =  productDAO.writeProduct(pvo);
		
		if(null != images && images.size() > 0) {
			for(MultipartFile multipartFile : images) {
			
				String filename = FileUtil.rename(multipartFile.getOriginalFilename());
				
				ivo.setUser_id(pvo.getUser_id()); 
				ivo.setPro_category_id(pvo.getPro_category_id());
				ivo.setPro_num(pvo.getPro_num());
				ivo.setP_imgname(filename);
				ivo.setPro_imgid(productDAO.getMaxProductImageId()+1);
				ivo.setP_originalfilename(multipartFile.getOriginalFilename());
				
				if(!multipartFile.isEmpty()) {
					
					productDAO.uploadProductImage(ivo);
					File file = new File(FileUtil.UPLOAD_PATH+"productImg/"+filename);
					multipartFile.transferTo(file);
				}
				
			}
		}
		
		
		return result;
		
		
		
	}
	
	
	@Override
	public int countProductByUser_Id(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.countProductByUser_id(user_id);
	}
	
	@Override
	public List<ProductVO> getProductByUser_id(String user_id) throws Exception {
		// TODO Auto-generated method stub
		return productDAO.getProductByUser_id(user_id);
	}

	@Override
	public ProductVO detailProduct(Integer pro_num) throws Exception {
		// TODO Auto-generated method stub
		//조회수 증가
		productDAO.updateCount(pro_num);
		//번호에 맞게 게시판글 가져오기
		ProductVO pvo = productDAO.getOneProduct(pro_num);
		return pvo;
	}

	@Override
	public int deleteOneProduct(Integer pro_num) throws Exception {
		// TODO Auto-generated method stub
		List<ProductImageVO> oldImages = productDAO.getProductImage(pro_num);
		//글삭제 sql 불러오기 
		int result = productDAO.deleteOneProduct(pro_num);
		if(result == 1) {
			for (ProductImageVO productImageVO : oldImages) {
				 FileUtil.removeFile("/productImg/" + productImageVO.getP_imgname());
			}
		}
		return result;
	}

	@Override
	public int updateOneProduct(ProductVO pvo, List<MultipartFile> images, List<String> existingImages) throws Exception {
		//글 수정 sql 불러오기 
				List<ProductImageVO> oldImages = productDAO.getProductImage(pvo.getPro_num());
				
				 
				
				if((existingImages != null)) {
				   // 새로운 이미지와 비교하며 이전 이미지 중에서 삭제해야 할 것들을 삭제합니다.
			    for (ProductImageVO oldImage : oldImages) {
			        boolean found = false;
			        
			        for (String existingImage : existingImages) {
			            if (existingImage.equals(oldImage.getP_imgname())) {
			                found = true;
			                break;
			            }
			        }
			        
			        if (!found) {
			            productDAO.delProductImage(oldImage.getP_imgname());
			            FileUtil.removeFile("/productImg/" + oldImage.getP_imgname());
			        }
			    }


				}else {
					productDAO.delAllProduct_img(pvo.getPro_num());
				}
				  
			    // 새로운 이미지를 추가합니다.
			    for (MultipartFile image : images) {
			        if (!image.isEmpty()) {
			            String filename = FileUtil.rename(image.getOriginalFilename());
			            ProductImageVO vo = new ProductImageVO();
			            vo.setUser_id(pvo.getUser_id()); 
						vo.setPro_category_id(pvo.getPro_category_id());
						vo.setPro_num(pvo.getPro_num());
						vo.setP_imgname(filename);
						vo.setPro_imgid(productDAO.getMaxProductImageId()+1);
						vo.setP_originalfilename(filename);
			            productDAO.uploadProductImage(vo);

			            File file = new File(FileUtil.UPLOAD_PATH + "productImg/" + filename);
			            image.transferTo(file);
			        }
			    }
				
				int result = productDAO.updateOneProduct(pvo);
				return result;
	}
	
	// 카테고리 불러오기 (???)
	@Override
	public List<ProductCategoryVO> productCategoryList() throws Exception {
		// TODO Auto-generated method stub
		List<ProductCategoryVO> list = productDAO.productCategory();
		return list;
	}
	
	
	//게시글 사진 가져오기 (???)
	@Override
	public List<ProductImageVO> getProductImage(int pro_num) throws Exception {
		// TODO Auto-generated method stub
		List<ProductImageVO> list = productDAO.getProductImage(pro_num);
		return list;
	}	
	
   
    @Override
    public List<ProductVO> getProductsByRegDate() {
        return productDAO.getProductsByRegDate();
    }

	
	
}
