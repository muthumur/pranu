package com.intellion.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.intellion.business.LoginBO;
import com.intellion.business.UserBO;
import com.intellion.vo.*;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		System.out.println("doGet login called");
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served mod at post: ").append(request.getContextPath());
		
		HttpSession session = request.getSession(false);
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String operation = request.getParameter("operation");
		System.out.println("...password:"+password);
		
		UserBO userBO = new UserBO();
		if("Login".equalsIgnoreCase(operation)){
			boolean val=LoginBO.validateLogin(username, password);
			if(val==true){
				
				UserVO userVO = userBO.getUserDetailsByName(username);
				System.out.println(userVO);
				session.setAttribute("val", "success");
				session.setAttribute("Username", username);
				session.setAttribute("isUserActive", "true");
				session.setAttribute("userProfile", userVO);
				System.out.println("ROLE...:"+ userVO.getUserRole());
				session.setAttribute("userRole", userVO.getUserRole());
				if(userVO.getUserRole().equalsIgnoreCase("ADMIN")){
					response.sendRedirect("/OEP/jsp/examList.jsp");
				}else if(userVO.getUserRole().equalsIgnoreCase("STUDENT")){
					response.sendRedirect("/OEP/jsp/examList.jsp");
				}
				
				
				
		      
			}
			else{
				session.setAttribute("val", "fail");
				session.setAttribute("isUserActive", "false");
				response.sendRedirect("/OEP/jsp/login.jsp");
				
			}
		}else if("Logout".equalsIgnoreCase(operation)){
			session.invalidate();
			response.sendRedirect("/OEP/jsp/login.jsp");
		}

	}

}
