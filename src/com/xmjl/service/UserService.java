package com.xmjl.service;

import java.util.List;

import com.xmjl.domain.User;


public interface UserService {
	User login(String loginName, String loginPwd);

	List<User> findAllUsers();
}
