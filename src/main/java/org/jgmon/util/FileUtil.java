package org.jgmon.util;

import java.io.File;

public class FileUtil {
		//업로드 및 다운로드 경로 -> 정적 상수
		public static final String UPLOAD_PATH = "C:\\webtest\\4.jsp\\sou\\JoongoMonV3\\src\\main\\webapp\\";

		//1. 탐색기의 원본 파일명만 받아서 처리해주는 메서드 (ex test.txt)
		public static String rename(String filename) throws Exception{
			String newName = Long.toString(System.currentTimeMillis()+(int)(Math.random()*50));
			System.out.println("newName(난수)=>"+newName);
			return rename(filename,newName);
		}
		
		//2.실제로 새로운 파일명을 변경 
		//ex) testkiamaaaaaa.txt(뒤에서 검색)->1234aDSDDA.TXT
		public static String rename(String filename,String newName) throws Exception{
			if(filename==null) return null; 
			//확장자 구하기
			int idx=filename.lastIndexOf("."); //못찾으면 -1을 리턴
			String extention="";//확장자를 저장
			String newFileName ="";
			if(idx!=-1) {
				extention = filename.substring(idx); //.이후 확장자
				System.out.println("extention => " + extention);
			}
			int newIdx = newName.lastIndexOf("."); //확장자를 포함한 변경된 파일명 
			if(newIdx!=-1) {							//0
				newName = newName.substring(0,newIdx);
				System.out.println("newName(변경된 파일명) -> "  + newName);
			}
			newFileName = newName + extention.toLowerCase();
			return newFileName;
		}
		
		//3.글수정 -> 업로드된 파일로 수정 => 기존의 업로드된 파일 삭제
		//				새로 업로드  O 
		
		public static void removeFile(String filename) {
			File file = new File(UPLOAD_PATH,filename);
			if(file.exists()) file.delete(); //이경로에 파일존재 삭제하라 
		}
		
}

