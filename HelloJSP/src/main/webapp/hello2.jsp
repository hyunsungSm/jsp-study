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
		String introduce = "Self-Introduction";
		String name = "Kim Jae Hyun";
		String department = "Goodee Academy";
	%>
	<h1><%= introduce %></h1><br>
	<%
		out.println("Name: " + name + " <br> Department: " + department);
	%>
</body>
</html>