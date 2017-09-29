<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    
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
<style>
#errorBoxPwd{
	color:red;
}
#errorBoxEmail{
	color:red;
}

#errorBoxMob{
	color:red;
}
</style>
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
	<h3><strong>My Profile</strong></h3>
		<%
					
		               
			        	UserVO userProfile1 = (UserVO)session.getAttribute("userProfile");
			        	System.out.println( userProfile1); 
			            String username1 = (String)userProfile1.getUserName();
			            System.out.println( username1); 
                        String userPassword  =(String)userProfile1.getUserPassword();
                        System.out.println( userPassword); 
                        String userEmail = (String)userProfile1.getUserEmail();
                        System.out.println( userEmail); 
                        String userMobile  =(String)userProfile1.getUserMobile();
			        	
                        
                        System.out.println("Profile list size..:" + userProfile1); 
						
			        	 
			        	
	     %>
	     <form id="profile" method="post" action="../AddUser?operation=UPD">
	      <%
								String result =  (String)session.getAttribute("result");
								session.removeAttribute("result");
					       	     System.out.println("session called...."+result);
					       	 
					       	     if(null != result && "updated".equalsIgnoreCase(result)){
								
		  %>
         <div>
             <h4 class="title"><font color="#449B1D"><center>Profile Updated Successfully</center></font> </h4>
         </div>  
          <%
			  	}
	      %>
	      
	      <table width="70%">
		
			<tr><td width="125px"><b>Username</b></td><td><input type="text" class="sedang" name="username" id="username" value="<%=username1 %>" readonly></td></tr><t>
			<div class="row"><tr><td width="125px"><b>Password</b></td><td><input type="text" class="sedang" name="password" id="password" value="<%=userPassword %>" ></td><td><div  id="errorBoxPwd"></div></td></tr><t>
			<div class="row"><tr><td width="125px"><b>Email</b></td><td><input type="text" class="sedang" name="email" id="email" value="<%=userEmail %>" ></td><td><div  id="errorBoxEmail"></div></td></tr><t>
			<div class="row"><tr><td width="125px"><b>Mobile</b></td><td><input type="text" class="sedang" name="mobile" id="mobile" value="<%=userMobile %>" ></td><td><div  id="errorBoxMob"></div></td></tr><t>
			
			<pre>
			<tr><td></td><td>
			<input type="submit" class="button" onclick="return onSubmit();" value="Update" style="float: right;">&nbsp;&nbsp;</td>
			<td><a href="profile.jsp" class="button1" value="Cancel" style="float: right;color:white; backgroundcolor: blue;" >Cancel</a>&nbsp;&nbsp;</td>
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
	 var password =  document.getElementById("password").value;
	 var email =  document.getElementById("email").value;
	 var mobile =  document.getElementById("mobile").value;
	 
	 if(password == ""){
		 document.getElementById("errorBoxPwd").innerHTML = "Please Enter Password";
		 validFlag="false";
	 }else{
		 document.getElementById("errorBoxPwd").innerHTML = "";
	 }
	
     if(email == ""){
		 document.getElementById("errorBoxEmail").innerHTML = "Please Enter your Email";
		 validFlag="false";
	 }else{
		 
		 document.getElementById("errorBoxEmail").innerHTML = "";
	 }
     
     if(mobile == ""){
		 document.getElementById("errorBoxMob").innerHTML = "Please Enter Your Mobile Number";
		 validFlag="false";
	 }else{
		 
		 document.getElementById("errorBoxMob").innerHTML = "";
	 }
		return validFlag;
		 
	}
</script>
</body>
</html>