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
<link rel="stylesheet" type="text/css" href="../css/mos-style.css">
<link rel="stylesheet" type="text/css" href="../css/app.css">
<link rel="stylesheet" type="text/css" href="../css/vendor.css"> <!--pemanggilan file css-->
<style>

#errorBoxUsername{
	color:red;
	text-align:left;
}

#errorBoxEmail{
	color:red;
	text-align:left;
}
#errorBoxPassword{
	color:red;
	text-align:left;
}
#errorBoxMobile{
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
                        <h3><p class="text-xs-center">Registration Form</p></h3>
                        <%
	                        String registerResult =  (String)session.getAttribute("registerResult");
	                   	    session.removeAttribute("registerResult");
	                   	 if(null != registerResult && "success".equalsIgnoreCase(registerResult)){
                        %>
                        <h3 class="title"><font color="red"><center>Registered Successfully</center></font><span class="sparkline bar" data-type="bar"></span> </h3>
                        <%
	                   	 }
                        %>
                        <form id="register-form"  method="post" action="../AddUser?operation=ADD">
                   
                            <div class="form-group"> <div class="row"> <input type="text" class="form-control underlined" name="username" id="username" placeholder="Enter UserName" ><div id="errorBoxUsername"></div></div> </div>
                            <div class="form-group">  <div class="row"><input type="email" class="form-control underlined" name="email" id="email" placeholder="Enter email address" ><div id="errorBoxEmail"></div></div> </div>
                            <div class="form-group"> 
                                <div class="row">
                                    <div class="col-sm-12"> <div class="row"><input type="password" class="form-control underlined" name="password" id="password" placeholder="Enter password" ><div id="errorBoxPassword"></div></div> </div>
                                </div>
                            </div>
							<div class="form-group">  <div class="row"><input type="text" class="form-control underlined" name="mob" id="mob" placeholder="Enter Mobile No." ><div id="errorBoxMobile"></div></div> </div>
                            <!-- <div class="form-group">  <input type="text" class="form-control underlined" name="role" id="role" placeholder="Enter Role" required=""> </div> -->
                            
                            <div class="form-group"> <button type="submit" onclick="return onSubmit();" class="btn btn-block btn-primary">Sign Up</button> </div>
                            <div class="form-group">
                                <p class="text-muted text-xs-center">Already have an account? <a href="login.jsp">Login!</a></p>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script>
/* function onSubmit(){
	document.forms["register-form"].submit();
} */
function onSubmit(){
	 var validateFlag = validateRegister();
	 	
	 
	 	if(validateFlag == 'true'){
	 		/* document.forms["register-form"].action="../AddUser?operation=ADD";
			document.forms["register-form"].submit(); */
	 		return true;
	 	}else{
	 		
	 		return false;
	 	}
	 	
}
	
	function validateRegister(){
		
		 var validFlag="true";
		 var username =  document.getElementById("username").value;
		 var email =  document.getElementById("email").value;
		 var password =  document.getElementById("password").value;
		 var mob =  document.getElementById("mob").value;
		 
		 
		 if(username == ""){
			 
			 document.getElementById("errorBoxUsername").innerHTML = "Please Enter the User Name";
			 validFlag="false";
		 }else{
			 
			 document.getElementById("errorBoxUsername").innerHTML = "";
		 }
		 if(email == ""){
			
			 document.getElementById("errorBoxEmail").innerHTML = "Please Enter the Email";
			 validFlag="false";
		 }else{
			
			 document.getElementById("errorBoxEmail").innerHTML = "";
		 }
		 if(password == ""){
			 
			 document.getElementById("errorBoxPassword").innerHTML = "Please Enter the Password";
			 validFlag="false";
		 }else{
			 document.getElementById("errorBoxPassword").innerHTML = "";
		 }
		 if(mob == ""){
			
			 document.getElementById("errorBoxMobile").innerHTML = "Please Enter the Mobile No.";
			 validFlag="false";
		 }else{
			 
			 document.getElementById("errorBoxMobile").innerHTML = "";
		 }
			
		 return validFlag;
		 
	}
	

</script>
	</body>
</html>