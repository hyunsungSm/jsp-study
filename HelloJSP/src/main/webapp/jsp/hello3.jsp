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
		String introduce = "Welcome to JSP";
		String name = "JSP is Dynamic Web Page.";
		String department = "JSP is Java Server Pages.";
	%>
	<h1><%= introduce %></h1><br>
	<%
		out.println(name + " <br> " + department);
	%>
</body>
</html>