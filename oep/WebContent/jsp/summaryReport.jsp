<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page import="com.intellion.business.ExamBO"%>
<%@ page import="com.intellion.business.QuestionBO"%>
<%@ page import="com.intellion.business.ResultBO"%>
<%@ page import="com.intellion.business.StudentResultBO"%>
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
			<div class="panel panel-primary">
                    <div class="panel-heading">
                      <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#cat-76">Summary Report</a>
                      </h4>
                    </div>
                    <div id="cat-76" class="panel-collapse collapse in">
                      <table class="table table-condensed table-striped">
                            <thead>
                                <tr>
                                    <th width="15%">SL No.</th>
                                    <th width="25%">Exam Name</th>
                                    <th width="25%">Category</th>
                                    <th width="15%">Total Ques</th>
									<th width="20%">Detailed Report</th>
									                                   
                                </tr>
                            </thead>
                            <%
							
							
								UserVO userProfile1 = (UserVO)session.getAttribute("userProfile");
						        System.out.println( userProfile1); 
						        String userName = (String)userProfile1.getUserName();
						        System.out.println( userName); 
						        
							
								ResultBO resultBO = new ResultBO();
								ResultVO resultVO = new ResultVO();
								
								int i = 0;
								String examId  = null;
								String examName = null;
								ResultVO res = null;
								String isAnsCorrect = null;
								String correctAns = null;
								String quesId = null;
								float isAnsCorrectCount = 0;
								float totalQuestions = 0;
								float attemptedCount = 0;
								float status=0;
								float correctAnsPerc=0;
								int quesDescCount = 0;
								
							%>
							
							
							<%
								List<ResultVO> resultVOList = resultBO.getExamSummaryByUserNameExamId(userName, examId);
								
								if(null != resultVOList){
									
									for (i = 0; i < resultVOList.size(); i++) {

										System.out.println(resultVOList.get(i));
										res = (ResultVO)resultVOList.get(i);
										
									    examName = (String)res.getExamName();
										isAnsCorrect = (String)res.getIsAnsCorrect();
										
										isAnsCorrect = (String)res.getIsAnsCorrect();
										
										if(null != isAnsCorrect && isAnsCorrect.equalsIgnoreCase("Y")){
											++isAnsCorrectCount;
										}
									} 
									
									totalQuestions = resultVOList.size();
									
									System.out.println("totalQuestions:"+totalQuestions);
									System.out.println("isAnsCorrectCount:"+isAnsCorrectCount);
								}
									
								correctAnsPerc = (isAnsCorrectCount/totalQuestions)*100;
								status = correctAnsPerc;
								
								System.out.println("correctAnsPerc:"+correctAnsPerc);
								
							%>
	
	
							<%
								StudentResultBO studBO = new StudentResultBO();

								List<StudentResultVO> studVOList = studBO.getStudentSummaryByUserName(userName);
								
								System.out.println("studVOList size..:" + studVOList.size());
								
								if(null != studVOList && studVOList.size() >0){
									int lineCount=0;
									for(i=0; i < studVOList.size(); i++){
										
								StudentResultVO studVO = studVOList.get(i);
								examId = studVO.getExamId();
								examName = studVO.getExamName();
								String examCategory = studVO.getExamcategory();
								String catName = studVO.getCatName();
								String totQues = studVO.getTotQues();
								++lineCount;
								
							%>
                            
                            <tbody>
                                <tr>
                                    <td><%=lineCount %></td>
                                    <td><%=examName %></td>
                                    <td><%=catName %></td>
                                    <td><%=totQues %></td>
                                    <td><a class="btn btn-primary" href="detailedReport.jsp?userName=<%=userName %>&examId=<%=examId %>">Report</a></td>
                                </tr>
                             <%								
										}
									}					
							%>	 
                            </tbody>
                        </table>
                    </div>
              </div>
	</div>
<div class="clear"></div>
<%@include  file="footer.html" %>
</div>
</body>
</html>