package com.xmjl.dao.impl;

import java.sql.Connection;
import java.sql.Date;
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
	private List<User> userLi = null;
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
			userLi = new ArrayList<User>();
			while(rs.next()){
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
		}finally{
			C3P0Util.release(rs, ps, conn);
		}
	}

	@Override
	public List<User> findUsersByName(String userName) {
		try {
			conn = C3P0Util.getConnection();
			ps = conn.prepareStatement("select * from s_user where userName like ?");
			
			ps.setString(1, "%"+userName+"%");
			rs = ps.executeQuery();
			userLi = new ArrayList<User>();
			while(rs.next()){
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
		} finally{
			C3P0Util.release(rs, ps, conn);
		}
	}

	@Override
	public List<User> findAll(int startIndex, int pageSize,String userName) {
		try {
			conn = C3P0Util.getConnection();
			ps = conn.prepareStatement("select * from s_user where userName like ? limit ?,?");
			ps.setString(1, "%"+userName+"%");
			ps.setInt(2, startIndex);
			ps.setInt(3, pageSize);
			rs = ps.executeQuery();
			userLi = new ArrayList<User>();
			while(rs.next()){
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
	@Override
	public List<User> findAll(int startIndex, int pageSize) {
		try {
			conn = C3P0Util.getConnection();
			ps = conn.prepareStatement("select * from s_user limit ?,?");
			ps.setInt(1, startIndex);
			ps.setInt(2, pageSize);
			rs = ps.executeQuery();
			userLi = new ArrayList<User>();
			while(rs.next()){
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
		} finally{
			C3P0Util.release(rs, ps, conn);
		}
	}

	@Override
	public Integer countByName(String userName) {
		int count = 0;
		try {
			conn = C3P0Util.getConnection();
			ps = conn.prepareStatement("select count(1) from s_user where userName like ?");
			ps.setString(1, "%"+userName+"%");
			rs = ps.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);
			}
			return count;
		} catch (SQLException e) {
			e.printStackTrace();
			return 0;
		} finally{
			C3P0Util.release(rs, ps, conn);
		}
	}
	/**
	 * 根据userID查找
	 */
	@Override
	public User selectUserByID(int userID) {
		try {
			conn = C3P0Util.getConnection();
			ps = conn.prepareStatement("select * from s_user where userID=?");
			ps.setInt(1, userID);
			rs = ps.executeQuery();
			User u=null;
			if(rs.next()){
				u = new User();
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
			}
			return u;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		} finally{
			C3P0Util.release(rs, ps, conn);
		}
	}
	/**
	 * 更新用户
	 */
	@Override
	public void updateUser(User user) {
		try {
			conn = C3P0Util.getConnection();
			ps = conn.prepareStatement("update s_user set userName=?,sex=?,education=?,interest=?,birthday=?  where userId=?");
			ps.setString(1, user.getUserName());
			ps.setString(2, user.getSex());
			ps.setString(3, user.getEducation());
			ps.setString(4, user.getInterest());
			Date date = new Date(user.getBirthday().getTime());
			ps.setDate(5, date);
			ps.setInt(6, user.getUserID());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			C3P0Util.release(rs, ps, conn);
		}
	}

	/**
	 * 根据userID删除用户
	 */
	@Override
	public void deleteUserByID(String id) {
		try {
			conn = C3P0Util.getConnection();
			ps = conn.prepareStatement("delete from s_user where userId=?");
			ps.setString(1, id);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			C3P0Util.release(rs, ps, conn);
		}
	}

	@Override
	public void addUser(User user) {
		try {
			conn = C3P0Util.getConnection();
			ps = conn.prepareStatement("insert into s_user (userName,sex,birthday,education,interest) values(?,?,?,?,?)");
			ps.setString(1, user.getUserName());
			ps.setString(2, user.getSex());
			Date date = new Date(user.getBirthday().getTime());
			ps.setDate(3, date);
			ps.setString(4, user.getEducation());
			ps.setString(5, user.getInterest());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			C3P0Util.release(rs, ps, conn);
		}
	}

}
