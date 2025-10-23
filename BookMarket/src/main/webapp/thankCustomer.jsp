<%@page import="java.net.URLDecoder"%>
<%@page import="dto.Book"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>주문 정보</title>
	
	<!-- 부트스트랩 연결 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<!-- 주문 정보 확인 페이지 작성하기 -->
		<%
		String shipping_cartId = "";
		String shipping_name = "";
		String shipping_shippingDate = "";
		String shipping_country = "";
		String shipping_zipCode = "";
		String shipping_addressName = "";
		
		Cookie[] cookies = request.getCookies();
		
		if (cookies != null) {
		    for (Cookie cookie : cookies) {
		        switch (cookie.getName()) {
		            case "Shipping_cartId":
		                shipping_cartId = URLDecoder.decode(cookie.getValue(), "utf-8");
		                break;
		            case "Shipping_name":
		                shipping_name = URLDecoder.decode(cookie.getValue(), "utf-8");
		                break;
		            case "Shipping_shippingDate":
		                shipping_shippingDate = URLDecoder.decode(cookie.getValue(), "utf-8");
		                break;
		            case "Shipping_country":
		                shipping_country = URLDecoder.decode(cookie.getValue(), "utf-8");
		                break;
		            case "Shipping_zipCode":
		                shipping_zipCode = URLDecoder.decode(cookie.getValue(), "utf-8");
		                break;
		            case "Shipping_addressName":
		                shipping_addressName = URLDecoder.decode(cookie.getValue(), "utf-8");
		                break;
		        }
		    }
		}
	%>
	
	<div class="container py-4">
		<%@ include file="menu.jsp" %>

	 	<jsp:include page="title.jsp">
			<jsp:param value="주문 완료" name="title"/>
			<jsp:param value="Order Completed" name="sub"/>
		</jsp:include>

    <div class="row align-items-md-stretch alert alert-info">
    	<h2 class="alert alert-danger">주문해 주셔서 감사합니다.</h2>
    	<p>주문은 <%= shipping_shippingDate %>에 배송될 예정입니다!</p>
    	<p>주문번호: <%= shipping_cartId %></p>
		</div>
		<p>
			<a href="./books.jsp" class="btn btn-secondary">&laquo; 도서 목록</a>
		</p>
			
    <%@ include file="footer.jsp" %>
  </div>
  
  <%
  	// 세션에 저장된 장바구니 정보를 모두 삭제하도록 작성 
  	ArrayList<Book> cartList = (ArrayList<Book>) session.getAttribute("cartlist");
  	cartList.clear(); 	
  	
  	
  	// 쿠키에 저장된 배송 정보를 모두 삭제
  	// 예: "Shipping_"으로 시작하는 쿠키들 
  	for (Cookie cookie : cookies){
  		if (cookie.getName().startsWith("Shipping_")){
  			cookie.setMaxAge(0);
  			response.addCookie(cookie);
  		}
  	}
  	
  	
  %>
  
  
  
  
  
</body>
</html>