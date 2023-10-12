package org.jgmon.service;

import java.io.File;
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.jgmon.admin.domain.NoticeBoardVO;
import org.jgmon.domain.MemberVO;
import org.jgmon.persistence.MemberDAO;
import org.jgmon.util.FileUtil;
import org.jgmon.util.PagingUtil;
import org.jgmon.util.TempKey;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO memberDao;

	@Autowired
	private JavaMailSender mailSender;

	// 비밀번호 암호화를 위해 SpringSecurity 를 사용하여 불러옴
	@Inject
	PasswordEncoder passwordEncoder;

	@Override
	public Map<String, String> login(MemberVO member, HttpSession session) throws Exception {
		String user_id = null;
		String AuthKey = null;
		Map<String, String> key = new HashMap<String,String>();
		// 로그인 sql 구문 불러와서 확인후 결과값 반환
		String u_pwd = memberDao.getPwd(member);
		if (passwordEncoder.matches(member.getU_pwd(), u_pwd)) {
			user_id = memberDao.login(member);
			AuthKey = memberDao.getStatus(member);
			if (user_id != null && AuthKey.equals("1")) {
				session.setAttribute("user_id", user_id);
			}
		}
		key.put("user_id",user_id);
		key.put("AuthKey", AuthKey);
		
		
		return key;
	}

	@Override
	public void logout(HttpSession session) throws Exception {
		session.invalidate(); // 세션 초기화
	}

	@Override
	public int regist(MemberVO member) throws Exception {
		// TODO Auto-generated method stub

		String newName = ""; // 업로드한 파일의 변경된 이름
		int result = 0;

		// 업로드 되어있다면
		if (!member.getUpload().isEmpty()) {
			// 탐색기 -> aaa.txt-> getOriginalFileName()
			newName = FileUtil.rename(member.getUpload().getOriginalFilename());
			System.out.println("newName => " + newName);
			member.setU_PICTURE(newName);// 수동변경 -> 수동저장
		} else {
			member.setU_PICTURE("/joonggomon.jpg");
		}

		// 랜덤 이메일인증 함수 생성
		String tmpkey = new TempKey().getKey(50, false);
		member.setAUTHPATH(tmpkey);

		// 비밀번호 암호화 후 다시 저장
		String encPassword = passwordEncoder.encode(member.getU_pwd());
		member.setU_pwd(encPassword);

		// 성공시 파일 업로드 및 전송
		if (memberDao.create(member) == 1) {

			// 업로드
			if (!member.getUpload().isEmpty()) {
				File file = new File(FileUtil.UPLOAD_PATH + "profilePic/" + newName);
				// 물리적으로 데이터 전송
				member.getUpload().transferTo(file); // 파일업로드 전송
			}

			/*** 여기서 부턴 이메일 보낼떄 나오는 형식 관련 코드들입니다 . ****/
			MimeMessage mimeMessage = mailSender.createMimeMessage();

			MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

			// test용 메일 내용
			messageHelper.setFrom("joongomon@gmail.com"); // 보내는사람 이메일 여기선 google 메일서버 사용하는 아이디를 작성하면됨
			messageHelper.setTo(member.getEmail()); // 받는사람 이메일
			messageHelper.setSubject("인증번호는" + tmpkey + "입니다."); // 메일제목
			messageHelper.setText("전송"); // 메일 내용
			messageHelper.setText("text/html",
					"<div style='border: 3px solid blue'><a href='https://www.naver.com/'></a></div>");
			messageHelper.setText("<h1>메일인증</h1>" + "<br/>" + member.getU_nickname() + "님 "
					+ "<br/>ICEWATER에 회원가입해주셔서 감사합니다." + "<br/>아래 [이메일 인증 확인]을 눌러주세요."
					+ "<a href='http://localhost:8090/member/registerEmail?memberEmail=" + member.getEmail() + "&key=" + tmpkey
					+ "' target='_blenk'>이메일 인증 확인</a>");
			mailSender.send(mimeMessage);

			/*** 모든 양식 작성후 send method 를 통해 입력된 이메일로 이메일 전송 ******/
			result = 1;
		} else {
			result = 0;
		}

		return result;
	}

	@Override
	public int update(MemberVO vo) throws Exception {

		String oldFileName = ""; // 변경전 파일이름
		MemberVO originalVO = memberDao.read(vo.getUser_id());
		oldFileName = originalVO.getU_PICTURE();

		// 업로드 되어있다면
		if (!vo.getUpload().isEmpty()) {
			// 탐색기 -> aaa.txt-> getOriginalFileName()

			try {
				vo.setU_PICTURE(FileUtil.rename(vo.getUpload().getOriginalFilename()));
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			vo.setU_PICTURE(oldFileName); // 수동변경 -> 수동저장

		}
		int result = memberDao.update(vo);

		// 업로드
		if (!vo.getUpload().isEmpty()) {
			try {
				File file = new File(FileUtil.UPLOAD_PATH + "profilePic/" + vo.getU_PICTURE());
				// 물리적으로 데이터 전송
				vo.getUpload().transferTo(file); // 파일업로드 전송
			} catch (IOException e) {
				e.printStackTrace();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			// 기존파일은 삭제하는 구문이 필요
			if (oldFileName != null) {
				FileUtil.removeFile(oldFileName);
			}
		}

		return result;
	}

	// 이메일 인증 요청하는 구문입니다.
	@Override
	public int emailVerify(String memberEmail, String key) throws Exception {
		// TODO Auto-generated method stub
		return memberDao.emailVerification(memberEmail, key);
	}

	@Override
	public MemberVO read(String user_id) throws Exception {

		return memberDao.read(user_id);
	}

	@Override
	public int emChk(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		int result = memberDao.emChk(vo);
		System.out.println(result);
		System.out.println("email체크용=>"+vo.getEmail());
		return result;
		
	}

	// 아이디 중복체크하는 구문입니다.
	@Override
	public int idChk(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(vo.getUser_id());
		return memberDao.idChk(vo);
	}

	@Override
	public void modify(MemberVO vo) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
    public void memRemove(MemberVO vo) throws Exception {
        memberDao.memRemove(vo);
    }

	@Override
	public Map<String,Object> listAll(int currentPage,String keyWord) throws Exception {
Map<String,Object> pagingMap = new HashMap<String, Object>();
		
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("keyWord", keyWord); //검색어
		
		int count = memberDao.countMember(map);
		//검색분야 , 검색어  -> parameterType = " map " (Map객체)

		// 4.블럭당 페이지 수 ( 10 ) 5.요청명령어 지정 
		PagingUtil page = new PagingUtil(currentPage, count, 10, 5, "/admin/memberBoard");
		//start = > 페이지당 맨 첫번째 나오는 게시물 번호
		//end = > 마지막 게시물 번호
		map.put("start", page.getStartCount());
		//<-> map.get("start") => #{start}
		map.put("end", page.getEndCount());
		
		List<MemberVO> list = null; 
		if(count > 0 ) {
			list = memberDao.listAll(map); // keyWord,start,end 
		}else {
			list = Collections.EMPTY_LIST; // 0 적용 
		}
		
		pagingMap.put("list", list);
		pagingMap.put("count",count);
		pagingMap.put("pagingHtml",page.getPagingHtml());
				
		return pagingMap;
	}

	// 비밀번호 초기화시 불러오는 구문입니다.
	@Override
	public int resetPassword(String email) throws Exception {
		// TODO Auto-generated method stub
		// 랜덤 비밀번호 생성
		String resetpassword = new TempKey().getKey(10, false);
		
		String encPassword = passwordEncoder.encode(resetpassword);
		
		// 이메일에 맞는 랜덤비밀번호를 작성후 전송합니다.
		int result = memberDao.resetPassword(email, encPassword);
		// 적용 성공했을시
		if (result == 1) {

			/**** 똑같이 이메일 양식 작성하고 보내는 코드들입니다. *****/
			MimeMessage mimeMessage = mailSender.createMimeMessage();
			// MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true,
			// "UTF-8");
			MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

			// test용 메일 내용
			messageHelper.setFrom("joongomon@gmail.com"); // 보내는사람 이메일 여기선 google 메일서버 사용하는 아이디를 작성하면됨
			messageHelper.setTo(email); // 받는사람 이메일
			messageHelper.setSubject("새로운 비밀번호 는" + resetpassword + "입니다."); // 메일제목
			messageHelper.setText("전송"); // 메일 내용
			messageHelper.setText("text/html",
					"<div style='border: 3px solid blue'><a href='https://www.naver.com/'></a></div>");

			mailSender.send(mimeMessage);
		} else {
			result = 0;
		}
		return result;
	}

	@Override
	public int checkPassword(MemberVO vo, String prePassword) throws Exception {
		int result = 0;

		if (passwordEncoder.matches(prePassword,vo.getU_pwd())) {
			result = 1;
		}

		
	 
		return result;
	}

	@Override
	public int changePassword(MemberVO vo, String newPassword) throws Exception {
		// TODO Auto-generated method stub
		// 비밀번호 암호화 후 다시 저장
		String encPassword = passwordEncoder.encode(newPassword);
		String user_id = vo.getUser_id();
		int result = memberDao.changePassword(user_id, encPassword);

		return result;
	}

}
