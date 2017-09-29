<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
     <%@ page import="com.intellion.business.QuestionBO"%>
     <%@ page import="com.intellion.vo.*"%>
     <%@ page import= "java.util.ArrayList"%>
     <%@ page import= "java.util.Iterator" %>
     <%@ page import= "java.util.List"%>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>OEP</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Copyright" content="arirusmanto.com">
<meta name="description" content="Admin MOS Template">
<meta name="keywords" content="Admin Page">
<meta name="author" content="Ari Rusmanto">
<meta name="language" content="Bahasa Indonesia">

<link rel="shortcut icon" href="stylesheet/img/devil-icon.png"> 
<link rel="stylesheet"  href="../css/mos-style.css">
<link rel="stylesheet"  href="../css/app.css"> 
<link rel="stylesheet"  href="../css/vendor.css"> 
<link rel="stylesheet"  href="../css/bootstrap.min.css"> 
<script src="../js/jquery.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script src="../js/jquery.countdown360.js" type="text/javascript" charset="utf-8"></script>
<%
        String userStatus= (String) session.getAttribute("isUserActive");
        if(null == userStatus || (!"true".equalsIgnoreCase(userStatus))){
        	 response.sendRedirect("/OEP/jsp/login.jsp");
        }
		%>
</head>
<body>

<%
	
	ResultBO resultBO = new ResultBO();
	ResultVO resultVO = new ResultVO();
	
	ResultVO res = null;
	String examName = null;
	String userAns = null;
	String quesDesc = null;
	String isAnsCorrect = null;
	String correctAns = null;
	String quesId = null;
	float isAnsCorrectCount = 0;
	float attemptedPercentage = 0;
	float totalQuestions = 0;
	float attemptedCount = 0;
	float status=0;
	float correctAnsPerc=0;
	float wrongAnsPerc = 0;
	float isAnsWrongCount = 0;
	int quesDescCount = 0;
	
	String examId = (String)request.getParameter("examId");
	String userName = (String)request.getParameter("userName");
	
	List<ResultVO> resultVOList = resultBO.getExamSummaryByUserNameExamId(userName, examId);
	
	if(null != resultVOList){
		
		for (int i = 0; i < resultVOList.size(); i++) {

			System.out.println(resultVOList.get(i));
			res = (ResultVO)resultVOList.get(i);
			
		    examName = (String)res.getExamName();
			isAnsCorrect = (String)res.getIsAnsCorrect();
			userAns  = (String)res.getUserAnswer();
			
			isAnsCorrect = (String)res.getIsAnsCorrect();
			
			if(null != isAnsCorrect && isAnsCorrect.equalsIgnoreCase("Y")){
				++isAnsCorrectCount;
			}
			
			if(null != isAnsCorrect && isAnsCorrect.equalsIgnoreCase("N")){
				++isAnsWrongCount;
			}
			
			if(null != userAns && userAns.length() > 0){
				++attemptedCount;
			}
			
		} 
		
		totalQuestions = resultVOList.size();
		
		System.out.println("totalQuestions:"+totalQuestions);
		System.out.println("isAnsCorrectCount:"+isAnsCorrectCount);
		System.out.println("attemptedCount:"+attemptedCount);
		System.out.println("isAnsWrongCount:"+isAnsWrongCount);
		System.out.println("quesDescCount:"+quesDescCount);
	}
		
	attemptedPercentage = (attemptedCount/totalQuestions)*100;
	correctAnsPerc = (isAnsCorrectCount/totalQuestions)*100;
	//wrongAnsPerc = attemptedPercentage-correctAnsPerc;
	wrongAnsPerc = (isAnsWrongCount/totalQuestions)*100;
	status = correctAnsPerc;
	
	System.out.println("wrongAnsPerc:"+wrongAnsPerc);
	System.out.println("attemptedPercentage:"+attemptedPercentage);
	System.out.println("correctAnsPerc:"+correctAnsPerc);
	 
	 
%>

<%@include  file="header.jsp" %>

<div id="wrapper">

	<%@include  file="leftbar.jsp" %>
	 																		
	<div id="rightContent">
	<h2>Detailed Report</h2>
	
	<form id="about_exam" method="POST" action="../AddQues">
			<div class="container middlecontent">
	<div class="row">
	
	<div class="col-lg-10">
		<h4>Exam Results Summary</h4>
		<div class="hline"></div>
		<br>
	</div>
	</div>
    	<div class="panel panel-primary">
    		<div class="panel-heading">Exam Information</div>
    		<div class="panel-body">
    			<table class="table table-striped">
    				<tbody><tr><td width="20%">Name</td><td><%=examName %></td> </tr>
    				<tr><td>Description</td><td>Java</td> </tr>
    				<tr><td>Duration</td><td><span class="btn btn-sm btn-success">20 Minutes</span> </td> </tr>
    				<tr><td>Questions</td><td><span class="btn btn-sm btn-success"><%= totalQuestions %></span> </td> </tr>
    				<tr><td>Pass Mark</td><td><span class="btn btn-sm btn-success">50 %</span> </td> </tr>
    			</tbody></table>
    		</div>
    	</div>
    	<div class="panel panel-primary">
    		<div class="panel-heading">Results Summary</div>
    		<div class="panel-body">
    			<label>Attempted <%=attemptedCount %>/<%=totalQuestions %></label>
				<div class="progress">
				    <div class="progress-bar progress-bar-info" style="width: <%=attemptedPercentage %>%;">
				        <span class="sr-only"></span>
				    </div>
				</div>
				<label>Answered correctly <%=isAnsCorrectCount %>/<%=totalQuestions %></label>
				<div class="progress">
				    <div class="progress-bar progress-bar-success" style="width: <%=correctAnsPerc %>%;">
				        <span class="sr-only"></span>
				    </div>
				</div>
				<label>Answered wrongly <%=isAnsWrongCount %>/<%=totalQuestions %></label>
				<div class="progress">
				    <div class="progress-bar progress-bar-danger" style="width: <%=wrongAnsPerc %>%;">
				        <span class="sr-only"></span>
				    </div>
				</div>

				<!-- <label>Duration Taken 0 minutes 23 seconds </label>
								<div class="progress">
				    <div class="progress-bar progress-bar-warning" style="width: 0%;">
				        <span class="sr-only"></span>
				    </div>
				</div> -->

				<label>Results Status</label>
				<%
					if(status < 50){
				%>
				
				<p><span class="btn btn-danger">
				Failed</span></p>
				<%
					}else{
				%>
				<p><span class="btn btn-primary">
				Passed</span></p>
				<%
					}
				%>
    		</div>
    	</div>
    			<%
						List<ResultVO> questVOList = resultBO.getQuesList(examId,userName);

						System.out.println("questVOList size..:" + questVOList.size());
				%>
    	
    	
    	
    	<div class="panel panel-primary">
    		<div class="panel-heading">Failed Questions</div>
    		<div class="panel-body">
    			<table class="table table-striped table-bordered">
    				<thead>
    					<tr><th width="10%">SL No.</th>
    					<th>Question</th>
    					<th>User Name</th>
    					<th width="5%">Marks</th>
    					</tr>
    				</thead>
    				<tbody>
    					<%
									if (null != questVOList && questVOList.size() > 0) {
										int lineCount = 0;
									for (int i = 0; i < questVOList.size(); i++) {

									ResultVO questVO = (ResultVO) questVOList.get(i);
									++lineCount;
						%>
						<% int l = 1; %>
       				<tr>
						<td class="data" width="30px"><%=lineCount%></td> 
						<td class="data"><%=questVO.getQuesDesc()%></td>
						<td class="data"><%=questVO.getUserName()%></td>
    					<td>1</td>
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
</form>
</div>
<div class="clear"></div>
<%@include  file="footer.html" %>
</div>
<script>
function onSubmit(){
	alert("called");
	document.forms["about_exam"].submit();	
}
</script>
</body>
</html>