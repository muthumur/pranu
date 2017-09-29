<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.intellion.business.*"%>
    <%@ page import="com.intellion.vo.*"%>
    
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

<link rel="shortcut icon" href="stylesheet/img/devil-icon.png"> 
<link rel="stylesheet" type="text/css" href="..css/mos-style.css"> 
</head>

<body>
	<%
		//session = request.getSession(false);
		UserVO userProfile = (UserVO)session.getAttribute("userProfile");
		String Username = (String)session.getAttribute("Username");
		String role =(String)session.getAttribute("userRole");
		if(role.equalsIgnoreCase("Student")){ 	
	%>
<form>	
	<div id="leftBar">
		<ul>
			
			<li><a href="profile.jsp">My Profile</a></li>
			<li><a href="examList.jsp">Exam List</a></li>
			<li><a href="summaryReport.jsp">ExamSummary</a></li>
		
		</ul>
	</div>
		<% 
			}
		else{
		%>
	<div id="leftBar">
		<ul>
			<li><a href="">Dashboard2</a></li>
			<li><a href="addExam.jsp">Add Exam</a></li>
			<li><a href="examList.jsp">Exam List</a></li>
			<li><a href="addQues.jsp">Add Ques</a></li>
			<li><a href="searchQues.jsp">Sear Ques</a></li>
			
		</ul>
	</div>
		<%
			}
		%>
</form>
</body>
</html>