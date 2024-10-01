package com.tlink.project.work.model.service;

import java.util.List;

import com.tlink.project.user.model.dto.User;
import com.tlink.project.work.model.dto.Work;

public interface WorkService {

	void test();

	List<Work> table(int projectNo);
	List<User> tableManagerList(int projectNo);
	List<Work> tableParentList(int projectNo);

	Work workSheet(int workNo, int projectNo);

	List<Work> mywork(int projectNo, int userNo);

}
