<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL</title>
</head>
<body>
	<!-- 문자열 분리하고 연결하기 -->
	<c:set var="texts" value="${fn:split('Hello, Java Server Pages!', ' ')}" />
	
	<c:forEach var="i" begin="0" end="${fn:length(texts) - 1}">
		<p>text[${i}] = ${texts[i]}</p>
	</c:forEach>
	<!-- 또는 -->
	<c:forEach var="text" items="${texts}" varStatus="i">
		<p>text[${i.index}] = ${text}</p>
	</c:forEach>
	
	<p>
		<c:out value="${fn:join(texts, '-')}" />
	</p>
</body>
</html>