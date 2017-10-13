package com.xmjl.dao;

import java.util.List;

import com.xmjl.domain.User;

public interface UserDao {
	public User login(String loginName, String loginPwd);

	public List<User> selectAllUsers();

	public List<User> findUsersByName(String userName);

	public List<User> findAll(int startIndex, int pageSize, String userName);

	public Integer countByName(String userName);

	public List<User> findAll(int startIndex, int pageSize);
}
