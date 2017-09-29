<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.intellion.business.*"%>
    <%@ page import="com.intellion.vo.*"%>
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
<link rel="stylesheet" type="text/css" href="mos-css/mos-style.css"> <!--pemanggilan file css-->
</head>
<%
  /* UserBO userBO = new UserBO();
  String Uname = request.getParameter("username");
  UserVO username = userBO.getUserDetailsByName(Uname);
 */
 String Uname = (String)session.getAttribute("Username");
%>

<body>
<form id="header" method="post" action="../AddUser?operation=UPD">
<div id="header">
	<div class="inHeader">
		<div class="mosAdmin">
		Hello,Mr. <%=Uname%>  <br>
		<!-- <a href="">Lihat website</a> | <a href="">Help</a> |  -->
		
		<a href="profile.jsp">My Profile</a> | <a href="/OEP/login?operation=Logout"">Logout</a>
		</div>
	<div class="clear"></div>
	</div>
</div>
</form>
</body>
</html>