package com.intellion.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.intellion.business.QuestionBO;
import com.intellion.vo.QuestionVO;

/**
 * Servlet implementation class SearchQuesController
 */
@WebServlet("/SearchQuesController")
public class SearchQuesController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchQuesController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		System.out.println("GET");
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		String examId=request.getParameter("examname");
		System.out.println("POST");
		System.out.println(examId);
		
		
		
		QuestionBO bo=new QuestionBO();
		
		
		
		List<QuestionVO> quesList =  bo.getQuesDetails(examId);
		
		System.out.println("QuesList...:"+quesList);
		

		if(null != quesList && quesList.size() > 0){ 
			//session.setAttribute("empSalDetailsList", empSalDetailsList);
			session.setAttribute("quesList", quesList);
			response.sendRedirect("/OEP/jsp/searchQues.jsp");
		}else{
			session.setAttribute("empList", null);
			response.sendRedirect("/OEP/jsp/searchQues.jsp");
		}
		

	}

}
