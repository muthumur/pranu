package com.intellion.business;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.intellion.util.DBManager;
import com.intellion.util.StringUtilCustom;
import com.intellion.vo.ExamVO;
import com.intellion.vo.QuestionVO;
import com.intellion.vo.UserVO;

public class UserBO {

		public int addUser(UserVO userVO) {
			
			System.out.println("addUser called...:");
			int result = -1; 
			Connection con = null;
			Statement st = null;
			
			try {

				String userName = StringUtilCustom.NullToEmptyString(userVO.getUserName());
				String userPassword = StringUtilCustom.NullToEmptyString(userVO.getUserPassword());
				String userEmail = StringUtilCustom.NullToEmptyString(userVO.getUserEmail());
				String userMobile = StringUtilCustom.NullToEmptyString(userVO.getUserMobile());
				String userRole = "STUDENT";
				String isactive = StringUtilCustom.NullToEmptyString(userVO.getIsactive());
				
				
				System.out.println(userName);
				System.out.println(userEmail);
				System.out.println(userPassword);
				System.out.println(userMobile);
				System.out.println(userRole);
				
				
				
				con = DBManager.getDBConnection();

				st = con.createStatement();
				
				

				String sqlQuery = "INSERT INTO USER_MASTER (user_name,user_pwd,user_email,user_mob,user_role,is_active)"
						+ " VALUES ('" + userName + "','"
						+ userPassword + "','"
						+ userEmail + "','"
						+ userMobile + "','"
						+ userRole + "','"
						+ isactive +"')";

				
				System.out.println(sqlQuery);

				result = st.executeUpdate(sqlQuery);

				System.out.println(result);

			} catch (Exception e) {
				System.out.println(e);
			}finally{
				try {
					st.close();
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}

			return result;
		
		
		}
		public boolean updUserDetailsByName(UserVO userVO) {
			
			System.out.println("updUserDetailsByName called...:");
			int result = -1; 
			Connection con = null;
			Statement st = null;
			boolean isUpdatedStatus = false; 
			
			try {

				String username = StringUtilCustom.NullToEmptyString(userVO.getUserName());
				String userPassword = StringUtilCustom.NullToEmptyString(userVO.getUserPassword());
				String userEmail = StringUtilCustom.NullToEmptyString(userVO.getUserEmail());
				String userMobile = StringUtilCustom.NullToEmptyString(userVO.getUserMobile());
				
				System.out.println(username);
				System.out.println(userPassword);
				System.out.println(userEmail);
				System.out.println(userMobile);
				
				
				con = DBManager.getDBConnection();

				st = con.createStatement();
				String sqlQuery = "UPDATE USER_MASTER SET "
					
						+ "user_pwd='" +userPassword+"',"
						+ "user_email='" +userEmail
						+"', user_mob='"+userMobile
						+ "' where user_name='"+username+"'";			
				

				
				
				System.out.println(sqlQuery);


				boolean isUpdated = st.execute(sqlQuery);
				if(!isUpdated){
					int updateCount = st.getUpdateCount();
					if(updateCount > 0){
						isUpdatedStatus = true;
					}
					
				}
				
				
			} catch (Exception e) {
				System.out.println(e);
			}finally{
				try {
					st.close();
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}

			return isUpdatedStatus;
		
		
		}	
		public UserVO getUserDetailsByName(String username) {
			System.out.println("getUserDetailsByName called");
			
			UserVO userVO = null;
			
			Connection con = null;
			Statement st = null;
			ResultSet rs = null;

			try {

			
				con = DBManager.getDBConnection();

				st = con.createStatement();

				String sqlQuery = "SELECT user_name , user_pwd , user_email , user_mob ,user_role from USER_MASTER where user_name='"+username+"'" ;

				System.out.println(sqlQuery);

				rs = st.executeQuery(sqlQuery);
				
				while(rs.next()){
					
					userVO = new UserVO();
					String userName = (String)rs.getString("user_name");
					String userPassword = (String)rs.getString("user_pwd");
					String userEmail = (String)rs.getString("user_email");
					String userMobile = (String)rs.getString("user_mob");
					String userRole = (String)rs.getString("user_role");
					
					userVO.setUserName(userName);
					userVO.setUserPassword(userPassword);
					userVO.setUserEmail(userEmail);
					userVO.setUserMobile(userMobile);
					userVO.setUserRole(userRole);
				}

				

			} catch (Exception e) {
				System.out.println(e);
			}finally{
				try {
					rs.close();
					st.close();
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}

			return userVO;
		}	

		

	
}
