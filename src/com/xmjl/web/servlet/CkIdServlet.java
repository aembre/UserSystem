package com.xmjl.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xmjl.domain.Student;
import com.xmjl.service.UserService;
import com.xmjl.service.impl.UserServiceImpl;

public class CkIdServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		String id = request.getParameter("id");
		UserService us = new UserServiceImpl();
		Student student = us.findStudentById(id);
		if(student==null){
			out.print(false);
		}else {
			out.print(true);
		}
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
