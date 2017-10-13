package com.xmjl.service;

import java.util.List;

import com.xmjl.domain.PageBean;
import com.xmjl.domain.User;


public interface UserService {
	User login(String loginName, String loginPwd);

	List<User> findAllUsers();

	List<User> findByUsername(String userName);
	
	PageBean<User> findAllUserWithPage(int pageNum,int pageSize);
	PageBean<User> findAllUserWithPage(int pageNum,int pageSize,String userName);
}
