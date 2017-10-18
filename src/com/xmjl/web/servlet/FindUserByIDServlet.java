package com.xmjl.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xmjl.domain.User;
import com.xmjl.service.UserService;
import com.xmjl.service.impl.UserServiceImpl;
import com.xmjl.util.JsonUtil;

public class FindUserByIDServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		String userIDSt = request.getParameter("userID");
		int userID = Integer.parseInt(userIDSt);
		UserService service = new UserServiceImpl();
		User user = service.findUserByID(userID);
		String userJson = JsonUtil.object2json(user);
		response.getWriter().print(userJson);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
