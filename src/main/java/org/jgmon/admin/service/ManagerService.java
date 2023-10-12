package org.jgmon.admin.service;

import javax.servlet.http.HttpSession;

import org.jgmon.admin.domain.ManagerVO;

public interface ManagerService {
	public String ManagerCheck(ManagerVO manager, HttpSession session);
	 public void logout(HttpSession session);
}
