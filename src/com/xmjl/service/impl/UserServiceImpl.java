package com.xmjl.service.impl;

import java.util.List;

import com.xmjl.dao.UserDao;
import com.xmjl.dao.impl.UserDaoImpl;
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
	
}
