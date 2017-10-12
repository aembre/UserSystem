package com.xmjl.web.servlet;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.xmjl.domain.Student;
import com.xmjl.service.UserService;
import com.xmjl.service.impl.UserServiceImpl;

public class ChangeServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		Student st = new Student();
		try {
			BeanUtils.populate(st, request.getParameterMap());
			UserService us = new UserServiceImpl();
			us.editUser(st);
		} catch (Exception e) {
			e.printStackTrace();
		}
		//response.getWriter().write("修改成功！1秒后跳转到主页");
		response.setHeader("refresh", "0.1;url="+request.getContextPath()+"/servlet/findAllUsersServlet");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
