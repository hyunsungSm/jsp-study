<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 필터 처리로 매개변수와 값을 전달받아 로그인 인증 처리하기 -->
	<form action="filter02_process.jsp" method="post">
		<p>이름: <input type="text" name="id"></p>
		<p>이름: <input type="password" name="passwd"></p>
		<button type="submit">전송</button>
	</form>
</body>
</html>