<%@page import="dao.BookRepository"%>
<%@page import="dto.Book"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="exceptionNoBookId.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>도서 정보</title>
	
	<!-- 부트스트랩 연결 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="container py-4">
		<%@ include file="menu.jsp" %>

	 	<jsp:include page="title.jsp">
    	<jsp:param value="도서정보" name="title"/>
    	<jsp:param value="BookInfo" name="sub"/>
    </jsp:include>

		<%
			// Quiz
			// 도서 목록 페이지로부터 전달되는 도서 아이디를 가져오도록 작성
			
			// BookRepository 클래스로 bookDAO라는 이름의 자바빈을 생성하고
			// 도서 아이디를 이용하여 도서 정보 가져오기
			String bookId = request.getParameter("id");
			// Book book = bookDAO.getBookById(bookId);	
			
			// 공유 객체로 변경
			BookRepository dao = BookRepository.getInstance();
			Book book = dao.getBookById(bookId);
		%>

    <div class="row align-items-md-stretch">
      <div class="col-md-5">
      	<!-- 웹 앱 내부 접근 시 -->
      	<%-- <img alt="도서 이미지" src="./resources/images/<%= book.getFilename() %>" style="width: 70%;"> --%>
      	<!-- 외부 폴더 접근 시 -->
      	<img alt="도서 이미지" src="<%= request.getContextPath() %>/images/<%= book.getFilename() %>" style="width: 70%;">
      </div>
    	
      <div class="col-md-6">
      	<!-- Quiz: 도서 정보로 채워넣기(데이터 동적 바인딩) -->
				<h3><b><%= book.getName() %></b></h3>
				<p><%= book.getDescription() %></p>
				<p>
					<b>도서코드</b>: <span class="badge text-bg-danger"><%= book.getBookId() %></span>
				</p>							
				<p>
					<b>저자</b>: <%= book.getAuthor() %>
				</p>	
				<p><b>출판사</b>: <%= book.getPublisher() %></p>	
				<p><b>출판일</b>: <%= book.getReleaseDate() %></p>				
				<p><b>분류</b>: <%= book.getCategory() %></p>
				<p><b>재고수</b>: <%= book.getUnitsInStock() %></p>
				<h4><%= book.getUnitPrice() %> 원</h4>
				<p>
					<a href="#" class="btn btn-info">도서주문 &raquo;</a> 
					<a href="./books.jsp" class="btn btn-secondary">도서목록 &raquo;</a>
				</p>
      </div>
 		</div>

    <%@ include file="footer.jsp" %>
  </div>
</body>
</html>