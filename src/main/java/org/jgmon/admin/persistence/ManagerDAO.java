package org.jgmon.admin.persistence;

import org.jgmon.admin.domain.ManagerVO;
import org.springframework.stereotype.Repository;


public interface ManagerDAO {
	public String managerChk(ManagerVO manager);
}
