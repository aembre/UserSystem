package com.xmjl.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.xmjl.domain.User;

public class FilterJsp implements Filter{

	@Override
	public void destroy() {
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession session = req.getSession();
		User user = (User) session.getAttribute("user");
		if(null!=user){
			chain.doFilter(request, response);
		}else {
			//request.getRequestDispatcher("/index.jsp").forward(request, response);
			res.sendRedirect(req.getContextPath()+"/login.html");
		}
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		
	}

}
