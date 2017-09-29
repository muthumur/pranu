package com.intellion.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;



public class DBManager {
	
	public static Connection getDBConnection(){
		
		
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;
		StringBuffer sb = new StringBuffer();
		try {
			//System.out.println("testJndiDataSource");
			InitialContext ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/oep");

			
			conn = ds.getConnection();
			
			
			
		} catch (Exception ex) {
			ex.printStackTrace();
		} 		
		return conn;
	}
	
	
}
