<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page import="com.intellion.business.ExamBO"%>
    <%@ page import="com.intellion.vo.*"%>
<%@ page import="java.util.List"%>
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
	<h3><strong>Update Exam</strong></h3>
	<%
			ExamBO examBO = new ExamBO(); 
			ExamVO examVO = new ExamVO(); 
			int i=0;
			String examId = request.getParameter("examId");
			System.out.println("ExamId in update exam: "+examId);
			String examName = request.getParameter("examName");
			String examCategory = request.getParameter("examCategory");
			System.out.println("examCategory in update exam: "+examCategory);
			
			ExamVO examDetails = examBO.getExamDetailsById(examId);
		 	String catId=(String)examDetails.getExamCategory();
		 	System.out.println(".......catId:"+catId);
			
			List<ExamVO> catNames = null;
			catNames = examBO.getCategoryNames();
			System.out.println("examList called...." + catNames);
			
			
	%>
	<c:set var="catId" value="<%=catId %>"></c:set>    
		
	<form id="exam" method="post" action="../AddExam?operation=UPD">
		<table width="95%">
		
			<tr>
			<td width="125px">
				<b>Exam Id</b>
			</td>
			<td>
				<input type="text" class="pendek" name="examid" id="examid" value="<%=examId %>" readonly>
			</td>
			</tr>
			
			<div class="row">
			<tr>
				<td width="125px">
					<b>Exam Name</b>
				</td>
				<td>
					<input type="text" class="sedang" name="examname" id="examname"  value="<%=examName %>" >
				</td>
				<td>
					<div id="errorBoxExamName"></div>
				</td>
			</tr>
			</div>
			
			<div class="row">
			<tr>
				<td>
					<b>Category</b>
				</td>
				<td>
				<select name="category" id="category">
					<option select value="">Select Category</option>
						<%
										for (i = 0; i < catNames.size(); i++) {
											String locCatId=((ExamVO)catNames.get(i)).getCatId();
						%>
						
						<c:set var="locCatId" value="<%=locCatId %>"></c:set>
						<option value="<%=locCatId %>" ${locCatId  eq catId ?'selected':''}> <%=((ExamVO)catNames.get(i)).getCatName()%> </option> 
						<%
								}
						%>					
					
				</select>
				</td>
				<td>
					<div id="errorBoxCat"></div>
				</td>
			</tr>
			</div>
			
			<pre>
			<tr>
			<td></td>
			<td>
				<input type="submit" class="button" onclick="return onSubmit();" value="Update" style="float: right;">&nbsp;
			</td>
			<td>
				<a href="examList.jsp" class="button1"  style="float: right;color:white; backgroundcolor: blue;" >Cancel</a>&nbsp;&nbsp;
			</td>
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