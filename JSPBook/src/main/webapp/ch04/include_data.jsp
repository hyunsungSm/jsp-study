<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Action</title>
</head>
<body>
	<p>오늘의 날짜 및 시간</p>
	<p><%= new Date().toLocaleString() %></p>
	
	<!-- include 디렉티브 태그와 비교 테스트 -->
	<%
		int test = 0;
	%>
</body>
</html>