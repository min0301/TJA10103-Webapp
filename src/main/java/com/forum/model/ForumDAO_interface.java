package com.forum.model;

import java.util.List;

import com.emp.model.EmpVO;

public interface ForumDAO_interface {
	
	public void insert (ForumVO forumvo);
	public void update (ForumVO forumvo);
	public void delete (Integer forNo);
    public ForumVO findByPrimaryKey(Integer forNo);
    public List<ForumVO> getAll();
	

}
