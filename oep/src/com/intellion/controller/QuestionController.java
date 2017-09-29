package com.intellion.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.intellion.business.ExamBO;
import com.intellion.business.QuestionBO;
import com.intellion.business.ResultBO;
import com.intellion.vo.ExamVO;
import com.intellion.vo.QuestionVO;
import com.intellion.vo.ResultVO;

/**
 * Servlet implementation class QuestionController
 */
//
public class QuestionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuestionController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		System.out.println("Question Controller Called");
		doPost(request,response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Question Controller POST");
		
		HttpSession session = request.getSession(true);
		
		String userName = "";
		userName = (String)session.getAttribute("Username");
		
		String operation = request.getParameter("operation");
		System.out.println(operation);
		
		
		QuestionVO quesVO = null;
		ExamVO examVO = null;
		QuestionBO quesBO = new QuestionBO();
		ExamBO examBO = new ExamBO();
		ResultBO resultBO = new ResultBO();
		ResultVO   resultVO = null;
		Map<String, ResultVO> resultVOMap = new HashMap<String,ResultVO>();
		int requestResult = 0;
		int currentQuesNo = 0;
		int totalQues = 0;
		boolean isUpdated = false;
		int nextQuesNo = 0;
		
		if(null != operation && ("ADD").equalsIgnoreCase(operation)){
			
			System.out.println("ADD QUES");
			String quesId = request.getParameter("quesid");
			String examId = request.getParameter("exam_id");
			//String category = request.getParameter("category");
			String quesdesc = request.getParameter("ques_desc");
			String opt_a = request.getParameter("opt_a");
			String opt_b = request.getParameter("opt_b");
			String opt_c = request.getParameter("opt_c");
			String opt_d = request.getParameter("opt_d");
			String ans = request.getParameter("ans");
			
			
			System.out.println(quesId);
			System.out.println(examId);
			//System.out.println(category);
			System.out.println(quesdesc);
			System.out.println(opt_a);
			System.out.println(opt_b);
			System.out.println(opt_c);
			System.out.println(opt_d);
			System.out.println(ans);
			
			

			if(null != quesId && null != examId && null != quesdesc && null != opt_a && null != opt_b && null != opt_c && null != opt_d && null != ans){
				
				
				System.out.println("ADD QUES1");
				quesVO = new QuestionVO();
				
				
				
				quesVO.setQuesId(quesId);
				quesVO.setExamId(examId);;
				quesVO.setQuesDesc(quesdesc);
				quesVO.setQuesOpt1(opt_a);
				quesVO.setQuesOpt2(opt_b);
				quesVO.setQuesOpt3(opt_c);
				quesVO.setQuesOpt4(opt_d);
				quesVO.setQuesAns(ans);
				quesVO.setIsactive("Y");
				
				requestResult = quesBO.addQuestion(quesVO);
				int quesCount =Integer.parseInt(quesBO.getQuestionCountByExamId(examId));
				
				boolean Count = examBO.updTot(examId, quesCount);

				
				if(requestResult == 1){
					
					System.out.println("requestResult..:"+requestResult);
					session.setAttribute("quesAddresult", "success");
					response.sendRedirect("/OEP/jsp/addQues.jsp");
					
				}
				
								
				
				
			}
			
		}else if(null != operation && ("UPD").equalsIgnoreCase(operation)){
			
			
			System.out.println("UPD QUES");
			String quesId = request.getParameter("quesid");
			String examId = request.getParameter("examname");
			String category = request.getParameter("category");
			String quesdesc = request.getParameter("ques_desc");
			String opt_a = request.getParameter("opt_a");
			String opt_b = request.getParameter("opt_b");
			String opt_c = request.getParameter("opt_c");
			String opt_d = request.getParameter("opt_d");
			String quesAns = request.getParameter("quesAns");
			
			//String totQues = request.getParameter("tot_ques");
			
			quesVO = new QuestionVO();
			//examVO = new ExamVO();
			
			quesVO.setQuesId(quesId);
			quesVO.setExamId(examId);
			quesVO.setQuesDesc(quesdesc);
			quesVO.setQuesOpt1(opt_a);
			quesVO.setQuesOpt2(opt_b);
			quesVO.setQuesOpt3(opt_c);
			quesVO.setQuesOpt4(opt_d);
			quesVO.setQuesAns(quesAns);
			
			//examVO.setTotQues(totQues);
			
			isUpdated = quesBO.updQues(quesVO );
			
			if(isUpdated){
				System.out.println("success");
				session.setAttribute("quesId", quesId);
				session.setAttribute("result", "success");
				response.sendRedirect("/OEP/jsp/editQues.jsp?quesId="+quesId);
			}
		
		
		
		}else if(null != operation && ("START").equalsIgnoreCase(operation)){
			
			System.out.println("START EXAM");
			
						
			String examId = request.getParameter("examId");
			
			
			
			quesVO = new QuestionVO();
			Map <String,QuestionVO> quesMap = quesBO.getQuesIdByExamId(examId);
			
			
			
			
			System.out.println("quesMap:"+quesMap);
			
			if(null != quesMap && quesMap.size() > 0){
				
				totalQues = quesMap.size();
				++currentQuesNo;
				System.out.println("currentQuesNo in controller:"+currentQuesNo);
				System.out.println("totalQues in controller:"+totalQues);
				
				session.setAttribute("quesMap", quesMap);
				session.setAttribute("resultVOMap", resultVOMap);
				
				quesVO = quesMap.get(String.valueOf(currentQuesNo));
				
				System.out.println("quesVO in controller:"+quesVO);
				
				if(null != quesVO ){
					session.setAttribute("selectedQues", quesVO);
					session.setAttribute("currentQuesNo", String.valueOf(currentQuesNo));
				}else{
					session.setAttribute("selectedQues", null);
					session.setAttribute("currentQuesNo", String.valueOf(--currentQuesNo));
				}
				
			}else{
				session.setAttribute("quesMap", null);
			}
			session.setAttribute("totalQues", String.valueOf(totalQues));
			
			
			if(totalQues == currentQuesNo){
				response.sendRedirect("/OEP/jsp/beginTest.jsp?operation=FINISH&examId="+examId);
			}else{
				response.sendRedirect("/OEP/jsp/beginTest.jsp?operation=NEXT&examId="+examId);
			}
			
			
			
			
		}else if(null != operation && ("NEXT").equalsIgnoreCase(operation)){
			
			System.out.println("NEXT EXAM");
			
			
			String examId = request.getParameter("examId");
			String quesId = (String)request.getParameter("quesId");
			String userAnswer = (String)request.getParameter("answer");
			String correctAnswer = (String)request.getParameter("CA");
			
			System.out.println(examId);
			System.out.println(quesId);
			System.out.println(userAnswer);
			System.out.println(correctAnswer);
			
			resultVO = new ResultVO();
			resultVO.setExamId(examId);
			resultVO.setQuesId(quesId);
			resultVO.setUserName(userName);
			resultVO.setUserAnswer(userAnswer);
			resultVO.setCorrectAnswer(correctAnswer);
			
			if(correctAnswer.equalsIgnoreCase(userAnswer)){
				resultVO.setIsAnsCorrect("Y");
			}else{
				resultVO.setIsAnsCorrect("N");
			}
			
			
			
			
			resultVOMap = (Map<String, ResultVO>)session.getAttribute("resultVOMap");
			
			resultVOMap.put(quesId,resultVO);
			
			session.setAttribute("resultVOMap", resultVOMap);
			
			currentQuesNo = Integer.parseInt((String)session.getAttribute("currentQuesNo"));
			
			Map <String,QuestionVO> quesMap = (Map <String,QuestionVO>) session.getAttribute("quesMap");
			
			++currentQuesNo;
			totalQues = quesMap.size();
			
			if(currentQuesNo > 1){
				quesVO = quesMap.get(String.valueOf(currentQuesNo));
				if(null != quesVO ){
					session.setAttribute("selectedQues", quesVO);
					session.setAttribute("currentQuesNo", String.valueOf(currentQuesNo));
				}else{
					session.setAttribute("selectedQues", null);
					session.setAttribute("currentQuesNo", String.valueOf(currentQuesNo));
				}
				
			}
			
			if(totalQues == currentQuesNo){
				response.sendRedirect("/OEP/jsp/beginTest.jsp?operation=FINISH&examId="+examId);
			}else{
				response.sendRedirect("/OEP/jsp/beginTest.jsp?operation=NEXT&examId="+examId);
			}
			
			
		}else if(null != operation && ("BACK").equalsIgnoreCase(operation)){
			
			
			String examId = request.getParameter("examId");
			currentQuesNo = Integer.parseInt((String)session.getAttribute("currentQuesNo"));
			
			Map <String,QuestionVO> quesMap = (Map <String,QuestionVO>) session.getAttribute("quesMap");
			
			
			
			if(currentQuesNo > 1){
				--currentQuesNo;
				quesVO = quesMap.get(String.valueOf(currentQuesNo));
				if(null != quesVO ){
					session.setAttribute("selectedQues", quesVO);
					session.setAttribute("currentQuesNo", String.valueOf(currentQuesNo));
				}else{
					session.setAttribute("selectedQues", null);
					session.setAttribute("currentQuesNo", String.valueOf(currentQuesNo));
				}
				response.sendRedirect("/OEP/jsp/beginTest.jsp?operation=NEXT&examId="+examId);
			}
			
			
		}else if(null != operation && ("FINISH").equalsIgnoreCase(operation)){
			
			System.out.println("FINISH EXAM");
			
			
			String examId = request.getParameter("examId");
			String quesId = (String)request.getParameter("quesId");
			String userAnswer = (String)request.getParameter("answer");
			String correctAnswer = (String)request.getParameter("CA");
			
			
			System.out.println(examId);
			System.out.println(quesId);
			System.out.println(userAnswer);
			System.out.println(correctAnswer);
			
			resultVO = new ResultVO();
			resultVO.setExamId(examId);
			resultVO.setQuesId(quesId);
			resultVO.setUserName(userName);
			resultVO.setUserAnswer(userAnswer);
			resultVO.setCorrectAnswer(correctAnswer);
			
			
			if(correctAnswer.equalsIgnoreCase(userAnswer)){
				resultVO.setIsAnsCorrect("Y");
			}else{
				resultVO.setIsAnsCorrect("N");
			}
			
			resultVOMap = (Map<String, ResultVO>)session.getAttribute("resultVOMap");
			resultVOMap.put(quesId,resultVO);
			System.out.println("resultVOMap size:"+resultVOMap.size());
			boolean deleteStatus = resultBO.delResultByExamId(examId, userName);
			
			
			
			for (Map.Entry<String, ResultVO> entry : resultVOMap.entrySet())
			{
			    System.out.println(entry.getKey() + "/" + entry.getValue());
			    resultVO =  entry.getValue();
			    resultBO.addExamResult(resultVO);
			}				
			
			//resultBO.getExamSummaryByUserNameExamId(userName, examId);
			
			if(requestResult != 1){
				//go to error page
				response.sendRedirect("/OEP/jsp/detailedReport.jsp?userName="+userName+"&examId="+examId);
			}else{
				//go to result summary page
			}
		}else if(operation.equals("DEL")){
			System.out.println("DEL EXAM");
			quesBO = new QuestionBO();
			String quesId = request.getParameter("quesId");
			System.out.println(quesId);
			
			
			
				
				isUpdated = quesBO.delQues(quesId);
				
				if(isUpdated){
					System.out.println("success");
					session.setAttribute("result", "success");
					response.sendRedirect("/OEP/jsp/searchQues.jsp");				
					
				}else{
					//errorpage
				}
				
			}

	}

}
