<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		response.setIntHeader("Refresh", 5);
	%>
	<%= new Date() %>
	
	<br>
	<a href="response_data.jsp">구글 홈페이지로 이동하기</a>
</body>
</html>