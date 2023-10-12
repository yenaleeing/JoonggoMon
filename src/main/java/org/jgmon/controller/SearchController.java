package org.jgmon.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import java.io.IOException;
import java.net.ServerSocket;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;
import java.util.concurrent.CompletableFuture;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import org.jgmon.domain.bungeVO;
import org.jgmon.domain.dangunVO;
import org.jgmon.domain.joonggoVO;
import org.jgmon.util.Bunge;
import org.jgmon.util.Dangun;
import org.jgmon.util.Joonggo;

/**
 * Handles requests for the application home page.
 */
@Controller
public class SearchController {

  private static final Logger logger = LoggerFactory.getLogger(SearchController.class);

 
  
  public class ResultThread extends Thread {
      private String searchWord;
      private ArrayList<bungeVO> list1;
      private String store;

      public ResultThread(String searchWord,String store) {
         this.searchWord = searchWord;
         this.store = store;
      }

      public ArrayList<bungeVO> getList1() {
         return list1;
      }
      /*
       * public ArrayList<dangunVO> getList2() { return list2; }
       */
      /*
       * public ArrayList<joonggoVO> getList3(){ return list3; }
       */
       
      @Override
      public void run() { 

         /*
          * SeleniumTest selTest = new SeleniumTest(searchWord); list1 =
          * selTest.crawl("번개장터"); list2 = selTest.crawl("당근마켓"); //list3 =
          * selTest.crawl("중고나라"); selTest.closeSharedDriver();
          */
          Dangun selTest = new Dangun(); 
             
                list1 = selTest.crawl(searchWord,store);
            
      }
   }
   
   
   public class ResultThread2 extends Thread {
      private String searchWord;
      private ArrayList<dangunVO> list2; 
      //private ArrayList<joonggoVO> list3;
      private String store;

      public ResultThread2(String searchWord,String store) {
         this.searchWord = searchWord;
         this.store = store;
      }

    
      public ArrayList<dangunVO> getList2() { 
         return list2; 
      }
      /*
       * public ArrayList<joonggoVO> getList3(){ return list3; }
       */
       
      @Override
      public void run() { 

         /*
          * SeleniumTest selTest = new SeleniumTest(searchWord); list1 =
          * selTest.crawl("번개장터"); list2 = selTest.crawl("당근마켓"); //list3 =
          * selTest.crawl("중고나라"); selTest.closeSharedDriver();
          */
          Bunge selTest = new Bunge(); 
            
                list2 = selTest.crawl(searchWord,store);
      
      }
   }

   public class ResultThread3 extends Thread {
	      private String searchWord; 
	      private ArrayList<joonggoVO> list3;
	      private String store;

	      public ResultThread3(String searchWord,String store) {
	         this.searchWord = searchWord;
	         this.store = store;
	      }

	    
	      public ArrayList<joonggoVO> getList3() { 
	         return list3; 
	      }
	      /*
	       * public ArrayList<joonggoVO> getList3(){ return list3; }
	       */
	       
	      @Override
	      public void run() { 

	         /*
	          * SeleniumTest selTest = new SeleniumTest(searchWord); list1 =
	          * selTest.crawl("번개장터"); list2 = selTest.crawl("당근마켓"); //list3 =
	          * selTest.crawl("중고나라"); selTest.closeSharedDriver();
	          */
	          Joonggo selTest = new Joonggo(); 
	            
	                list3 = selTest.crawl(searchWord,store);
	      
	      }
	   }

   @RequestMapping(value = "/Search", method = RequestMethod.GET)
   public String SearchGet(@RequestParam("searchWord") String searchWord, Model model) {
      logger.info("검색 진입 검색단어=> " + searchWord);

      // 번개장터와 당근마켓 검색을 수행하는 스레드 생성
      ResultThread thread = new ResultThread(searchWord,"번개장터");
      ResultThread2 thread2 = new ResultThread2(searchWord,"당근마켓");
      ResultThread3 thread3 = new ResultThread3(searchWord,"중고나라");

      thread.start();
      thread2.start();
      thread3.start();
      try {
         thread.join();
         thread2.join();
         thread3.join();
      } catch (InterruptedException e) {
         e.printStackTrace();
      }

      ArrayList<bungeVO> list1 = thread.getList1();
      ArrayList<dangunVO> list2 = thread2.getList2();
      ArrayList<joonggoVO> list3 = thread3.getList3();

      // 결과 사용 또는 처리
      model.addAttribute("searchWord", searchWord);
      if (list1 != null && !list1.isEmpty()) {
         model.addAttribute("bunge", list1);
      }
      if (list2 != null && !list2.isEmpty()) {
         model.addAttribute("dangun", list2);
      }
      
      if( list3 != null && !list3.isEmpty()) { 
    	 model.addAttribute("joonggo",list3); }
       

      model.addAttribute("searchWord");

      return "Search";
   }


 
 

 

}
