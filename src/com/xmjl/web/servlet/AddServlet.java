package com.xmjl.web.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.xmjl.domain.User;
import com.xmjl.service.UserService;
import com.xmjl.service.impl.UserServiceImpl;

public class AddServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		
		String userName = request.getParameter("userName");
		String sex = request.getParameter("sex");
		String birthday = request.getParameter("birthday");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try {
			date = sdf.parse(birthday);
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		String education = request.getParameter("education");
		String interest = request.getParameter("interest");
		User user = new User();
		try {
			user.setUserName(userName);
			user.setBirthday(date);
			user.setSex(sex);
			user.setEducation(education);
			user.setInterest(interest);
			UserService us = new UserServiceImpl();
			us.addUser(user);
		} catch(Exception e) {
			e.printStackTrace();
			//request.getRequestDispatcher("/index.jsp").forward(request, response);
		}
		request.getRequestDispatcher("/servlet/findAllUsersServlet").forward(request, response);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
