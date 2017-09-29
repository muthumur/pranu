<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
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
	<h2>Begin Test</h2>
	
	 <%
		
		String examId = (String)request.getParameter("examId");
	    String operation = (String)request.getParameter("operation");
	    String currentQuesNumber = "";
	    
	    
		QuestionVO quesVO = (QuestionVO)session.getAttribute("selectedQues");
		currentQuesNumber = (String)session.getAttribute("currentQuesNo");
		String totalQues = (String)session.getAttribute("totalQues");
		System.out.println(".....quesVO value:"+quesVO);
		System.out.println(".....currentQuesNumber value:"+currentQuesNumber);
		
		String quesId = "";
		String quesDesc ="";
		String opt1 = "";
		String opt2 = "";
		String opt3 = "";
		String opt4 = "";
		String CA = "";
		
		
		if(null == currentQuesNumber || currentQuesNumber.equalsIgnoreCase("")){
			currentQuesNumber="0";
		}
		int currentQuesNumberInt = Integer.parseInt(currentQuesNumber);
		
		if(null != quesVO){
			
			System.out.println(".....quesId value:"+quesVO.getQuesId());
			System.out.println(".....examId value:"+quesVO.getQuesId());
			


			 quesId = (String)quesVO.getQuesId();
			 quesDesc = (String)quesVO.getQuesDesc();
			 opt1 = (String)quesVO.getQuesOpt1();
			 opt2 = (String)quesVO.getQuesOpt2();
			 opt3 = (String)quesVO.getQuesOpt3();
			 opt4 = (String)quesVO.getQuesOpt4();
			 CA = (String)quesVO.getQuesAns();
		}
	
	%> 
			
			
	<form id="editquestion" method="POST" >
		<table width="95%">			
			<fieldset id="exam-question">
				<div id="container" style="float:right">
			<div id="countdown"></div>
			<script type="text/javascript" charset="utf-8">
			

		 	var countdown =  $("#countdown").countdown360({
       	 	radius      : 25,
         	seconds     : 5,
         	fontColor   : '#FFFFFF',
         	autostart   : false,
         	onComplete  : function (onSubmit) {
         		document.forms["editquestion"].action="../AddQues"; 
        		document.forms["editquestion"].submit();
        	}
		   });
			countdown.start();
			console.log('countdown360 ',countdown);
		 	/*$(document).on("click","button",function(e){
		 		e.preventDefault();
		 		var type = $(this).attr("data-type");
		 		if(type === "time-remaining")
		 		{
		 			var timeRemaining = countdown.getTimeRemaining();
		 			alert(timeRemaining);
		 		}
		 		else
		 		{
		 			var timeElapsed = countdown.getElapsedTime();
		 			alert(timeElapsed);
		 		}
		 	});*/
		  </script>
		</div>
				
			
					<h4> Question  <span id="question-index"><%=currentQuesNumber %></span> / <span id="question-count"><%=totalQues %></span></h4>	
                    <input type="hidden" name="examId" id="examId" value="<%=examId %>">
                    <input type="hidden" name="quesId" id="quesId" value="<%=quesId %>">
                     <input type="hidden" name="operation" id="operation" value="<%=operation %>">
                     <input type="hidden" name="CA" id="CA" value="<%=CA%>">
                    <textarea name="hide" style="display:line;height:auto" readonly><%=quesDesc%></textarea><br><br>
                     <h5>Options</h5>
                     	<div id="question-image" style="margin-bottom:10px; "></div>
                    		<div class="row">
                    			<ul id="answers" class="unstyled">
                    				
                    					<input type="radio" name="answer" id="answer" value="opt_a">
                    					<label for="answer_0" class="question_choice"><%=opt1%></label><br>
                    				
                    				
                    					<input type="radio" name="answer" id="answer" value="opt_b">
                    					<label for="answer_1" class="question_choice"><%=opt2%></label><br>
                    				
                    				
                    					<input type="radio" name="answer" id="answer" value="opt_c">
                    					<label for="answer_2" class="question_choice"><%=opt3%></label><br>
                    				
                    					<input type="radio" name="answer" id="answer" value="opt_d">
                    					<label for="answer_3" class="question_choice"><%=opt4%></label><br>
                    				
                    			</ul>&nbsp;
                    			                    			
                    			
                    		</div>
                </fieldset>
                			
			
			
			<pre>
				<tr>
					<td></td>
					<%
					if(currentQuesNumberInt > 1){
					
					%>
					<td>
						<a href="../AddQues?examId=<%=examId %>&operation=BACK" class="button1"  style="float: center; backgroundcolor: blue;color:white"" >BACK</a>
					</td>
					<%
					}
					
					else{
						
					%>
					<td>
						<a href="examList.jsp" class="button1"  style="float: center; backgroundcolor: red;color:white"" >CANCEL</a>
					</td>
					<%
					}
					%>
					<td>
						
						<input type="button" onclick="return onSubmit();" value="<%=operation %>" class="button1"  style="float: center; backgroundcolor: blue;color:white" >&nbsp;&nbsp;
						
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
	
	document.forms["editquestion"].action="../AddQues"; 
	document.forms["editquestion"].submit();	
}
</script>
</body>
</html>