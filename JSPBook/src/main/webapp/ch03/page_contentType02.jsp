<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- JSP는 직접 XML 문서를 생성하는 용도가 아니기 때문에 필요하면 응답 헤더로 XML임을 지정하는게 안전 -->
	<%
		response.setContentType("text/xml; charset=UTF-8");
	%>
	<h2>cotentType 디렉티브 태그</h2>
	<h4>text/xml: XML 출력</h4>
	<h4>charset=UTF-8: 문자 인코딩</h4>
</body>
</html>