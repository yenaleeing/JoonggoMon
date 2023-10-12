package org.jgmon.util;

import java.util.ArrayList;
import java.util.NoSuchElementException;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

import org.jgmon.domain.bungeVO;
import org.jgmon.domain.dangunVO;
import org.jgmon.domain.joonggoVO;

public class Joonggo {

   public static void main(String[] args) {

   }

   // WebDriver
   private static WebDriver driver;

   private WebElement webElement;

   // Properties
   public static final String WEB_DRIVER_ID = "webdriver.chrome.driver";
   public static final String WEB_DRIVER_PATH = "C:\\sts-bundle\\chromedriver\\chromedriver.exe";

   // 크롤링 할 URL
   private String base_url;
    

   public Joonggo() {
      super();

      // System Property SetUp
      System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);

      // Driver SetUp
      ChromeOptions options = new ChromeOptions();
      options.addArguments("--disable-popup-blocking"); // 팝업안띄움
      options.addArguments("headless"); // 브라우저 안띄움
      options.addArguments("--disable-gpu"); // gpu 비활성화
      options.addArguments("--blink-settings=imagesEnabled=false"); // 이미지 다운 안받음
      
      driver = new ChromeDriver(options);
      driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);
       

   }

   public ArrayList crawl(String searchWord,String store) {
	      ArrayList<Object> list = new ArrayList();

	      try {
	         // get page (= 브라우저에서 url을 주소창에 넣은 후 request 한 것과 같다)

//	            List<WebElement> elements = driver.findElements(By.xpath("//*[@id=\"root\"]/div/div/div[4]/div/div[4]/div"));
//	            for (WebElement element : elements) {
//	                System.out.println("----------------------------");
//	                System.out.println(element.getAttribute("sc-bGbJRg iZZEyc"));   //⭐
//	            }

	         if (store.equals("번개장터")) {
	            base_url = "https://m.bunjang.co.kr/search/products?q=" + searchWord;
	            driver.get(base_url);
	            System.out.println(base_url);
	            for (int i = 1; i < 12; i++) {

	               if (i == 1 || i == 2) {

	               } else {

	                  bungeVO bvo = new bungeVO();
	                  try {
	                     System.out.println(base_url);
	                     WebElement bPrice = driver.findElement(
	                             By.xpath("//*[@id=\"root\"]/div/div/div[4]/div/div[4]/div/div[" + i + "]/a/div[2]/div[2]/div[1]"));
	                     WebElement bContent = driver.findElement(
	                             By.xpath("//*[@id=\"root\"]/div/div/div[4]/div/div[4]/div/div[" + i + "]/a"));
	                     WebElement bImageSrc = driver.findElement(
	                    	   By.xpath("//*[@id=\"root\"]/div/div/div[4]/div/div[4]/div/div[" + i + "]/a/div[1]/img"));
	                      
	                     bvo.setPrice(bPrice.getText());
	                     bvo.setImageSrc(bImageSrc.getAttribute("src"));
	                     bvo.setContent(bContent.getText());
	                     bvo.setHref(bContent.getAttribute("href"));

	                     System.out.println("==번개장터입니다==");
	                     System.out.println(bPrice.getText());
	                     System.out.println(bImageSrc.getAttribute("src"));
	                     System.out.println(bContent.getText());
	                     System.out.println(bContent.getAttribute("href"));
	                     list.add(bvo);
	                  } catch (NoSuchElementException e) {
	                     continue;
	                  }
	               }
	            }

	         } 
	         
	 


	    	  if (store.equals("당근마켓")) {
	              base_url = "https://www.daangn.com/search/" + searchWord + "/";
	              driver.get(base_url);
	              System.out.println(base_url);

	              for (int i = 1; i <= 6; i++) {
	                 dangunVO dvo = new dangunVO();
	                 WebElement dPrice;
	                 WebElement dContent;
	                 WebElement dImageSrc;
	                 WebElement dhref;
	                 try {
	                    System.out.println(base_url);
	                    dPrice = driver
	                          .findElement(By.xpath("//*[@id=\"flea-market-wrap\"]/article[" + i + "]/a/div[2]/p[2]"));
	                    dContent = driver
	                          .findElement(By.xpath("//*[@id=\"flea-market-wrap\"]/article[" + i + "]/a/div[2]"));
	                    dImageSrc = driver
	                          .findElement(By.xpath("//*[@id=\"flea-market-wrap\"]/article[" + i + "]/a/div[1]/img"));
	                    dhref = driver
	                    	  .findElement(By.xpath("//*[@id=\"flea-market-wrap\"]/article[" + i + "]/a"));
	                 } catch (NoSuchElementException e) {
	                    continue;
	                 }
	                 dvo.setPrice(dPrice.getText());
	                 dvo.setImageSrc(dImageSrc.getAttribute("src"));
	                 dvo.setContent(dContent.getText());
	                 dvo.setHref(dhref.getAttribute("href"));

	                 System.out.println("=====당근마켓입니다====");
	                 System.out.println(dPrice.getText());
	                 System.out.println(dContent.getText());
	                 System.out.println(dImageSrc.getAttribute("src"));
	                 System.out.println(dhref.getAttribute("href"));

	                 list.add(dvo);

	              }

	           } 
	           



	          if (store.equals("중고나라")) {
	              base_url = "https://web.joongna.com/search/" + searchWord;
	              driver.get(base_url);
	              System.out.println(base_url);

	              for (int i = 1; i < 6; i++) {
	                 joonggoVO jvo = new joonggoVO();
	                 WebElement jPrice;
	                 //WebElement jContent;
	                 WebElement jImageSrc;
	                 WebElement jhref;

	                 try {
							/*
							 * jContent = driver.findElement(
							 * By.xpath("//*[@id=\"__next\"]/div/main/div[1]/div[2]/ul/li[" + i + "]/a"));
							 */
	                    jPrice = driver.findElement(
	                    By.xpath("//*[@id=\"__next\"]/div/main/div[1]/div[2]/ul/li[" + i + "]/a/div[2]/div[1]"));
	                    jImageSrc = driver.findElement(
	                    By.xpath("//*[@id=\"__next\"]/div/main/div[1]/div[2]/ul/li[" + i + "]/a/div[1]/img"));
	                    jhref = driver.findElement(
	                    By.xpath("//*[@id=\"__next\"]/div/main/div[1]/div[2]/ul/li[" + i + "]/a"));
	                 } catch (NoSuchElementException e) {
	                    // Element not found, skip this iteration
	                    continue;
	                 }
	                 jvo.setPrice(jPrice.getText());
	                 jvo.setContent(jhref.getText());
	                 jvo.setImageSrc(jImageSrc.getAttribute("src"));
	                 jvo.setHref(jhref.getAttribute("href"));

	                 System.out.println("=====중고나라 입니다====");
	                 System.out.println(jPrice.getText());
	                 System.out.println(jhref.getText());
	                 System.out.println(jImageSrc.getAttribute("src"));
	                 System.out.println(jhref.getAttribute("href"));

	                 list.add(jvo);
	              }

	           }

	        } catch (Exception e) {

	           e.printStackTrace();

	        } finally {

	        }

	        return list;

	     }
   public static void closeSharedDriver() {
      if (driver != null) {
         driver.close();
         driver.quit();
      }
   }

  }