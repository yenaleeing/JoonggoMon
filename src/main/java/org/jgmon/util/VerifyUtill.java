package org.jgmon.util;

import java.net.SocketException;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.Select;



public class VerifyUtill {
    public static String verifyData(String selectdata, String inputdata) {
        // WebDriver 설정
        System.setProperty("webdriver.chrome.driver", "C:\\sts-bundle\\chromedriver\\chromedriver.exe");
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--disable-popup-blocking");
        options.addArguments("headless");
        options.addArguments("--disable-gpu");
        options.addArguments("--blink-settings=imagesEnabled=false");
        ChromeDriver driver = new ChromeDriver(options);
        driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS);

        try {
            // 외부 폼 페이지로로 이동
            driver.get("https://www.cyber.go.kr/widget.html");

            // 옵션 선택
            Select select = new Select(driver.findElement(By.name("field")));
            select.selectByValue(selectdata);

            // 텍스트 입력
            WebElement inputElement = driver.findElement(By.name("keyword"));
            inputElement.sendKeys(inputdata);

            // 검색 버튼 클릭
            WebElement searchButton = driver.findElement(By.id("getXmlSearch"));
            searchButton.click();

            // 결과 가져오기
            WebElement resultElement = driver.findElement(By.id("search_result"));

            long waitTimeInMillis = 200;
            Thread.sleep(waitTimeInMillis);
            String resultText = resultElement.getText();
            System.out.println(resultText);
            return "결과: " + resultText;
            

        } catch (Exception e) {
            return "오류 발생: " + e.getMessage();
        } finally {
            // WebDriver 종료

            driver.quit();
        }
    }
}