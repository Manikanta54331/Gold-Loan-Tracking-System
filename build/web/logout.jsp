<%-- 
    Document   : logout
    Created on : 15-Mar-2024, 1:07:17?pm
    Author     : Mani
--%>

<%@ page language="java" import="java.sql.*,java.util.*,java.text.*" session="true" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Log Out</title>
	<link rel="stylesheet" href="styles.css">
</head>
<body>
	<% 
	try{
session.invalidate();
}
catch(Exception e){
	e.printStackTrace();
}
%>
<div class="container" style="margin: 10% 35% 30% 40%;" >
	<center><h2>Successfully Logged Out!!!</h2></center>
		
		<center><button id="tohome">Redirect to Home page</button></center><br>
		<script type="text/javascript"> document.getElementById("tohome").onclick = function () { location.href = "index.html"; }; </script>
	</div>
</body>
</html>
