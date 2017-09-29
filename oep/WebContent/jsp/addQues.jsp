<%@page import="com.intellion.business.QuestionBO"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page import="java.util.List"%>
    <%@ page import="com.intellion.business.ExamBO"%>
    <%@ page import="com.intellion.vo.*"%>

    
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
<%
        String userStatus= (String) session.getAttribute("isUserActive");
        if(null == userStatus || (!"true".equalsIgnoreCase(userStatus))){
        	 response.sendRedirect("/OEP/jsp/login.jsp");
        }
		%>
<style>
#errorBoxExamName{
	color:red;
}

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
	<h3>Add Question</h3>
	
		<%
		QuestionBO quesBO = new QuestionBO(); 
		int quesIdMax = quesBO.getQuestionIDMax();
		quesIdMax++;
		
		String quesAddresult =  (String)session.getAttribute("quesAddresult");
   	    session.removeAttribute("quesAddresult");
		
		List<ExamVO> examNames = null;

		ExamBO examBO = new ExamBO();
		ExamVO examVO = new ExamVO();

		examNames = examBO.getExamNames();
		System.out.println("deptList called...." + examNames);
		
		List<ExamVO> catNames = null;
		catNames = examBO.getCategoryNames();
		System.out.println("examList called...." + catNames);
			
		if(null != quesAddresult && "success".equalsIgnoreCase(quesAddresult)){
			
		%>
		<!-- <div class="title-block"> -->
			
                        <h3 class="title"><font color="red"><center>Question Added Successfully</center></font><span class="sparkline bar" data-type="bar"></span> </h3>
                   <!--  </div>  	 -->		        
			         
			        <%
			        	}
			        %>
		
	<form id="addquestion" method="POST" action="">
		<table width="95%">
		
			<tr>
				<td width="125px">
					<b>Question Id</b>
				</td>
				<td>
					<input type="text" class="pendek" name="quesid" id="quesid" value="<%=quesIdMax%>" readonly>
				</td>
			</tr>
			
			<div class="row">
			<tr>
				<td>
					<b>Exam</b>
				</td>
				<td>
					<select name="exam_id" id="exam_id">
					<option selected value="">Select Exam</option>
					<%
									for (int i = 0; i < examNames.size(); i++) {
					%>
					<option value="<%=((ExamVO) examNames.get(i)).getExamId()%>"><%=((ExamVO) examNames.get(i)).getExamName()%></option>
					<%
							}
					%>
					</select>
				</td><br>
				<td>
					<div id="errorBoxExamName"></div>
				</td>
			</tr>
			</div>
			
			<%--  <tr>
				<td>
					<b>Category</b>
				</td>
				<td>
				<select name="category" id="category">
					<option selected>Select Category</option>
					<%
										for (int i = 0; i < catNames.size(); i++) {
						%>
						<option value="<%=((ExamVO) catNames.get(i)).getCatId()%>"><%=((ExamVO) catNames.get(i)).getCatName()%></option>
						<%
								}
						%>
				</select>
				</td>
			</tr>   --%>
			<div class="row"><tr><td><b>Question Description</b></td><td><textarea rows="4" cols="10" name="ques_desc" id="ques_desc"></textarea><td><div  id="errorBoxQuesDesc"></div></td></td></tr></div>
			
			<div class="row">
			<tr>
				<td>
					<b>Option</b>
				</td>
				<td>
					<input type="radio" name="radio" id="radio" value="a">a		<input type="text" class="ansoption" name="opt_a" id="opt_a"><div  id="errorBoxOptA"></div><br><br>
					<input type="radio" name="radio" id="radio" value="b">b		<input type="text" class="ansoption" name="opt_b" id="opt_b"><div  id="errorBoxOptB"></div><br><br>
					<input type="radio" name="radio" id="radio" value="c">c		<input type="text" class="ansoption" name="opt_c" id="opt_c"><div  id="errorBoxOptC"></div><br><br>
					<input type="radio" name="radio" id="radio" value="d">d		<input type="text" class="ansoption" name="opt_d" id="opt_d"><div  id="errorBoxOptD"></div>
				</td>
			</tr>
			</div>
			<div class="row">
			<tr>
				<td><b>Answer</b></td><td>
				<select name="ans" id="ans">
					<option selected value="">Select Option</option>
					<option value="opt_a">a</option>
					<option value="opt_b">b</option>
					<option value="opt_c">c</option>
					<option value="opt_d">d</option>
				</select>
				</td>
				<td>
				<div  id="errorBoxAns"></div>
				</td>
			</tr>
			</div>
			
			<tr><td></td><td>
			<input type="button" class="button" onclick="onSubmit();" value="Add" style="float: right;">&nbsp;&nbsp;</td>
			<td><a href="addQues.jsp" class="button1"  style="float: right;color:white; backgroundcolor: blue;" >Cancel</a>&nbsp;&nbsp;</td>
			</tr>
			
		</table>
	</form>
	</div>
<div class="clear"></div>
<%@include  file="footer.html" %>
</div>
<script>

	function onSubmit(){
	 var validateFlag = validateAddQues();
	 	
	 
	 	if(validateFlag == 'true'){
	 		document.forms["addquestion"].action="../AddQues?operation=ADD";
			document.forms["addquestion"].submit();
		
	 	}
}
	
	function validateAddQues(){
		
		 var validFlag="true";
		
		 var exam_id =  document.getElementById("exam_id").value;
		 var ques_desc =  document.getElementById("ques_desc").value;
		 var opt_a =  document.getElementById("opt_a").value;
		 var opt_b =  document.getElementById("opt_b").value;
		 var opt_c =  document.getElementById("opt_c").value;
		 var opt_d =  document.getElementById("opt_d").value;
		
		 var ans =  document.getElementById("ans").value;
		 
		 if(exam_id == ""){
			
			 document.getElementById("errorBoxExamName").innerHTML = "Please Enter the Exam Name";
			 validFlag="false";
		 }else{
			 
			 document.getElementById("errorBoxExamName").innerHTML = "";
		 }
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
	
 	/* function getDeptDetailsJS(obj){

		var examId=obj;
		$('#exam_id').val(examId);
		
		var urlVal = '../ActionServlet?examId='+examId;
				//alert(urlVal);
		$.ajax({
			 
	        type: "GET",
	                    //url: "../ActionServlet?boTYPE=nurse&nurseId="+nurseId,
	                    		url: urlVal,
	                    dataType: 'json',
	                    success : function(json) {

	                        //alert("success");
	                        var info1=json.JsonData;
	                    	$.each(info1, function(key, value) { 
	                    		              
	                    	if(key=='examId'){ 
	                    		//alert(value);
	                    		$('#exam_id').val(value);
	                    	
	                    	}else if(key=='category'){ 
	                    		//alert(value);
	                    		$('#category').val(value);
	                    		
	                    	}
		                        
	                    	}
	                    	
	                    	                   
	                    		                    );
	                      
	                      
	                    },
	                    async: false,
	                    global: false,
	                    error: function () {
	                       alert("Errr is occured");
	                    }
	                });	
		
		
		
	} 
	                    		 */
		                    	
		                        
	                    	
	
	
</script>
</body>
</html>