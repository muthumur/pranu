<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<link rel="stylesheet"  href="../css/mos-style.css">
<link rel="stylesheet" type="text/css" href="../css/app.css">
<link rel="stylesheet" type="text/css" href="../css/vendor.css"> <!--pemanggilan file css-->
<style>
#errorBoxUsername{
	color:red;
	text-align:left;
}

#errorBoxPassword{
	color:red;
	text-align:left;
}
</style>
</head>

<body>
<!-- <div id="header">
	<div class="inHeaderLogin"></div>
</div> -->

<div class="auth">
            <div class="auth-container">
                <div class="card">
                    
                    <div class="auth-content">
                        <p class="text-xs-center"><strong>LOGIN TO CONTINUE</strong></p>
                         
                        <%
								String val =  (String)session.getAttribute("val");
								session.removeAttribute("val");
					       	     System.out.println("session called...."+val);
					       	 
					       	     if(null != val && "fail".equalsIgnoreCase(val)){
								
								%>
                                                                <div>
                        <h4 class="title"><font color="#db1321"><center>Enter Valid Username/Password</center></font> </h4>
                    </div>  
                    
                     <%
			        	}
			        %>
			        
			        	<%
	                        String registerResult =  (String)session.getAttribute("registerResult");
	                   	    session.removeAttribute("registerResult");
	                   	 	if(null != registerResult && "success".equalsIgnoreCase(registerResult)){
                        %>
                        	<h3 class="title"><font color="red"><center>Registered Successfully</center></font><span class="sparkline bar" data-type="bar"></span> </h3>
                        <%
	                   	 	}
                        %>
                        
                        <form id="loginform"  method="post" role="form" action="">
                            <div class="form-group"> <div class="row"> <input type="text" class="form-control underlined" name="username" id="username" placeholder="User Name" required><div id="errorBoxUsername"></div></div> </div>
                            <div class="form-group"> <div class="row"> <input type="password" class="form-control underlined" name="password" id="password" placeholder="Password" required><div id="errorBoxPassword"></div></div> </div>
                           
                            <div class="form-group"> <button type="submit" class="btn btn-block btn-primary" onclick="onSubmit();">Login</button> </div>
                            <div class="form-group">
                                <p class="text-muted text-xs-center">Don't have an account? <a href="register.jsp">Sign Up!</a></p>
                            </div>
                        </form>
                    </div>
                </div>
                
            </div>
        </div>
<script>
	function onSubmit(){
 		 var validateFlag = validateLogin();
	 	
	 
	 	if(validateFlag == 'true'){
	 		document.forms["loginform"].action="/OEP/login?operation=Login";
		
    	
    	  document.form["loginform"].submit();
 
      }
	}
	
function validateLogin(){
		
		 var validFlag="true";
		 var username =  document.getElementById("username").value;
		 var password =  document.getElementById("password").value;
		 
		 if(username == ""){
			 
			 document.getElementById("errorBoxUsername").innerHTML = "Please Enter the User Name";
			 validFlag="false";
		 }else{
			 
			 document.getElementById("errorBoxUsername").innerHTML = "";
		 }
		 if(password == ""){
			
			 document.getElementById("errorBoxPassword").innerHTML = "Please Enter the Password";
			 validFlag="false";
		 }else{
			
			 document.getElementById("errorBoxPassword").innerHTML = "";
		 }
		 return validFlag;
		 
}
    </script>
</body>
</html>