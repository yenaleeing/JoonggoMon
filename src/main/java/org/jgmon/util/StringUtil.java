package org.jgmon.util;

public class StringUtil {
	public static String parseBr(String msg){
		
		if(msg == null) return null;
		//여러줄 입력한 문자열의 엔터를 구분하는 메서드 
		return msg.replace("\r\n", "<br>")
                  .replace("\n", "<br>");
	}
}
