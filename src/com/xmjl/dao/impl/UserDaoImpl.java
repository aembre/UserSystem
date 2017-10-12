package com.xmjl.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.xmjl.dao.UserDao;
import com.xmjl.domain.User;
import com.xmjl.util.C3P0Util;


public class UserDaoImpl implements UserDao {
	
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	private List<User> userLi = new ArrayList<User>();
	@Override
	public User login(String loginName, String loginPwd) {
		try {
			conn = C3P0Util.getConnection();
			ps = conn.prepareStatement("select * from s_user where loginName=? and loginPwd=?");
			ps.setString(1, loginName);
			ps.setString(2, loginPwd);
			
			rs = ps.executeQuery();
			if(rs.next()){
				User u = new User();
				u.setUserName(rs.getString("userName"));
				return u;
			}
			return null;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally{
			C3P0Util.release(rs, ps, conn);
		}
	}

	@Override
	public List<User> selectAllUsers() {
		try {
			conn = C3P0Util.getConnection();
			ps = conn.prepareStatement("select * from s_user");
			rs = ps.executeQuery();
			if(rs.next()){
				User u = new User();
				u.setBirthday(rs.getDate("Birthday"));
				u.setEducation(rs.getString("education"));
				u.setFilename(rs.getString("filename"));
				u.setInterest(rs.getString("interest"));
				u.setLoginName(rs.getString("loginName"));
				u.setLoginPwd(rs.getString("loginPwd"));
				u.setPath(rs.getString("path"));
				u.setRemark(rs.getString("remark"));
				u.setSex(rs.getString("sex"));
				u.setTelephone(rs.getString("telephone"));
				u.setUserID(rs.getInt("userID"));
				u.setUserName(rs.getString("userName"));
				userLi.add(u);
			}
			return userLi;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

}
