package com.xmjl.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class C3P0Util {
	//得到一个数据源
	private static DataSource dataSource = new ComboPooledDataSource();
	
	public static DataSource getDataSource() {
		return dataSource;
	}

	//从数据源中得到一个连接对象
	public static Connection getConnection(){
		try {
			return dataSource.getConnection();
		} catch (SQLException e) {
			throw new RuntimeException("服务器错误");
		}
	}
	
	public static void release(ResultSet rs,Statement ps,Connection conn){
		//关闭资源
				if(rs!=null){
					try {
						rs.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
					rs = null;
				}
				if(ps!=null){
					try {
						ps.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
					ps = null;
				}
				if(conn!=null){
					try {
						conn.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
					conn = null;
				}
	}
	
}
