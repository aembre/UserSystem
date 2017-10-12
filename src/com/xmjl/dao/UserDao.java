package com.xmjl.dao;

import java.util.List;

import com.xmjl.domain.User;

public interface UserDao {
	public User login(String loginName, String loginPwd);

	public List<User> selectAllUsers();
}
