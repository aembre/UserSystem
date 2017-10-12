package com.xmjl.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSourceFactory;

public class DBCPUtil {
	private static DataSource ds = null;
	static{
		Properties prop = new Properties();
		try {
			prop.load(DBCPUtil.class.getClassLoader().getResourceAsStream("dbcpconfig.properties"));//����DBCPUtil��classes��·�������������ļ�
		    ds = BasicDataSourceFactory.createDataSource(prop);//得到一个数据源 
		} catch (Exception e) {
			throw new ExceptionInInitializerError("初始化错误，请检查配置文件");
		}
	}
	
	public static Connection getConnection(){
		try {
			return ds.getConnection();
		} catch (SQLException e) {
			throw new RuntimeException("服务器忙。。。");
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
