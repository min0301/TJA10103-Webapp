package com.forum.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import util.HibernateUtil;

public class ForumHibernateDAO implements ForumDAO_interface {
	
	private SessionFactory factory;

	public ForumHibernateDAO() {
		factory = HibernateUtil.getSessionFactory();
	}
	

	private Session getSession() {
		return factory.getCurrentSession();
	}

	@Override
	public void insert(ForumVO entity) {
		getSession().persist(entity);
	}

	@Override
	public void update(ForumVO entity) {
		getSession().merge(entity);
	}

	@Override
	public void delete(Integer forNo) {
		ForumVO forumvo = getSession().get(ForumVO.class, forNo);
		if (forumvo != null) {
			getSession().remove(forumvo);
		}
		
	}

	@Override
	public ForumVO findByPrimaryKey(Integer forNo) {
		return getSession().find(ForumVO.class, forNo);
	}

	@Override
	public List<ForumVO> getAll() {
		return getSession().createQuery("from ForumVO", ForumVO.class).getResultList();
	}
	
	

}
