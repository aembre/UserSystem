package com.xmjl.web.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xmjl.domain.PageBean;
import com.xmjl.domain.User;
import com.xmjl.service.UserService;
import com.xmjl.service.impl.UserServiceImpl;

public class FindAllUsersServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		UserService us = new UserServiceImpl();
		List<User> users = us.findAllUsers();
		//获取当前是第几页
		String pageNumSt = request.getParameter("pageNum");
		int pageNum=1;
		if(null!=pageNumSt){
			pageNum = Integer.valueOf(pageNumSt);
		}
		//每页显示的记录数
		int pageSize = 8;
		PageBean<User> pb = us.findAllUserWithPage(pageNum, pageSize);
		
		request.getSession().setAttribute("pageBean", pb);
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		//request.getRequestDispatcher("/index.jsp").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
