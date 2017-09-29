<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page import="com.intellion.business.ExamBO"%>
<%@ page import="com.intellion.business.QuestionBO"%>
<%@ page import="com.intellion.vo.*"%>
<%@ page import="java.util.List"%>  
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>OEP</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Copyright" content="arirusmanto.com">
<meta name="description" content="Admin MOS Template">
<meta name="keywords" content="Admin Page">
<meta name="author" content="Ari Rusmanto">
<meta name="language" content="Bahasa Indonesia">

<link rel="shortcut icon" href="stylesheet/img/devil-icon.png"> <!--Pemanggilan gambar favicon-->
<link rel="stylesheet" type="text/css" href="../css/mos-style.css"> <!--pemanggilan file css-->
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
</head>

<body>
<%
        String userStatus= (String) session.getAttribute("isUserActive");
        if(null == userStatus || (!"true".equalsIgnoreCase(userStatus))){
        	 response.sendRedirect("/OEP/jsp/login.jsp");
        }
        
%>

<%@include  file="header.jsp" %>

<div id="wrapper">
	<%@include  file="leftbar.jsp" %>
	<div id="rightContent">
	<%

			if(role.equalsIgnoreCase("student")){	
	%>
			<div class="panel panel-primary">
                    <div class="panel-heading">
                      <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#cat-76">Exam List</a>
                      </h4>
                    </div>
                    <div id="cat-76" class="panel-collapse collapse in">
                      <table class="table table-condensed table-striped" id="examList">
                            <thead>
                                <tr>
                                    <th width="15%">SL No.</th>
                                    <th width="25%">Exam Name</th>
                                    <th width="25%">Category</th>
                                    <th width="15%">Total Ques</th>
									<th width="20%">Begin Test</th>
									                                   
                                </tr>
                            </thead>
                        <%
							ExamBO examBO = new ExamBO();
							List<ExamVO> examVOList = examBO.getExamList();
							
							

							System.out.println("examvolist size..:" + examVOList.size());
							
							if(null != examVOList && examVOList.size() >0){
								int lineCount=0;
								for(int i=0; i < examVOList.size(); i++){
									
								ExamVO examVO = examVOList.get(i);
								String examId = examVO.getExamId();
								String examName = examVO.getExamName();
								String examCategory = examVO.getExamCategory();
								String catName = examVO.getCatName();
								String totQues = examVO.getTotQues();
								++lineCount;
								if(Integer.parseInt(totQues) > 0){
									
								
								
						%>        
						
						        
						                    
                            <tbody>
                                <tr>
                                    <td><%=lineCount %></td>
                                    <td><%=examName %></td>
                                    <td><%=examCategory %></td>
                                    <td><%=totQues %></td>
                                    <td><a class="btn btn-primary" href="aboutExam.jsp?examId=<%=examId %>">Start</a></td>
                                </tr>
                                 <%
										}else{
										
											System.out.println("No Record");
										}
                           		 %>
                         <%								
										}
									}					
						%>	 
                            </tbody>
                           
                        </table>
                        	<%
								}else{
							%>
					<div class="panel panel-primary">
                    <div class="panel-heading">
                      <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#cat-76">Exam List</a>
                      </h4>
                    </div>
                    <div id="cat-76" class="panel-collapse collapse in">
						<table class="table table-condensed table-striped" id="examList">
                            <thead>
                                <tr>
                                    <th width="10%">SL No.</th>
                                    <th width="20%">Exam Name</th>
                                    <th width="20%">Category</th>
                                    <th width="10%">Total Ques</th>
									<th width="20%">Begin Test</th>
									<th width="20%">Option</th>
									                                   
                                </tr>
                            </thead>
                        <%
							ExamBO examBO = new ExamBO();
							List<ExamVO> examVOList = examBO.getExamList();
							
						
							System.out.println("examvolist size..:" + examVOList.size());
							
							if(null != examVOList && examVOList.size() >0){
								int lineCount=0;
								for(int i=0; i < examVOList.size(); i++){
									
								ExamVO examVO = examVOList.get(i);
								String examId = examVO.getExamId();
								String examName = examVO.getExamName();
								String examCategory = examVO.getExamCategory();
								String catName = examVO.getCatName();
								String totQues = examVO.getTotQues();
								++lineCount;
								
						%>                            
                            <tbody>
                                <tr>
                                    <td><%=lineCount %></td>
                                    <td><%=examName %></td>
                                    <td><%=examCategory %></td>
                                    <td><%=totQues %></td>
                                    <td><a class="btn btn-primary" href="aboutExam.jsp?examId=<%=examId %>">Start</a></td>
                                    <td>
                                    	<a class="btn btn-primary" href="updateExam.jsp?examId=<%=examId %>&examName=<%=examName %>&examCategory=<%=examCategory %>">Edit</a>
                                    	<a class="btn btn-danger" href="../AddExam?operation=DEL&examId=<%=examId %>">Del</a>
                                    </td>
                                </tr>
                             <%								
										}
									}					
							%>	 
                            </tbody>
                        </table>
                       		 <%
								}
							%>
                    </div>
              </div>
	</div>
<div class="clear"></div>
<%@include  file="footer.html" %>
</div>
</body>
</html>