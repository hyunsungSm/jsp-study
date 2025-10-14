<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%!
		String hello = "Hello! JSP Programming";
		String welcome = "Welcome to JSP";
	%>
	<h1><%= hello %></h1> <br>
	<%= welcome %>
</body>
</html>