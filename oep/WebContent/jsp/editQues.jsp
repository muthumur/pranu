<%@page import="com.intellion.business.QuestionBO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page import="java.util.List"%>
    <%@ page import="com.intellion.business.ExamBO"%>
     <%@ page import="com.intellion.business.QuestionBO"%>
    <%@ page import="com.intellion.vo.*"%>
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
<script src="../js/jquery.js"></script>
<%
        String userStatus= (String) session.getAttribute("isUserActive");
        if(null == userStatus || (!"true".equalsIgnoreCase(userStatus))){
        	 response.sendRedirect("/OEP/jsp/login.jsp");
        }
		%>
<style>


#errorBoxQuesDesc{
	color:red;
}
#errorBoxOptA{
	color:red;
}
#errorBoxOptB{
	color:red;
}
#errorBoxOptC{
	color:red;
}
#errorBoxOptD{
	color:red;
}
#errorBoxAns{
	color:red;
}
</style>


</head>

<body>

<%@include  file="header.jsp" %>

<div id="wrapper">

	<%@include  file="leftbar.jsp" %>
	
	<div id="rightContent">
	<h3>Update Question</h3>
	
		<%
	
		
		String quesId="";
	 	QuestionBO quesBO = new QuestionBO();
	 	QuestionVO quesVO = null;
	 	quesId = (String)request.getParameter("quesId");
	 	
	 	%>
	 	
	 	
	 	
	 	<%
		String result =  (String)session.getAttribute("result");
	 	System.out.println("SECOND TIME:"+result);
   	    session.removeAttribute("result");
			if(null != result && "success".equalsIgnoreCase(result)){
				quesId = (String)session.getAttribute("quesId");
				quesVO = quesBO.getQuesDetailsById(quesId);
		%>
		<div class="title-block">
        <h3 class="title"><font color="red"><center>Question Updated Successfully</center></font><span class="sparkline bar" data-type="bar"></span> </h3>
          </div>  			        
			         
       <%
	     	}else{
	     		System.out.println("FIRST TIME");
	     		
	     		quesVO = quesBO.getQuesDetailsById(quesId);
	     	}
	   %>
	 	
	 	
	 	
	 	
	 	<%
	 	
	 	String examId=(String)quesVO.getExamId();
	 	String examCategory=(String)quesVO.getExamCategory();
	 	String examName = (String)quesVO.getExamName();
	 	
	 	quesId = (String)quesVO.getQuesId();
	 	
	 	String quesAns = (String)quesVO.getQuesAns().trim();
		
	 	System.out.println("...........quesId value :  "+ quesId);
	 	System.out.println("...........examId value : " + examId);
	 	System.out.println("...........quesAns value :  "+ quesAns);
    	
		

		
   	 	
	 	
   	    
   	    
		List<ExamVO> examNames = null;

		ExamBO examBO = new ExamBO();

		
		examNames = examBO.getExamNames();
		System.out.println("examList called...." + examNames);
				
	%>
					
		<c:set var="quesAns" value="<%=quesAns%>"></c:set>
	<form id="editquestion" method="POST" action="">
		<table width="95%">
		
			<tr><td width="125px"><b>Question Id</b></td><td><input type="text" class="pendek" name="quesid" id="quesid" value="<%=quesVO.getQuesId()%>" readonly ></td></tr><t>
			<input type="hidden" class="pendek" name="examId" id="examId" value="<%=quesVO.getExamId()%>" >
			<tr><td width="125px"><b>Exam Name</b></td><td><input type="text" class="pendek" name="examName" id="examName" value="<%=examName%>"  readonly></td></tr><t>
			<tr><td width="125px"><b>Category</b></td><td><input type="text" class="pendek" name="category" id="category" value="<%=examCategory%>"  readonly></td></tr><t>
			
			
		
			<div class="row">
			<tr>
				<td>
					<b>Question Description</b>
				</td>
				<td>
					<textarea rows="4" cols="10" name="ques_desc" id="ques_desc"  ><%=quesVO.getQuesDesc()%></textarea>
				</td>
				<td>
					<div  id="errorBoxQuesDesc"></div>
				</td>
			</tr>
			</div>
			
			<div class="row">
			<tr>
				<td>
					<b>Option</b>
				</td>
				<td>
					<input type="radio" name="radio" id="radio" value="a">a		<input type="text" class="ansoption" name="opt_a" id="opt_a" value="<%=quesVO.getQuesOpt1()%>"><div  id="errorBoxOptA"></div><br><br>
					<input type="radio" name="radio" id="radio" value="b">b		<input type="text" class="ansoption" name="opt_b" id="opt_b" value="<%=quesVO.getQuesOpt2()%>"><div  id="errorBoxOptB"></div><br><br>
					<input type="radio" name="radio" id="radio" value="c">c		<input type="text" class="ansoption" name="opt_c" id="opt_c" value="<%=quesVO.getQuesOpt3()%>"><div  id="errorBoxOptC"></div><br><br>
					<input type="radio" name="radio" id="radio" value="d">d		<input type="text" class="ansoption" name="opt_d" id="opt_d" value="<%=quesVO.getQuesOpt4()%>"><div  id="errorBoxOptD"></div>
				</td>
			</tr>
			</div>
			
			<div class="row"><tr><td><b>Answer</b></td><td>
				<select name="quesAns" id="quesAns">
					<option selected value="">Select Category</option>
					<option value="opt_a" ${quesAns eq 'opt_a' ?'selected':''}>opt_a</option>
					<option value="opt_b" ${quesAns eq 'opt_b' ?'selected':''}>opt_b</option>
					<option value="opt_c" ${quesAns eq 'opt_c' ?'selected':''}>opt_c</option>
					<option value="opt_d" ${quesAns eq 'opt_d' ?'selected':''}>opt_d</option>	
				</select>
			</td>
			<td>
				<div  id="errorBoxAns"></div>
			</td>
			</tr>
			</div>
			<pre>
			<tr><td></td><td>
			<input type="button" class="button" onclick="return onSubmit();" value="Update" style="float: right;"></td>
			<td><a href="searchQues.jsp" class="button1"  style="float: right; backgroundcolor: blue;color:white">Cancel</a>&nbsp;&nbsp;</td>
			</tr>
			</pre>
		</table>
	</form>
	</div>
<div class="clear"></div>
<%@include  file="footer.html" %>
</div>
<script>
function onSubmit(){
	 var validateFlag = validateUpdQues();
	 	
	 
	 	if(validateFlag == 'true'){
	 		document.forms["editquestion"].action="../AddQues?operation=UPD";
			document.forms["editquestion"].submit();
	 	}
}
	
	function validateUpdQues(){
		
		 var validFlag="true";
		
		 var ques_desc =  document.getElementById("ques_desc").value;
		 var opt_a =  document.getElementById("opt_a").value;
		 var opt_b =  document.getElementById("opt_b").value;
		 var opt_c =  document.getElementById("opt_c").value;
		 var opt_d =  document.getElementById("opt_d").value;
		
		 var ans =  document.getElementById("quesAns").value;
		 
		 
		 if(ques_desc == ""){
			
			 document.getElementById("errorBoxQuesDesc").innerHTML = "Please Enter the Ques Desc";
			 validFlag="false";
		 }else{
			
			 document.getElementById("errorBoxQuesDesc").innerHTML = "";
		 }
		 if(opt_a == ""){
			
			 document.getElementById("errorBoxOptA").innerHTML = "Please Enter the Opt_A";
			 validFlag="false";
		 }else{
			
			 document.getElementById("errorBoxOptA").innerHTML = "";
		 }
		 if(opt_b == ""){
			 
			 document.getElementById("errorBoxOptB").innerHTML = "Please Enter the Opt_B";
			 validFlag="false";
		 }else{
			 
			 document.getElementById("errorBoxOptB").innerHTML = "";
		 }
		 if(opt_c == ""){
			
			 document.getElementById("errorBoxOptC").innerHTML = "Please Enter the Opt_C";
			 validFlag="false";
		 }else{
			 
			 document.getElementById("errorBoxOptC").innerHTML = "";
		 }
		 if(opt_d == ""){
			 
			 document.getElementById("errorBoxOptD").innerHTML = "Please Enter the Opt_D";
			 validFlag="false";
		 }else{
			
			 document.getElementById("errorBoxOptD").innerHTML = "";
		 }
		 if(ans == ""){
			 
			 document.getElementById("errorBoxAns").innerHTML = "Please select the Answer";
			 validFlag="false";
		 }else{
			 document.getElementById("errorBoxAns").innerHTML = "";
		 }
			
		 return validFlag;
		 
	}
</script>
</body>
</html>