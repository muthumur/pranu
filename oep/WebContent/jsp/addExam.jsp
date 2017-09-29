<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page import="com.intellion.business.ExamBO"%>
    <%@ page import="com.intellion.vo.*"%>
<%@ page import="java.util.List"%>
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

#errorBoxCat{
	color:red;
}

</style>

</head>

<body>
<%@include  file="header.jsp" %>

<div id="wrapper">
	
	<%@include  file="leftbar.jsp" %>
	
	<div id="rightContent">
	<h3><strong>Add Exam</strong></h3>
	<%
			ExamBO examBO = new ExamBO(); 
			int examIdMax = examBO.getExamIDMax();
			examIdMax++;
			
			
			List<ExamVO> catNames = null;
			catNames = examBO.getCategoryNames();
			System.out.println("examList called...." + catNames);
			
	%>
		
	<form id="exam" method="post" action="../AddExam?operation=ADD">
		<table width="95%">
		
			<tr><td width="125px"><b>Exam Id</b></td><td><input type="text" class="pendek" name="examid" id="examid" value="<%=examIdMax %>" readonly></td></tr><t>
			<div class="row"><tr><td width="125px"><b>Exam Name</b></td><td><input type="text" class="sedang" name="examname" id="examname"></td><td><div  id="errorBoxExamName"></div></td></tr></div>
			<div class="row"></div><tr><td><b>Category</b></td><td>
				<select name="category" id="category">
					<option selected value="">Select Category</option>
					<%
										for (int i = 0; i < catNames.size(); i++) {
						%>
						<option value="<%=((ExamVO) catNames.get(i)).getCatId()%>"><%=((ExamVO) catNames.get(i)).getCatName()%></option>
						<%
								}
						%>
				</select>
			</td><td><div  id="errorBoxCat"></div></td></tr></div>
			<pre>
			<tr><td></td><td>
			<input type="submit" class="button" onclick="return onSubmit();" value="Submit" style="float: right;">&nbsp;&nbsp;</td>
			<td><a href="addExam.jsp" class="button1"  style="float: right;color:white; backgroundcolor: blue;" >Cancel</a>&nbsp;&nbsp;</td>
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
	 var validateFlag = validateAddExam();
	 	
	 
	 	if(validateFlag == 'true'){
	 		//document.forms["exam"].action="../AddExam?operation=ADD";
			//document.forms["exam"].submit();
			
			return true;
	 	}else{
	 		
	 		return false;
	 	}
}

function validateAddExam(){
	
	 var validFlag="true";
	 var examname =  document.getElementById("examname").value;
	 var category =  document.getElementById("category").value;
	 
	 if(examname == ""){
		 document.getElementById("errorBoxExamName").innerHTML = "Please Enter the Exam Name";
		 validFlag="false";
	 }else{
		 document.getElementById("errorBoxExamName").innerHTML = "";
	 }
	 
	 if(category == ""){
		 document.getElementById("errorBoxCat").innerHTML = "Please select the Category";
		 validFlag="false";
	 }else{
		 document.getElementById("errorBoxCat").innerHTML = "";
	 }
	 
		return validFlag;
		 
	}


</script>
</body>
</html>