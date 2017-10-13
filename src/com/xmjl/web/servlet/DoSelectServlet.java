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
import com.xmjl.util.JsonUtil;

public class DoSelectServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		
		String userName = request.getParameter("userName");
		//获取当前是第几页
		String pageNumSt = request.getParameter("pageNum");
		int pageNum=1;
		if(null!=pageNumSt){
			pageNum = Integer.valueOf(pageNumSt);
		}
		//每页显示的记录数
		int pageSize = 10;
		//调用service层方法，进行处理
		UserService us = new UserServiceImpl();
		//获取一个pageBean对象，里面包括分页所需的所有数据
		PageBean<User> pb = us.findAllUserWithPage(pageNum, pageSize, userName);
		//将pb放入request域中
		request.setAttribute("pageBean", pb);
		request.setAttribute("list", JsonUtil.list2json(pb.getList()));
		request.setAttribute("userName", userName);
		request.getRequestDispatcher("/doSelect.jsp").forward(request, response);
		/*List<User> users = us.findByUsername(userName);
		if(users==null || users.size()==0){
			response.getWriter().print(false);
		}else{
			response.getWriter().print(JsonUtil.list2json(users));
//			System.out.println(JsonUtil.list2json(users));
		}*/
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
