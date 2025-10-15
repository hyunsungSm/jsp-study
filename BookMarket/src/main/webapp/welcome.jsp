<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Welcome</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<!-- 북마켓 프로젝트 만들기 -->
	<!-- 한글 출력하기 -->
	<%!
		String greeting = "Welcome to Book Shopping Mall";
		String tagline = "Welcome to Web Market!";
	%>
	
	<div class="container py-4">
		<!-- 헤더(메뉴) 영역 -->
		<%@ include file="menu.jsp" %>

		<!-- 중간 타이틀 영역 -->
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5">
        <h1 class="display-5 fw-bold"><%= greeting %></h1>
        <p class="col-md-8 fs-4">BookMarket</p>
      </div>
    </div>

		<!-- 본문 영역 -->
    <div class="row align-items-md-stretch text-center">
      <div class="col-md-12">
        <div class="h-100 p-5">
          <h3><%= tagline %></h3>
          
          <!-- 현재 접속 시간 출력하기 -->
          <!-- hh:mm:ss a 
          	hh -> 12시간제(01~12), a -> 오전/오후(AM/PM)
          -->
          <% 
          	LocalDateTime now = LocalDateTime.now(); 
          	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("hh:mm:ss a");
          	
          	String CT = now.format(formatter);
          	out.println("현재 접속 시간: " + CT + "\n");
          %>
        </div>
      </div>
 		</div>

		<!-- 푸터(바닥글) 영역 -->
		<%@ include file="footer.jsp" %>
  </div>
</body>
</html>