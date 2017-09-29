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
<style>
#errorBoxExamName{
	color:red;
}
</style>
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
	<h3>Search Question</h3>
	
		<%
		
		
		
		List<ExamVO> examNames = null;

		ExamBO examBO = new ExamBO();

		examNames = examBO.getExamNames();
		System.out.println("examList called...." + examNames);
			
		
			
		%>
		
		
	<form id="searchquestion" method="POST" action="/OEP/SearchQues">
		<table width="95%">
		
			
			<div class="row">
			<tr>
				<td>
					<b>Exam</b>
				</td>
				<td>
					<select name="examname" id="examname">
					<option selected value="">Select Exam</option>
						<%
										for (int i = 0; i < examNames.size(); i++) {
						%>
						<option value="<%=((ExamVO) examNames.get(i)).getExamId()%>"><%=((ExamVO) examNames.get(i)).getExamName()%></option>
						<%
								}
						%>
					</select>
				</td>
				<td>
					<div  id="errorBoxExamName"></div>
				</td>
			</tr>
			</div>
			
			
			<tr>
			<td>
			</td>
			
			
			
			<td>
				<input type="submit" class="btn btn-primary" onclick="return onSubmit();" value="Submit" style="float: center;">&nbsp;&nbsp;
				<a href="searchQues.jsp" class="btn btn-danger" style="backgroundcolor: blue;color:white">Cancel</a>&nbsp;&nbsp;
			</td>
			</tr>
			
		</table>
		</form>
		
		 
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
                              	    <th width="5%">Ques ID</th>
									<th width="20%">Ques Name</th>
									<th width="15%">Opt 1</th>
									<th width="15%">Opt 2</th>
									<th width="15%">Opt 3</th>
									<th width="15%">Opt 4</th>
									<th width="5%">Answer</th>
									<th width="10%">Option</th>
                                </tr>
                                
                            </thead>
                         
                            <%
			        	 if(null != session.getAttribute("quesList")){ 
			        		
			        	
			        	List<QuestionVO> quesList =  (List)session.getAttribute("quesList");
			            String examid = (String)quesList.get(0).getExamId();
                        String quesid  =(String)quesList.get(0).getQuesId();
                        
			        	
                        
                        System.out.println("question list size..:" + quesList.size());
						
						if(null != quesList && quesList.size() >0){
							
							for(int i=0; i < quesList.size(); i++){
								
							QuestionVO questionVO = quesList.get(i);
							String shortQues = null;
							String shortOpt1 = null;
							String shortOpt2 = null;
							String shortOpt3 = null;
							String shortOpt4 = null;
							String quesId = questionVO.getQuesId();
							String quesDesc = questionVO.getQuesDesc();
							if(quesDesc.length()>20){
								shortQues = quesDesc.substring(0, 20);
								System.out.println("ShortQues..........."+shortQues);
							}else{
								quesDesc = questionVO.getQuesDesc();
								System.out.println("quesopt1.......In loop:"+quesDesc);
							}
							
							
							String quesopt1 = questionVO.getQuesOpt1();
							if(quesopt1.length()>20){
								shortOpt1 = quesopt1.substring(0,15);
								System.out.println("shortOpt1..........."+shortOpt1);
							}else{
								quesopt1 = questionVO.getQuesOpt1();
								System.out.println("quesopt1.......In loop:"+quesopt1);
							}
							
							
							String quesopt2 = questionVO.getQuesOpt2();
							if(quesopt2.length()>20){
								shortOpt2 = quesopt2.substring(0,15);
								System.out.println("shortOpt2..........."+shortOpt2);
							}else if(quesopt2.length()<20){
								quesopt2 = questionVO.getQuesOpt2();
							}
							
							
							String quesopt3 = questionVO.getQuesOpt3();
							if(quesopt3.length()>20){
								shortOpt3 = quesopt3.substring(0,15);
								System.out.println("shortOpt3..........."+shortOpt3);
							}else if(quesopt3.length()<20){
								quesopt3 = questionVO.getQuesOpt3();
							}
							
							
							String quesopt4 = questionVO.getQuesOpt4();
							if(quesopt4.length()>20){
								shortOpt4 = quesopt4.substring(0,15);
								System.out.println("shortOpt4..........."+shortOpt4);
							}else if(quesopt4.length()<20){
								quesopt4 = questionVO.getQuesOpt4();
							}

							String quesAns = questionVO.getQuesAns();
							                        
			        %>	 
	
		
                            <tbody>
                                <tr>
                                
                                	<td><%=quesId %></td>
									<%
										if(quesDesc.length()>20){
									%>
									<td><%=shortQues %></td>
									<%
										}else{
									%>
									<td><%=quesDesc %></td>
									<%
										}
									%>
									
									<%
										if(quesopt1.length()>20){
									%>
									<td><%=shortOpt1 %></td>
									<%
										}else{
									%>
									<td><%=quesopt1 %></td>
									<%
										}
									%>
									
									<%
										if(quesopt2.length()>20){
									%>
									<td><%=shortOpt2 %></td>
									<%
										}else{
									%>
									<td><%=quesopt2 %></td>
									<%
										}
									%>
									
									<%
										if(quesopt3.length()>20){
									%>
									<td><%=shortOpt3 %></td>
									<%
										}else{
									%>
									<td><%=quesopt3 %></td>
									<%
										}
									%>
									
									<%
										if(quesopt4.length()>20){
									%>
									<td><%=shortOpt4 %></td>
									<%
										}else{
									%>
									<td><%=quesopt4 %></td>
									<%
										}
									%>
									<td><%=quesAns %></td>
									<td>
									<a class="btn btn-primary" href="editQues.jsp?quesId=<%=quesId %>">Edit</a>&nbsp;
                             	</tr>
                             	<%	
                                
							}
						}
    					session.removeAttribute("quesList");
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
<script>
function onSubmit(){
	
		 var validateFlag = validateSearchQues();

		 if(validateFlag == 'true'){
		 		 return true;
		 	}else{
		 		return false;
		 	} 
		 	
}
	 	
function validateSearchQues(){
				
			 var validFlag="true";
			
			 var examname =  document.getElementById("examname").value;	
			 
			 if(examname == ""){
				 
				 document.getElementById("errorBoxExamName").innerHTML = "Please select the Exam Name";
				 validFlag="false";
			 }else{
				 document.getElementById("errorBoxExamName").innerHTML = "";
			 }
				
			 return validFlag;
			 
}
</script>
</body>
</html>