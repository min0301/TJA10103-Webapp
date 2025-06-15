package com.forum.model;

import java.sql.Date;
import java.util.List;

public class ForumService {
	
	private ForumDAO_interface dao;
	
	public ForumService() {
		dao = new ForumJDBCDAO();
	}

	public ForumVO addForum(String forName, Integer catNo, String forDes) {
		ForumVO forumVO = new ForumVO();
		forumVO.setForName(forName);
		forumVO.setCatNo(catNo);
		forumVO.setForDes(forDes);
		dao.insert(forumVO);
		
		return forumVO;
		
	}
	
	public ForumVO updateForum(Integer forNo, String forName, Integer catNo, String forDes, Integer fchatStatus) {
		ForumVO forumVO = new ForumVO();
		forumVO.setForNo(forNo);
		forumVO.setForName(forName);
		forumVO.setCatNo(catNo);
		forumVO.setForDes(forDes);
		forumVO.setFchatStatus(fchatStatus);
		dao.update(forumVO);
		return forumVO;
	}
	
	public void deleteForum(Integer forNO) {
		dao.delete(forNO);
	}
	public ForumVO getOneForum(Integer forNO) {
		return dao.findByPrimaryKey(forNO);
	}

	public List<ForumVO> getAll() {
		return dao.getAll();
	}
	
	
}
