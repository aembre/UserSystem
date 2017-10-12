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

public class LoginServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		//获取表单数据
		String name = request.getParameter("loginName");
		String password = request.getParameter("loginPwd");
		//调用业务逻辑
		UserService us = new UserServiceImpl();
		User user = us.login(name,password);
		//分发转向
		if(null!=user){
			request.getSession().setAttribute("user", user);
			
			//设置cookie
			/*String remember = request.getParameter("remember");
			if("1".equals(remember)){
				Cookie nameCookie = new Cookie("name", name);
				nameCookie.setMaxAge(60 * 60 * 24 * 3);
				Cookie pwdCookie = new Cookie("password", password);
				pwdCookie.setMaxAge(60 * 60 * 24 * 3);
				response.addCookie(nameCookie);
				response.addCookie(pwdCookie);
			}*/
			
			List<User> users = us.findAllUsers();
			request.getSession().setAttribute("users", users);
			response.sendRedirect(request.getContextPath()+"/index.jsp");
		}else {
			response.getWriter().print(false);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
