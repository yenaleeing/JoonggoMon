package org.jgmon.controller;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.jgmon.domain.ProductCategoryVO;
import org.jgmon.domain.ProductImageVO;
import org.jgmon.domain.ProductVO;
import org.jgmon.service.ProductService;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProductController {

	@Inject
	ProductService productService;
	
	// 게시판 목록보기
	@RequestMapping(value = "/productMain", method = RequestMethod.GET)
	public ModelAndView ProductMain
	(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
			
	@RequestParam(value="keyWord",defaultValue="") String keyWord,
	
	   @RequestParam(value="category",defaultValue="") String category   
			) throws Exception {
		
		System.out.println("productMain 실행중..");
		ModelAndView mav = new ModelAndView();
		
		Map<String , Object> pagingMap;
		pagingMap = productService.productList(currentPage,keyWord,category);
		
		List<ProductCategoryVO> categoryList = productService.productCategoryList();
	 
		
		mav.addObject("count",pagingMap.get("count"));
		mav.addObject("list",pagingMap.get("list"));
		mav.addObject("categoryList",categoryList);
		mav.addObject("pagingHtml",pagingMap.get("pagingHtml"));
		mav.setViewName("productMainPage");
	    return (ModelAndView) mav;
	}
	
	// 글 상세보기
	@RequestMapping(value = "/productDetail.do", method = RequestMethod.GET)
	public ModelAndView detailProduct(int pro_num) throws Exception {
		// 클릭시 누른버튼에 담겨져있는 pro_num이 넘어와서 sql 구문에 쓸수있음
		System.out.println("productDetail 실행중..");
		
		ModelAndView mav = new ModelAndView();
		// 1.게시글 가져오기 및 조회수 증가가되는 service 호출
		ProductVO pvo = productService.detailProduct(pro_num);
		
		List<ProductImageVO> imgList = productService.getProductImage(pro_num);
		  
		// 페이지 및 productVO 값 반환
 
		
		mav.addObject("pvo",pvo);
		mav.addObject("imgList",imgList);
		mav.setViewName("/productDetailPage");
		  
		return mav;
	}

	

	// 글 작성하기 클릭시
	@RequestMapping(value = "/productUpload", method = RequestMethod.GET)
	public ModelAndView ProductUploadPage(HttpSession session) throws Exception {

		 ModelAndView mav = new ModelAndView();
		  
		 //**** 이부분은 로그인 관련 코드라 세션을 가져온다는것만 알아두시면 됩니다 *****/
		 System.out.println("userid -> " + session.getAttribute("user_id"));
		 if(session.getAttribute("user_id") != null) {
			 mav.setViewName("productUploadPage");
		 }else {
			 mav.addObject("msg","로그인 후 상품판매가 가능합니다.");
			 mav.addObject("url", "productMain");
			 mav.setViewName("alert");
		 }
		 //*** 여기까지 ****//*
		 
		 
		 
		 // 카테고리 값 받아서 반환
		 List<ProductCategoryVO> P_list = productService.productCategoryList();
		 System.out.println(P_list);
 
		
		 mav.addObject("list",P_list);
		 	
		 return (ModelAndView) mav;

	}
	
	// 글작성 완료 버튼 클릭시 (POST method)
	@RequestMapping(value = "/productUpload/write.do", method = RequestMethod.POST)
	public ModelAndView writeProductBoard(HttpSession session,ProductVO pvo,ProductCategoryVO pcategoryvo,BindingResult result, MultipartHttpServletRequest multipartFile) throws Exception {
		
		// 이미지파일 업로드 관련
		List<MultipartFile> images = multipartFile.getFiles("AddImgs");
		
		for (int i = 0; i < images.size(); i++) {
			System.out.println(images.get(i));
		}
	 
	 
		// 담을 객체 생성
		ModelAndView mav = new ModelAndView();
	
		// 글작성시 input이 없는 필드들 초기값 세팅
		pvo.setUser_id((String)session.getAttribute("user_id")); // 세션 통해서 user_id 가져오기
		Date d = new Date();
		pvo.setP_regdate(d); // 작성일자 현재시간으로 설정
		pvo.setArchive(0);
		pvo.setP_count(0); // 조회수 0으로 설정
		//pvo.setP_img("/");
		
		
		// 배송비 체크 여부 확인
		 if(pvo.getP_dfee() != null) {
			 pvo.setP_dfee("배송비 포함");
		 }else {
			 pvo.setP_dfee("배송비 미포함");
		 }
		 
		// productService 에있는 insert 관련 구문 호출
		// --> 초기값이 설정된 이후 실행되어야 값을 가져와서 처리할수있음 순서에 주의..!
		 productService.writeProduct(pvo,images);

		//찜카운트는 -> 병현씨 mapper 에서 select count(*) from want where product_id = ? 
		
		// ModelAndView 객체 안에 alert 구문 및 이동 페이지 작성후 alert.jsp 이동하며 alert 호출후 원하는 페이지로 이동
		mav.addObject("msg", "판매글이 등록되었습니다.");
		mav.addObject("url", "/productMain");
		mav.setViewName("alert");

		return mav;
	}


	// 글 수정하기 (pro_num을 가져와서 글 수정)
	@RequestMapping(value = "/member/editProduct", method = RequestMethod.GET)
	public ModelAndView updateOneProduct(int pro_num) throws Exception {
		ModelAndView mav = new ModelAndView();
		ProductVO pvo = productService.detailProduct(pro_num);
		List<ProductImageVO> PimgList = productService.getProductImage(pro_num);
		List<ProductCategoryVO> categoryList = productService.productCategoryList();
		mav.addObject("pvo",pvo);
		mav.addObject("imgList",PimgList);
		mav.addObject("categoryList",categoryList);
		mav.setViewName("/productEditPage");
		return mav;
	}

	// 글 수정완료 클릭시 오는 코드
	@RequestMapping(value = "/member/editProduct/edit.do", method = RequestMethod.POST)
	public ModelAndView updateProdductBoard(HttpSession session,ProductVO pvo, MultipartHttpServletRequest multipartFile , @RequestParam(value="existingImages",required=false) List<String> existingImages)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		List<MultipartFile> images = multipartFile.getFiles("AddImgs");
		 
		pvo.setUser_id((String)session.getAttribute("user_id"));
		
		 if(pvo.getP_dfee() != null) {
			 pvo.setP_dfee("배송비 포함");
		 }else {
			 pvo.setP_dfee("배송비 미포함");
		 }
		 
		// SQL 구문작성이 완료되고나서 한번더 확인하고 싶으면 넣으면되는 코드입니다. 성공시 1 을 반환 하고 실패시 2를 반환하기에
		int result = productService.updateOneProduct(pvo, images, existingImages);

		if (result == 1) {
			mav.addObject("msg", "수정 성공");
			mav.addObject("url", "/productMain");
		} else {
			mav.addObject("msg", "수정 실패");
			mav.addObject("url", "/productMain");
		}

		mav.setViewName("alert");

		return mav;
	}

	// 글 삭제 버튼 클릭시 되는 코드
	@RequestMapping(value = "/deleteProduct.do", method = RequestMethod.GET)
	public ModelAndView detailDeleteProduct(int pro_num) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		// 삭제 Method 호출
		productService.deleteOneProduct(pro_num);

		// ModelAndView 객체에 넘길 값 전송
		mav.addObject("msg", "판매글이 삭제되었습니다.");
		mav.addObject("url", "/productMain");
		mav.setViewName("alert");

		return mav;
	}

	/******************************Admin페이지**********************************/

	// 게시판 목록보기
		@RequestMapping(value = "/admin/adminProduct", method = RequestMethod.GET)
		public ModelAndView AdminProductMain
		(@RequestParam(value="pageNum",defaultValue="1") int currentPage,
				
		@RequestParam(value="keyWord",defaultValue="") String keyWord) throws Exception {
			
			System.out.println("adminProduct 실행중..");
			ModelAndView mav = new ModelAndView();
			
			Map<String , Object> pagingMap;
			pagingMap = productService.productList(currentPage,keyWord, keyWord);
			
			List<ProductCategoryVO> categoryList = productService.productCategoryList();
		 
			
			mav.addObject("count",pagingMap.get("count"));
			mav.addObject("list",pagingMap.get("list"));
			mav.addObject("categoryList",categoryList);
			mav.addObject("pagingHtml",pagingMap.get("pagingHtml"));
			mav.setViewName("/admin/adminProduct");
		    return (ModelAndView) mav;
		}

			@RequestMapping(value = "/admin/deleteProduct.do", method = RequestMethod.GET)
			public ModelAndView detailDeletePro(int pro_num) throws Exception {
				ModelAndView mav = new ModelAndView();
				
				// 삭제 Method 호출
				productService.deleteOneProduct(pro_num);

				// ModelAndView 객체에 넘길 값 전송
				mav.addObject("msg", "판매글이 삭제되었습니다.");
				mav.addObject("url", "/admin/adminProduct");
				mav.setViewName("alert");

				return mav;
			}
			// 글 수정하기 (pro_num을 가져와서 글 수정)
			@RequestMapping(value = "/admin/editProduct", method = RequestMethod.GET)
			public ModelAndView updateOnePro(int pro_num) throws Exception {
				ModelAndView mav = new ModelAndView();
				ProductVO pvo = productService.detailProduct(pro_num);
				List<ProductImageVO> PimgList = productService.getProductImage(pro_num);
				List<ProductCategoryVO> categoryList = productService.productCategoryList();
				mav.addObject("pvo",pvo);
				mav.addObject("imgList",PimgList);
				mav.addObject("categoryList",categoryList);
				mav.setViewName("/admin/edit-product");
				return mav;
			}
			// 글 수정완료 클릭시 오는 코드
			@RequestMapping(value = "/admin/editProduct/edit.do", method = RequestMethod.POST)
			public ModelAndView updateProBoard(HttpSession session,ProductVO pvo, MultipartHttpServletRequest multipartFile , @RequestParam(value="existingImages",required=false) List<String> existingImages)
					throws Exception {
				ModelAndView mav = new ModelAndView();
				List<MultipartFile> images = multipartFile.getFiles("AddImgs");
				 
				pvo.setUser_id((String)session.getAttribute("user_id"));
				
				 if(pvo.getP_dfee() != null) {
					 pvo.setP_dfee("배송비 포함");
				 }else {
					 pvo.setP_dfee("배송비 미포함");
				 }
				 
				// SQL 구문작성이 완료되고나서 한번더 확인하고 싶으면 넣으면되는 코드입니다. 성공시 1 을 반환 하고 실패시 2를 반환하기에
				int result = productService.updateOneProduct(pvo, images, existingImages);

				if (result == 1) {
					mav.addObject("msg", "수정 성공");
					mav.addObject("url", "/admin/adminProduct");
				} else {
					mav.addObject("msg", "수정 실패");
					mav.addObject("url", "/admin/adminProduct");
				}

				mav.setViewName("alert");

				return mav;
			}
}
