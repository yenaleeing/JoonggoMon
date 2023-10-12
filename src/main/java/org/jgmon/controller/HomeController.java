package org.jgmon.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.jgmon.domain.ProductVO;
import org.jgmon.service.ProductService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
public class HomeController {
    @Autowired
    private ProductService productService;

  private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

  /**
   * Simply selects the home view to render by returning its name.
   */
  @RequestMapping(value = "/home", method = RequestMethod.GET)
  public String home(Locale locale, Model model) {
    logger.info("Welcome home! The client locale is {}.", locale);

    Date date = new Date();
    DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

    String formattedDate = dateFormat.format(date);

    //request.setAttribute(키명,값)
    //mav.addObject(키명,값)
    //모델객체명(Map객체형태).addAttribute(키명,값)
    List<ProductVO> recentProducts = productService.getProductsByRegDate();
    model.addAttribute("serverTime", formattedDate);
    model.addAttribute("recentProducts", recentProducts);

    return "home";
  }
  
 
}

