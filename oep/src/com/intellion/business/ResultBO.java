package com.intellion.business;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.intellion.util.DBManager;
import com.intellion.util.StringUtilCustom;
import com.intellion.vo.ExamVO;
import com.intellion.vo.QuestionVO;
import com.intellion.vo.ResultVO;
import com.intellion.vo.UserVO;

public class ResultBO {

public int addExamResult(ResultVO resultVO) {
		
		System.out.println("addExamResult called...:");
		int result = -1; 
		Connection con = null;
		Statement st = null;
		
		try {

			String quesid = StringUtilCustom.NullToEmptyString(resultVO.getQuesId());
			String examid = StringUtilCustom.NullToEmptyString(resultVO.getExamId());
			String userName = StringUtilCustom.NullToEmptyString(resultVO.getUserName());
			String userAnswer = StringUtilCustom.NullToEmptyString(resultVO.getUserAnswer());
			String correctAnswer = StringUtilCustom.NullToEmptyString(resultVO.getCorrectAnswer());
			String isAnsCorrect = StringUtilCustom.NullToEmptyString(resultVO.getIsAnsCorrect());
			String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
			
			System.out.println(quesid);
			System.out.println(examid);
			System.out.println(userName);
			System.out.println(userAnswer);
			System.out.println(correctAnswer);
			System.out.println(isAnsCorrect);
			
			
			
			
			con = DBManager.getDBConnection();

			st = con.createStatement();
			
			

			String sqlQuery = "INSERT INTO EXAM_RESULT (ques_id,exam_id,user_answer,correct_opt,isAnsCorrect,user_name,date)"
					+ " VALUES ('" + quesid + "','"
					+ examid + "','"
					+ userAnswer + "','"
					+ correctAnswer + "','"
					+ isAnsCorrect + "','"
					+ userName + "','"
					+ currentDate +"')";

			
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

public boolean delResultByExamId(String examId, String userName) {
	System.out.println("delResultByExamId called..");
	int count = 0;
	boolean isUpdatedStatus = false; 
	Connection con = null;
	Statement st = null;

	try {

		con = DBManager.getDBConnection();
		st = con.createStatement();

		String sqlQuery = "DELETE FROM exam_result where exam_id='"+examId+"' and user_name='"+userName+"'";

		System.out.println(sqlQuery);

		boolean isUpdated = st.execute(sqlQuery);
		if(!isUpdated){
			int updateCount = st.getUpdateCount();
			if(updateCount > 0){
				isUpdatedStatus = true;
			}
			
		}
		

		System.out.println("Exam RESULT Deleted Successfully............:"+st.getUpdateCount());

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


public List <ResultVO> getExamSummaryByUserNameExamId(String userName, String examId) {
	
	System.out.println("getExamSummaryByUserNameExamId called...:");
	int result = -1; 
	Connection con = null;
	Statement st = null;
	ResultSet rs = null;
	
	List <ResultVO> resultVOList = new ArrayList<ResultVO>();
	
	try {

		con = DBManager.getDBConnection();

		st = con.createStatement();

		String sqlQuery = "SELECT em.exam_id, em.exam_name,qm.ques_id, qm.ques_desc, rm.user_answer, rm.correct_opt, rm.isAnsCorrect, rm.user_name, rm.date from EXAM_RESULT rm, EXam_MASTER em, QUESTION_MASTER qm"
		+ " where em.exam_id=rm.exam_id and qm.ques_id=rm.ques_id and rm.user_name='"+userName+"' and rm.exam_id='"+examId+"'";
		
		System.out.println(sqlQuery);

		rs = st.executeQuery(sqlQuery);
		
		while(rs.next()){
			
			ResultVO resultVO = new ResultVO();
			
			String ques_id = (String)rs.getString("ques_id");
			String exam_id = (String)rs.getString("exam_id");
			String ques_desc = (String)rs.getString("ques_desc");
			String exam_name = (String)rs.getString("exam_name");
			String user_answer = (String)rs.getString("user_answer");
			String correct_opt = (String)rs.getString("correct_opt");
			String isAnsCorrect = (String)rs.getString("isAnsCorrect");
			String user_name = (String)rs.getString("user_name");
			
			
			
			resultVO.setQuesId(ques_id);
			resultVO.setExamId(exam_id);
			resultVO.setQuesDesc(ques_desc);
			resultVO.setExamName(exam_name);
			resultVO.setUserAnswer(user_answer);
			resultVO.setCorrectAnswer(correct_opt);
			resultVO.setIsAnsCorrect(isAnsCorrect);
			resultVO.setUserName(user_name);
			
			
			
			
			resultVOList.add(resultVO);
			
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

	return resultVOList;


}

public List<ResultVO> getResultList() {
	
	ResultVO resultVO = null;
		List<ResultVO> resultVOList = new ArrayList<ResultVO>();
		 
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;

		try {

		
			con = DBManager.getDBConnection();

			st = con.createStatement();

			String sqlQuery = "SELECT ques_id, ques_desc, exam_id , user_answer , correct_opt , isAnsCorrect , user_name , date from EXAM_RESULT ";

			System.out.println(sqlQuery);

			rs = st.executeQuery(sqlQuery);
			
			while(rs.next()){
				
				resultVO = new ResultVO();
				String quesId = (String)rs.getString("ques_id");
			//	String quesDesc = (String)rs.getString("ques_desc");
				String examId = (String)rs.getString("exam_id");
				String userAns = (String)rs.getString("user_answer");
				String correctOpt = (String)rs.getString("correct_opt");
			//	String isAnsCorrect = (String)rs.getString("isAnsCorrect");
				String username = (String)rs.getString("user_name");
			//	String date = (String)rs.getString("date");
				
				resultVO.setQuesId(quesId);
				resultVO.setExamId(examId);
				resultVO.setUserAnswer(userAns);
				resultVO.setCorrectAnswer(correctOpt);
				resultVO.setUserName(username);
				
				
				
				resultVOList.add(resultVO);
				
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

		return resultVOList;
	}	




public List<ResultVO> getQuesList(String examId , String userName) {
	
	ResultVO resultVO = null;
	List<ResultVO> quesVOList = new ArrayList<ResultVO>();
	 
	Connection con = null;
	Statement st = null;
	ResultSet rs = null;

	try {

	
		con = DBManager.getDBConnection();

		st = con.createStatement();

		String sqlQuery = "SELECT qm.ques_id, qm.ques_desc , rm.user_name , rm.exam_id from EXAM_RESULT rm, QUESTION_MASTER qm where qm.ques_id=rm.ques_id  and isAnsCorrect='N'and rm.user_name='"+userName+"' and rm.exam_id='"+examId+"'";

		System.out.println(sqlQuery);

		rs = st.executeQuery(sqlQuery);
		
		while(rs.next()){
			
			resultVO = new ResultVO();
			String quesId = (String)rs.getString("ques_id");
			String quesDesc = (String)rs.getString("ques_desc");
			String username = (String)rs.getString("user_name");
			
			
			resultVO.setQuesId(quesId);
			resultVO.setQuesDesc(quesDesc);
			resultVO.setUserName(username);
			
			
			quesVOList.add(resultVO);
			
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

	return quesVOList;
}	


	
	
}
