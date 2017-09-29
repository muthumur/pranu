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

public class QuestionBO {

	public int addQuestion(QuestionVO quesVO) {
		
		System.out.println("addQues called...:");
		int result = -1; 
		Connection con = null;
		Statement st = null;
		
		try {

			String quesid = StringUtilCustom.NullToEmptyString(quesVO.getQuesId());
			String examid = StringUtilCustom.NullToEmptyString(quesVO.getExamId());
			/*String category= StringUtilCustom.NullToEmptyString(quesVO.getCategory());*/
			String quesdesc = StringUtilCustom.NullToEmptyString(quesVO.getQuesDesc());
			String opt_a = StringUtilCustom.NullToEmptyString(quesVO.getQuesOpt1());
			String opt_b = StringUtilCustom.NullToEmptyString(quesVO.getQuesOpt2());
			String opt_c = StringUtilCustom.NullToEmptyString(quesVO.getQuesOpt3());
			String opt_d = StringUtilCustom.NullToEmptyString(quesVO.getQuesOpt4());
			String ans = StringUtilCustom.NullToEmptyString(quesVO.getQuesAns());
			String isactive = StringUtilCustom.NullToEmptyString(quesVO.getIsactive());
			
			
			
			/*System.out.println(userId);*/
			System.out.println(quesid);
			System.out.println(examid);
			/*System.out.println(category);*/
			System.out.println(quesdesc);
			System.out.println(opt_a);
			System.out.println(opt_b);
			System.out.println(opt_c);
			System.out.println(opt_d);
			System.out.println(ans);
			
			
			
			
			con = DBManager.getDBConnection();

			st = con.createStatement();
			
			

			String sqlQuery = "INSERT INTO QUESTION_MASTER (ques_id,ques_desc,exam_id,ques_opt1,ques_opt2,ques_opt3,ques_opt4,ques_ans,is_active)"
					+ " VALUES ('" + quesid + "','"
					+ quesdesc + "','"
					+ examid + "','"
					+ opt_a + "','"
					+ opt_b + "','"
					+ opt_c + "','"
					+ opt_d + "','"
					+ ans + "','"
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
	
		
	public int getQuestionIDMax() {
		System.out.println("getQuestionIDMax called");
		int quesIdMax=0;
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;

		try {

		
			con = DBManager.getDBConnection();
			st = con.createStatement();
			String sqlQuery = "SELECT MAX(CONVERT(ques_id,SIGNED INTEGER)) AS ques_id FROM QUESTION_MASTER";
			rs = st.executeQuery(sqlQuery);
		
			while(rs.next()){
				
				quesIdMax = (new Integer(rs.getInt("ques_id")).intValue());
				
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
		System.out.println("quesIdMax..:"+quesIdMax);
		return quesIdMax;
	}
	
	
	public QuestionVO getQuesDetailsById(String quesId) {
		System.out.println("getQuesDetailsById called");
		QuestionVO quesVO = null;
		
		
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;

		try {

		
			con = DBManager.getDBConnection();

			st = con.createStatement();

			String sqlQuery = "SELECT qm.ques_id,qm.ques_desc,qm.ques_opt1,qm.ques_opt2,qm.ques_opt3,qm.ques_opt4,qm.ques_ans,em.exam_id, em.exam_name,em.exam_category from exam_master em, question_master qm where qm.exam_id=em.exam_id and ques_id="+quesId;

			System.out.println(sqlQuery);

			rs = st.executeQuery(sqlQuery);
			
			while(rs.next()){
				
				quesVO = new QuestionVO();
				String quesid = (String)rs.getString("ques_id");
				String quesDesc = (String)rs.getString("ques_desc");
				String ques_opt1 = (String)rs.getString("ques_opt1");
				String ques_opt2 = (String)rs.getString("ques_opt2");
				String ques_opt3 = (String)rs.getString("ques_opt3");
				String ques_opt4 = (String)rs.getString("ques_opt4");
				String ques_ans = (String)rs.getString("ques_ans");
				
				String examid = (String)rs.getString("exam_id");
				String examName = (String)rs.getString("exam_name");
				String examCategory = (String)rs.getString("exam_category");
				
				System.out.println("ques_desc..:"+quesDesc);
				
				quesVO.setQuesId(quesId);
				quesVO.setQuesDesc(quesDesc);
				quesVO.setQuesOpt1(ques_opt1);
				quesVO.setQuesOpt2(ques_opt2);
				quesVO.setQuesOpt3(ques_opt3);
				quesVO.setQuesOpt4(ques_opt4);
				quesVO.setQuesAns(ques_ans);
				
				quesVO.setExamId(examid);
				quesVO.setExamCategory(examCategory);
				quesVO.setExamName(examName);
				
				
				
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

		return quesVO;
	}	


	
	public boolean updQues(QuestionVO quesVO) {
		System.out.println("updQues called");
		int count = 0;
		boolean isUpdatedStatus = false; 
		Connection con = null;
		Statement st = null;

		try {
			
			String ques_id = quesVO.getQuesId();
			String quesDesc = quesVO.getQuesDesc();
			String ques_opt1 = quesVO.getQuesOpt1();
			String ques_opt2 = quesVO.getQuesOpt2();
			String ques_opt3 = quesVO.getQuesOpt3();
			String ques_opt4 = quesVO.getQuesOpt4();
			String ques_ans = quesVO.getQuesAns();
			
		
			con = DBManager.getDBConnection();

			st = con.createStatement();

			String sqlQuery = "UPDATE question_master SET "
					+ "ques_desc='" +quesDesc
					+"',ques_opt1='"+ques_opt1
					+"',ques_opt2='"+ques_opt2
					+"',ques_opt3='"+ques_opt3
					+"',ques_opt4='"+ques_opt4
					+"',ques_ans='"+ques_ans+"'  where ques_id="+ques_id;
					

			
			
			System.out.println(sqlQuery);

			boolean isUpdated = st.execute(sqlQuery);
			if(!isUpdated){
				int updateCount = st.getUpdateCount();
				if(updateCount > 0){
					isUpdatedStatus = true;
				}
				
			}
			

			System.out.println("Question Records Updated Successfully............:"+st.getUpdateCount());

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

	
	
	public List<QuestionVO> getQuesDetails(String examId) {
		System.out.println("getQuesDetails called");
		QuestionVO empSalDetails = null;
		
		List<QuestionVO> quesList = new ArrayList<QuestionVO>();
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;

		try {

		
			con = DBManager.getDBConnection();

			st = con.createStatement();

			String sqlQuery = "SELECT qm.ques_id,qm.ques_desc,em.exam_id, em.exam_name,qm.ques_opt1,qm.ques_opt2,qm.ques_opt3,qm.ques_opt4,qm.ques_ans from question_master qm, exam_master em" 
								+" where qm.exam_id=em.exam_id and qm.exam_id="+examId+" and qm.is_active='Y'";
					

		
			
			
			
			
			
			System.out.println(sqlQuery);

			rs = st.executeQuery(sqlQuery);
			
			while(rs.next()){
				
				QuestionVO quesVO = new QuestionVO();
				
				String ques_id = (String)rs.getString("ques_id");
				String exam_id = (String)rs.getString("exam_id");
				String ques_desc = (String)rs.getString("ques_desc");
				String ques_opt1 = (String)rs.getString("ques_opt1");
				String ques_opt2 = (String)rs.getString("ques_opt2");
				String ques_opt3 = (String)rs.getString("ques_opt3");
				String ques_opt4 = (String)rs.getString("ques_opt4");
				String ques_ans = (String)rs.getString("ques_ans");
				
				
				
				quesVO.setQuesId(ques_id);
				quesVO.setExamId(exam_id);
				quesVO.setQuesDesc(ques_desc);
				quesVO.setQuesOpt1(ques_opt1);
				quesVO.setQuesOpt2(ques_opt2);
				quesVO.setQuesOpt3(ques_opt3);
				quesVO.setQuesOpt4(ques_opt4);
				quesVO.setQuesAns(ques_ans);
				
				
				
				
				quesList.add(quesVO);

				
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

		return quesList;
	}	


	public HashMap<String,QuestionVO> getQuesIdByExamId(String examId) {
		System.out.println("getQuesIdByExamId called");
		QuestionVO quesVO = null;
		
		
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		HashMap<String,QuestionVO> quesmap = new HashMap<String,QuestionVO>();

		try {

		
			con = DBManager.getDBConnection();

			st = con.createStatement();

			String sqlQuery = "SELECT qm.ques_id,qm.exam_id,qm.ques_desc,qm.ques_opt1,qm.ques_opt2,qm.ques_opt3,qm.ques_opt4,qm.ques_ans, "
					+ "em.exam_name, em.exam_category"
					+ " from QUESTION_MASTER qm, EXAM_MASTER em where qm.exam_id=em.exam_id and qm.exam_id='"+examId+"'";

			System.out.println(sqlQuery);

			rs = st.executeQuery(sqlQuery);
			int quesCounter = 0;
			
			while(rs.next()){
				
				quesCounter++;
				 quesVO = new QuestionVO();
				String quesid = (String)rs.getString("ques_id");

				String quesDesc = (String)rs.getString("ques_desc");
				String ques_opt1 = (String)rs.getString("ques_opt1");
				String ques_opt2 = (String)rs.getString("ques_opt2");
				String ques_opt3 = (String)rs.getString("ques_opt3");
				String ques_opt4 = (String)rs.getString("ques_opt4");
				String ques_ans = (String)rs.getString("ques_ans");
				
				String examid = (String)rs.getString("exam_id");
				String examName = (String)rs.getString("exam_name");
				String examCategory = (String)rs.getString("exam_category");
				
				
				quesVO.setQuesId(quesid);
				quesVO.setQuesDesc(quesDesc);
				quesVO.setQuesOpt1(ques_opt1);
				quesVO.setQuesOpt2(ques_opt2);
				quesVO.setQuesOpt3(ques_opt3);
				quesVO.setQuesOpt4(ques_opt4);
				quesVO.setQuesAns(ques_ans);
				
				quesVO.setExamId(examid);
				quesVO.setExamCategory(examCategory);
				quesVO.setExamName(examName);
				
				quesmap.put(String.valueOf(quesCounter), quesVO);
				
				
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

		return quesmap;
	}	

	
	public String getQuestionCountByExamId(String examId) {
		System.out.println("getQuestionCountByExamId called");
		//String quesCount = null;
		Connection con = null;
		String quescount = null;
		Statement st = null;
		ResultSet rs = null;
		QuestionVO quesVO = null;

		try {

		
			con = DBManager.getDBConnection();
			st = con.createStatement();
			String sqlQuery = "select count(ques_id) from question_master where exam_id="+examId;
			System.out.println(sqlQuery);
			rs = st.executeQuery(sqlQuery);
			while(rs.next()){
				quesVO = new QuestionVO();
				quescount = (String)rs.getString("count(ques_id)");
				System.out.println("Question Count:"+quescount);
				
				quesVO.setQuesId(quescount);
				
				
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
		System.out.println("quesIdMax..:"+quescount);
		return quescount;
	}
	
	
	
	
	public boolean delQues(String quesId) {
		System.out.println("delQues called..");
		int count = 0;
		boolean isUpdatedStatus = false; 
		Connection con = null;
		Statement st = null;

		try {

			con = DBManager.getDBConnection();
			st = con.createStatement();

			String sqlQuery = "UPDATE question_master SET "
					+ "is_active='N'"
	                +" where ques_id="+quesId;

			System.out.println(sqlQuery);

			boolean isUpdated = st.execute(sqlQuery);
			if(!isUpdated){
				int updateCount = st.getUpdateCount();
				if(updateCount > 0){
					isUpdatedStatus = true;
				}
				
			}
			

			System.out.println("Question Deleted Successfully............:"+st.getUpdateCount());

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
	
}
