package org.jgmon.admin.service;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.jgmon.admin.domain.ManagerVO;
import org.jgmon.admin.persistence.ManagerDAO;
import org.springframework.stereotype.Service;

@Service
public class ManagerServiceImpl implements ManagerService {

	@Inject
	ManagerDAO managerDAO;
	
	@Override
	public String ManagerCheck(ManagerVO manager,HttpSession session) {
		// TODO Auto-generated method stub
		String nickname = managerDAO.managerChk(manager);
		if(nickname != null) {
			session.setAttribute("managerid", manager.getManager_id());
			session.setAttribute("nickname",manager.getM_nickname());
		}
		return nickname;
	}

	@Override
	public void logout(HttpSession session) {
	 session.invalidate(); // 세션 초기화
	 }
}
