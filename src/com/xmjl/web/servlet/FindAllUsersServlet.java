package com.xmjl.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xmjl.domain.User;
import com.xmjl.service.UserService;
import com.xmjl.service.impl.UserServiceImpl;

public class FindAllUsersServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		UserService us = new UserServiceImpl();
		List<User> users = us.findAllUsers();
		/*request.setAttribute("students", students);
		request.getRequestDispatcher("/index.jsp").forward(request, response);*/
		request.getSession().setAttribute("users", users);
		response.sendRedirect(request.getContextPath()+"/index.jsp");
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
