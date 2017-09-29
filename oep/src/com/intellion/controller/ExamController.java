package com.intellion.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.intellion.business.ExamBO;
import com.intellion.business.QuestionBO;
import com.intellion.business.UserBO;
import com.intellion.vo.ExamVO;
import com.intellion.vo.QuestionVO;
import com.intellion.vo.UserVO;

/**
 * Servlet implementation class ExamController
 */
//@WebServlet("/ExamController")
public class ExamController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExamController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		System.out.println("Exam Controller get");
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Exam Controller POST");
		
		HttpSession session = request.getSession(false);
		
		String operation = request.getParameter("operation");
		System.out.println(operation);
		
		
		ExamVO examVO = null;
		ExamBO examBO = null;
		QuestionBO quesBO = new QuestionBO();
		QuestionVO quesVO = new QuestionVO();
		
		int requestResult = 0;
		boolean isUpdated = false;
		
		if(null != operation && ("ADD").equalsIgnoreCase(operation)){
			
			
			System.out.println("ADD EXAM");
			String examId = request.getParameter("examid");
			String examName = request.getParameter("examname");
			String category = request.getParameter("category");
			
			
			
			
			
			
			System.out.println(examId);
			System.out.println(examName);
			System.out.println(category);
			
			
			

			if(null != examId && null != examName && null != category){
				
				examVO = new ExamVO();
				examBO = new ExamBO();
				
				
				examVO.setExamId(examId);
				examVO.setExamName(examName);
				examVO.setExamCategory(category);
				examVO.setIsactive("Y");
				
				requestResult = examBO.addExam(examVO);
				
				if(requestResult == 1){
					
					System.out.println("requestResult..:"+requestResult);
					session.setAttribute("result", "success");
					response.sendRedirect("/OEP/jsp/examList.jsp");
					
				}
				
								
				
				
			}
			
		}
		
		if(null != operation && ("UPD").equalsIgnoreCase(operation)){
			
			
			System.out.println("UPD EXAM");
			String examId = request.getParameter("examid");
			String examName = request.getParameter("examname");
			String category = request.getParameter("category");
			String quesCount = quesBO.getQuestionCountByExamId(examId);

			if(null != examId && null != examName && null != category){
				
				examVO = new ExamVO();
				examBO = new ExamBO();
				
				examVO.setExamId(examId);
				examVO.setExamName(examName);
				examVO.setExamCategory(category);
				examVO.setTotQues(quesCount);
				
				isUpdated = examBO.updExam(examVO);
				if(isUpdated){
					System.out.println("success");
					session.setAttribute("result", "success");
					response.sendRedirect("/OEP/jsp/examList.jsp");			
					
				}else{
					//errorpage
				}
				
			}
			
		}//END OF upd
		else if(operation.equals("DEL")){
			System.out.println("DEL EXAM");
			examBO = new ExamBO();
			String examId = request.getParameter("examId");
			System.out.println(examId);
			
			
			
				
				isUpdated = examBO.delExam(examId);
				
				if(isUpdated){
					System.out.println("success");
					session.setAttribute("result", "success");
					response.sendRedirect("/OEP/jsp/examList.jsp");				
					
				}else{
					//errorpage
				}
				
			}

	}

}
