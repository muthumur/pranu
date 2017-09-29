package com.intellion.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.intellion.business.UserBO;
import com.intellion.vo.UserVO;

/**
 * Servlet implementation class UserController
 */
//@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("UserController POST...");
		
		HttpSession session = request.getSession(false);
		
		String operation = request.getParameter("operation");
		System.out.println(operation);
		
		
		UserVO userVO = null;
		UserBO userBO = null;
		int requestResult = 0;
		boolean isUpdated = false;
		
		if(null != operation && ("ADD").equalsIgnoreCase(operation)){
			
			String userName = request.getParameter("username");
			String userEmail = request.getParameter("email");
			String userpassword = request.getParameter("password");
			String userMobile = request.getParameter("mob");
			
			
			
			
			System.out.println(userName);
			System.out.println(userEmail);
			System.out.println(userpassword);
			System.out.println(userMobile);
			
			

			if(null != userName && null != userEmail && null != userpassword){
				
				userVO = new UserVO();
				userBO = new UserBO();
				
				
				userVO.setUserName(userName);
				userVO.setUserEmail(userEmail);
				userVO.setUserPassword(userpassword);
				userVO.setUserMobile(userMobile);
				userVO.setIsactive("Y");
				
				requestResult = userBO.addUser(userVO);
				
				if(requestResult == 1){
					
					System.out.println("requestResult..:"+requestResult);
					session.setAttribute("registerResult", "success");
					response.sendRedirect("/OEP/jsp/login.jsp");
					
				}
				
								
				
				
			}
				
			
			
		}else if(null != operation && ("UPD").equalsIgnoreCase(operation)){
			String userName = request.getParameter("username");
			String userEmail = request.getParameter("email");
			String userpassword = request.getParameter("password");
			String userMobile = request.getParameter("mobile");
			
			
			
			
			System.out.println(userName);
			System.out.println(userEmail);
			System.out.println(userpassword);
			System.out.println(userMobile);
			
            if(null != userName && null != userEmail && null != userpassword){
				
				userVO = new UserVO();
				userBO = new UserBO();
				
				
				userVO.setUserName(userName);
				userVO.setUserEmail(userEmail);
				userVO.setUserPassword(userpassword);
				userVO.setUserMobile(userMobile);
				
				
				isUpdated = userBO.updUserDetailsByName(userVO);
				
				if(isUpdated){
					System.out.println("success");
					
					session.setAttribute("userProfile", userVO); 
					session.setAttribute("result", "updated");
					response.sendRedirect("/OEP/jsp/profile.jsp");
					
					
				}
				
								
				
				
			}
				
			
		}
		}
		
	}


