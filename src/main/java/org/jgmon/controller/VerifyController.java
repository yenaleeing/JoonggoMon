package org.jgmon.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.jgmon.util.VerifyUtill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.*;

/**
 * Handles requests for the application home page.
 */
@Controller
public class VerifyController {

  private static final Logger logger = LoggerFactory.getLogger(VerifyController.class);
   // GET 요청을 처리하는 핸들러 메서드 추가
	   @GetMapping("/verify")
	   public String showVerify() {
	       return "verify"; // "verification"는 JSP 파일명 (파일 경로가 포함된 경우 해당 경로를 지정)
	   }
	
	   
	   @RequestMapping(value = "/verify1", method = RequestMethod.POST)
	    @ResponseBody
	    public Map<String, Object> verifyData(@RequestParam("selectdata") String selectdata,
	                                          @RequestParam("inputdata") String inputdata) {
	        String result = VerifyUtill.verifyData(selectdata, inputdata);

	        // 결과 데이터를 Map으로 구성하여 JSON 형태로 반환
	        Map<String, Object> resultMap = new HashMap<String, Object>();
	        resultMap.put("result", result);

	        return resultMap;
	    }
	   
}


  



