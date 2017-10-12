package com.xmjl.web.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xmjl.service.UserService;
import com.xmjl.service.impl.UserServiceImpl;

public class DeleteServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		String id = request.getParameter("id");
		UserService us = new UserServiceImpl();
		us.deleteUser(id);
		response.getWriter().write("删除成功！1秒后跳转主页");
		response.setHeader("refresh", "1;url="+request.getContextPath()+"/servlet/findAllUsersServlet");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
