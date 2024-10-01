package com.tlink.project.work.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.user.model.dto.User;
import com.tlink.project.work.model.dto.Work;

@Repository
public class WorkDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public void test() {
		sqlSession.insert("workMapper.test");
	}

	public List<Work> table(int projectNo) {
		return sqlSession.selectList("workMapper.table",projectNo);
	}

	public List<User> tableManagerList(int projectNo) {
		return sqlSession.selectList("workMapper.tableManagerList",projectNo);
	}

	public List<Work> tableParentList(int projectNo) {
		return sqlSession.selectList("workMapper.tableParentList",projectNo);
	}

	public Work workSheet(int workNo, int projectNo) {
		Map<String, Object> data= new HashMap<>();
		data.put("workNo", workNo);
		data.put("projectNo", projectNo);
		
		return sqlSession.selectOne("workMapper.workSheet", data);
	}

	public List<Work> mywork(int projectNo, int userNo) {
		Map<String, Object> data= new HashMap<>();
		data.put("userNo", userNo);
		data.put("projectNo", projectNo);
		return sqlSession.selectList("workMapper.mywork",data);
	}
}
