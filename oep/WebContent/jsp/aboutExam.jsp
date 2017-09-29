<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page import="com.intellion.business.QuestionBO"%>
     <%@ page import="com.intellion.vo.*"%>
    <%@ page import= "java.util.ArrayList"%>
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

<%@include  file="header.jsp" %>

<div id="wrapper">

	<%@include  file="leftbar.jsp" %>
	 																		
	<div id="rightContent">
	<h2>About Exam</h2>
	
	<%
		QuestionBO quesBO = new QuestionBO();
		String examId = (String)request.getParameter("examId");
		
		List<QuestionVO> quesList = quesBO.getQuesDetails(examId);
		int quesListSize = 0;
		
		if(null != quesList && quesList.size() > 0){
			quesListSize = quesList.size();
		}
	
	%> 
		
	
	 			
	<form id="about_exam" method="POST">
			<div class="row">
        

                      <div class="panel panel-default" style="background:#f2f8fb">
                        <div class="panel-body">
                        <table>
                            <thead>
                                <tr>
                                    <th width="5%"></th>
                                    <th width="80%"></th>
                                </tr>
                            </thead>
                            <tbody>
                               <tr>
                                    <td></td>
                                    <td><li><strong>4</strong> multiple choice questions</li></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td><li><strong>20</strong> minutes exam time</li></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td><li><strong>50%</strong> mark is needed to pass</li></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td><li><strong>$ 0.00</strong> is required to take this exam</li></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td><li>Total number of questions :<strong><%=quesListSize%></strong></li></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <br>
                                        <ol>
                                                <li>Attempt all the questions.</li>
                                                <li>Do not use the browser back button while doing this test.</li>
                                                <li>The timer of the exam will not stop once the exam starts.</li>
                                                <li><strong>IMPORTANT!</strong> Remember to click the 'Finish Exam' link at the bottom of the page once you complete the whole exam. Clicking this link before you finish the whole exam will end your exam session.</li>
                                        </ol>
                                    </td>
                                </tr>
                                <tr>
                                        <td> <a class="btn btn-danger" href="examList.jsp">Cancel</a> </td>
                                    <td><p>
                  <%
                  if(quesListSize > 0){
                	  %>
                	  <a class="btn btn-success pull-right" href="../AddQues?examId=<%=examId %>&operation=START">Start Exam</a>
                	  <% 
                	  
                  		}else{
                	  
                	  %>
                	  <a class="btn btn-success pull-right" href="/OEP/jsp/addQues.jsp">Add Question</a>
                 
                  <%} %>
                  
                                  
                                     </p></td>
                                    
                                </tr>
                                                            
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
	/* document.forms["question"].action=""; */
	document.forms["editquestion"].submit();	
}
</script>
</body>
</html>