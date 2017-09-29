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
import com.intellion.vo.UserVO;

public class ExamBO {

	public int addExam(ExamVO examVO) {
		
		System.out.println("addExam called...:");
		int result = -1; 
		Connection con = null;
		Statement st = null;
		
		try {

			String examId = StringUtilCustom.NullToEmptyString(examVO.getExamId());
			String examName = StringUtilCustom.NullToEmptyString(examVO.getExamName());
			String examCategory = StringUtilCustom.NullToEmptyString(examVO.getExamCategory());
			String isactive = StringUtilCustom.NullToEmptyString(examVO.getIsactive());
			String totalQues = "0";
			
			System.out.println(examId);
			System.out.println(examName);
			System.out.println(examCategory);
			System.out.println(totalQues);
			
			con = DBManager.getDBConnection();

			st = con.createStatement();
			
			

			String sqlQuery = "INSERT INTO EXAM_MASTER (exam_id,exam_name,exam_category,tot_ques,is_active)"
					+ " VALUES ('" + examId + "','"
					+ examName + "','"
					+ examCategory + "','"
					+ totalQues + "','"
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
	
	
public boolean updExam(ExamVO examVO) {
		
		System.out.println("updExam called...:");
		int result = -1; 
		Connection con = null;
		Statement st = null;
		boolean isUpdatedStatus = false; 
		
		try {

			String examId = StringUtilCustom.NullToEmptyString(examVO.getExamId());
			String examName = StringUtilCustom.NullToEmptyString(examVO.getExamName());
			String examCategory = StringUtilCustom.NullToEmptyString(examVO.getExamCategory());
			String totalQues = StringUtilCustom.NullToEmptyString(examVO.getTotQues());
			
			System.out.println(examId);
			System.out.println(examName);
			System.out.println(examCategory);
			System.out.println(totalQues);
			
			
			con = DBManager.getDBConnection();

			st = con.createStatement();
			String sqlQuery = "UPDATE EXAM_MASTER SET "
					+ "exam_name='" +examName
					+"',exam_category='"+examCategory
					+"',tot_ques='"+totalQues
					+ "' where exam_id="+examId;			
			

			
			
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
	
	
public List<ExamVO> getExamList() {
		
	ExamVO examVO = null;
		List<ExamVO> examVOList = new ArrayList<ExamVO>();
		 
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;

		try {

		
			con = DBManager.getDBConnection();

			st = con.createStatement();

			String sqlQuery = "SELECT em.exam_id, em.exam_name, cm.cat_name , em.tot_ques from EXAM_MASTER em, category_master cm where cm.cat_id=em.exam_category and em.is_active='Y'";

			System.out.println(sqlQuery);

			rs = st.executeQuery(sqlQuery);
			
			while(rs.next()){
				
				examVO = new ExamVO();
				String examId = (String)rs.getString("exam_id");
				String examName = (String)rs.getString("exam_name");
				String examCategory = (String)rs.getString("cat_name");
				String totQues = (String)rs.getString("tot_ques");
				
				
				examVO.setExamId(examId);
				examVO.setExamName(examName);
				examVO.setExamCategory(examCategory);
				examVO.setTotQues(totQues);
				
				examVOList.add(examVO);
				
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

		return examVOList;
	}	




public boolean delExam(String examId) {
	System.out.println("delExam called..");
	int count = 0;
	boolean isUpdatedStatus = false; 
	Connection con = null;
	Statement st = null;

	try {

		con = DBManager.getDBConnection();
		st = con.createStatement();

		String sqlQuery = "UPDATE exam_master SET "
				+ "is_active='N'"
                +" where exam_id="+examId;

		System.out.println(sqlQuery);

		boolean isUpdated = st.execute(sqlQuery);
		if(!isUpdated){
			int updateCount = st.getUpdateCount();
			if(updateCount > 0){
				isUpdatedStatus = true;
			}
			
		}
		

		System.out.println("Exam Deleted Successfully............:"+st.getUpdateCount());

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
		

	public int getExamIDMax() {
		System.out.println("getExamIDMax called");
		int examIdMax=0;
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;

		try {

		
			con = DBManager.getDBConnection();
			st = con.createStatement();
			//String sqlQuery = "SELECT MAX(exam_id) AS exam_id FROM EXAM_MASTER";
			
			String sqlQuery = "SELECT MAX(CONVERT(exam_id,SIGNED INTEGER)) AS exam_id FROM EXAM_MASTER";
			rs = st.executeQuery(sqlQuery);
		
			while(rs.next()){
				
				//examIdMax = (new Integer(rs.getInt("exam_id")).intValue());
				examIdMax = Integer.parseInt(rs.getString("exam_id"));
				
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
		System.out.println("examIdMax..:"+examIdMax);
		return examIdMax;
	}		
	
	
public List<ExamVO> getExamNames() {
		 
		
		System.out.println("getExamNames called....");
		
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		
		List<ExamVO> examNames = new ArrayList<ExamVO>();

		ExamVO examVO = null;
		
		try {

			con = DBManager.getDBConnection();

			st = con.createStatement();

			String sqlQuery = "SELECT DISTINCT exam_id, exam_name  FROM exam_master where is_active='Y'";
			
			

			System.out.println(sqlQuery);

			rs = st.executeQuery(sqlQuery);
			
			
			while(rs.next()){
				
				examVO = new ExamVO();
				String examId = rs.getString("exam_id");
				examVO.setExamId(examId);;
				
				String examName= rs.getString("exam_name");
				examVO.setExamName(examName);
				
				examNames.add(examVO);
			}

		} catch (Exception e) {
			e.printStackTrace();
			//System.out.println(e);
		}finally{
			try {
				st.close();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}

		return examNames;

	}


public List<ExamVO> getCategoryNames() {
	 
	
	System.out.println("getCategoryNames called....");
	
	Connection con = null;
	Statement st = null;
	ResultSet rs = null;
	
	List<ExamVO> catNames = new ArrayList<ExamVO>();

	ExamVO examVO = null;
	
	try {

		con = DBManager.getDBConnection();

		st = con.createStatement();

		String sqlQuery = "SELECT DISTINCT cat_id, cat_name FROM category_master where is_active='Y'";
		
		

		System.out.println(sqlQuery);

		rs = st.executeQuery(sqlQuery);
		
		
		while(rs.next()){
			
			examVO = new ExamVO();
			String catId = rs.getString("cat_id");
			examVO.setCatId(catId);
			
			String catName= rs.getString("cat_name");
			examVO.setCatName(catName);
			
			catNames.add(examVO);
		}

	} catch (Exception e) {
		e.printStackTrace();
		//System.out.println(e);
	}finally{
		try {
			st.close();
			con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	return catNames;

}


public boolean updTotalQues(String examId) {
	
	System.out.println("updExam called...:");
	ExamVO examVO = new ExamVO();
	int result = -1; 
	Connection con = null;
	Statement st = null;
	boolean isUpdatedStatus = false; 
	
	try {

		//String examId = StringUtilCustom.NullToEmptyString(examVO.getExamId());
		//String examName = StringUtilCustom.NullToEmptyString(examVO.getExamName());
		//String examCategory = StringUtilCustom.NullToEmptyString(examVO.getExamCategory());
		String totalQues = StringUtilCustom.NullToEmptyString(examVO.getTotQues());
		
		//System.out.println(examId);
		//System.out.println(examName);
		//System.out.println(examCategory);
		System.out.println(totalQues);
		
		
		con = DBManager.getDBConnection();

		st = con.createStatement();
		String sqlQuery = "UPDATE EXAM_MASTER SET "+ "tot_ques='" +totalQues + "' where exam_id="+examId;			
		

		
		
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


public ExamVO getExamDetailsById(String examId) {
	System.out.println("getExamDetailsById called");
	ExamVO examVO = null;
	
	
	Connection con = null;
	Statement st = null;
	ResultSet rs = null;

	try {

	
		con = DBManager.getDBConnection();

		st = con.createStatement();

		String sqlQuery = "SELECT exam_name,exam_category from exam_master where exam_id="+examId;

		System.out.println(sqlQuery);

		rs = st.executeQuery(sqlQuery);
		
		while(rs.next()){
			
			examVO = new ExamVO();
			String exam_name = (String)rs.getString("exam_name");
			String exam_category = (String)rs.getString("exam_category");
			
			examVO.setExamName(exam_name);
			examVO.setExamCategory(exam_category);
			
			
			
			
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

	return examVO;
}	


public boolean updTot(String examId, int quesCount) {
	
	System.out.println("updTot called...:");
	int result = -1; 
	Connection con = null;
	Statement st = null;
	boolean isUpdatedStatus = false; 
	
	try {
		//String examId = StringUtilCustom.NullToEmptyString(examVO.getExamId());
		//String quesCount = StringUtilCustom.NullToEmptyString(examVO.getTotQues());
		
		//System.out.println(totalQues);
		
		
		con = DBManager.getDBConnection();

		st = con.createStatement();
		String sqlQuery = "UPDATE EXAM_MASTER SET "
				+ "tot_ques='" +quesCount
				+ "' where exam_id="+examId;			
		

		
		
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





}
