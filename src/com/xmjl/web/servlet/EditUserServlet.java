package com.xmjl.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xmjl.domain.User;
import com.xmjl.service.UserService;
import com.xmjl.service.impl.UserServiceImpl;

public class EditUserServlet extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		
		String userID = request.getParameter("userID");
		String userName = request.getParameter("userName");
		String sex = request.getParameter("sex");
		String birthday = request.getParameter("birthday");
		String education = request.getParameter("education");
		String interest = request.getParameter("interest");
		
		User user = new User();
		user.setUserID(Integer.parseInt(userID));
		user.setUserName(userName);
		user.setSex(sex);
		user.setEducation(education);
		user.setInterest(interest);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date date = sdf.parse(birthday);
			user.setBirthday(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		UserService service = new UserServiceImpl();
		service.editUser(user);
		request.getRequestDispatcher("/servlet/findAllUsersServlet").forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
