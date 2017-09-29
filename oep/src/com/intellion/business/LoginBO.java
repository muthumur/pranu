package com.intellion.business;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import com.intellion.vo.LoginVO;


import com.intellion.util.DBManager;

public class LoginBO {
	
	
	public static boolean validateLogin(String username,String password){ 
		System.out.println("validateLogin called");
		
		
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;

			boolean var = false;

		try{
			
			con = DBManager.getDBConnection();

			st = con.createStatement();

			String sqlQuery = "select * from USER_MASTER where user_name='"+username+"' and user_pwd='"+password+"'";

			System.out.println(sqlQuery);

			rs = st.executeQuery(sqlQuery);
		
	           
	           while(rs.next()){
	        	   
	        	 
	        	   LoginVO loginvo = new LoginVO();
	        	   String user=rs.getString("user_name");
	        	   String pass = rs.getString("user_pwd");
	        	   
	        	   loginvo.setUsername(user);
	        	   loginvo.setPassword(pass);
	        	   
	        	   if(username.equalsIgnoreCase(user) && password.equalsIgnoreCase(pass)){
	        		   System.out.println("Welcome"+username);
	        		   var=true;
	        		   
	        		   
	                  
	               }
	        	   
	        	   else{
	        		   System.out.println("Invalid Login");
	        	   var=false;
	        	   }
	        	   
	        
	           }
	           
		}
	           
	           catch(Exception e){
	   		    System.out.println(e);
	   		}	    
		
		return var;
	           
	   	      }	


	
}
