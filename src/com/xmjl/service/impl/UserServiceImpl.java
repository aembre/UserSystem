package com.xmjl.service.impl;

import java.util.List;

import com.xmjl.dao.UserDao;
import com.xmjl.dao.impl.UserDaoImpl;
import com.xmjl.domain.PageBean;
import com.xmjl.domain.User;
import com.xmjl.service.UserService;

public class UserServiceImpl implements UserService {
	private UserDao dao = new UserDaoImpl();
	@Override
	public User login(String loginName, String loginPwd) {
		return dao.login(loginName, loginPwd);
	}
	@Override
	public List<User> findAllUsers() {
		return dao.selectAllUsers();
	}
	@Override
	public List<User> findByUsername(String userName) {
		return dao.findUsersByName(userName);
	}
	@Override
	public PageBean<User> findAllUserWithPage(int pageNum, int pageSize) {
		List<User> users = dao.selectAllUsers();
		int totalRecord = users.size();
		
		PageBean<User> pb = new PageBean<User>(pageNum, pageSize, totalRecord);
		int startIndex = pb.getStartIndex();
		//有了startIndex和pageSize，就可得到每页的数据
		pb.setList(dao.findAll(startIndex,pageSize));
		return pb;
	}
	@Override
	public PageBean<User> findAllUserWithPage(int pageNum, int pageSize,
			String userName) {
		int totalRecord = dao.countByName(userName);
		PageBean<User> pb = new PageBean<User>(pageNum, pageSize, totalRecord);
		int startIndex = pb.getStartIndex();
		//有了startIndex和pageSize，就可得到每页的数据
		pb.setList(dao.findAll(startIndex,pageSize,userName));
		return pb;
	}
	@Override
	public User findUserByID(int userID) {
		return dao.selectUserByID(userID);
	}
	@Override
	public void editUser(User user) {
		dao.updateUser(user);
	}
	@Override
	public void deleteUserByID(String id) {
		dao.deleteUserByID(id);
	}
	@Override
	public void addUser(User user) {
		dao.addUser(user);
	}
	
}
