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
		String title = request.getParameter("title");
		String sub = request.getParameter("sub");
	%>

	<!-- 중간 타이틀 영역 -->
	   <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5">
        <h1 class="display-5 fw-bold"><%= title %></h1>
        <p class="col-md-8 fs-4"><%= sub %></p>
      </div>
    </div>
</body>
</html>