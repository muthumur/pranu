package com.intellion.business;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.intellion.util.DBManager;
import com.intellion.vo.ResultVO;
import com.intellion.vo.StudentResultVO;

public class StudentResultBO {

	public List <StudentResultVO> getStudentSummaryByUserName(String userName) {
		
		System.out.println("getStudentSummaryByUserName called...:");
		int result = -1; 
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		
		List <StudentResultVO> studVOList = new ArrayList<StudentResultVO>();
		
		try {

			con = DBManager.getDBConnection();

			st = con.createStatement();

			String sqlQuery = "SELECT DISTINCT er.exam_id, em.exam_name, em.exam_category, cm.cat_name, em.tot_ques FROM exam_result er, exam_master em, category_master cm where er.exam_id=em.exam_id and cm.cat_id=em.exam_category and er.user_name='"+userName+"'";
			
			System.out.println(sqlQuery);

			rs = st.executeQuery(sqlQuery);
			
			while(rs.next()){
				
				StudentResultVO studVO = new StudentResultVO();
				
				String exam_id = (String)rs.getString("exam_id");
				String exam_name = (String)rs.getString("exam_name");
				String exam_category = (String)rs.getString("exam_category");
				String cat_name = (String)rs.getString("cat_name");
				String tot_ques = (String)rs.getString("tot_ques");
				//String username = (String)rs.getString("user_name");
				
				
				
				studVO.setExamId(exam_id);
				studVO.setExamName(exam_name);
				//studVO.setUserName(username);
				studVO.setExamcategory(exam_category);
				studVO.setTotQues(tot_ques);
				studVO.setCatName(cat_name);
				studVOList.add(studVO);
				
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

		return studVOList;


	}

}
