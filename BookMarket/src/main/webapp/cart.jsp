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
	<title>장바구니</title>
	
	<!-- 부트스트랩 연결 -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<!-- 장바구니 페이지 작성하기 -->
	<%
		String cartId = session.getId(); // 세션 ID 얻기(이 예제에서는 세션 객체의 ID로 사용함)
		
	%>
	<div class="container py-4">
		<%@ include file="menu.jsp" %>

	 	<jsp:include page="title.jsp">
    	<jsp:param value="장바구니" name="title"/>
    	<jsp:param value="Cart" name="sub"/>
    </jsp:include>


    <div class="row align-items-md-stretch">
    	<div class="row">
    		<table width="100%">
    			<tr>
    				<td align="left">
    					<a href="./deleteCart.jsp?cartId=<%= cartId %>" class="btn btn-danger">삭제하기</a>
    				</td>
    				<td align="right">
    					<a href="./shippingInfo.jsp?cartId=<%= cartId %>" class="btn btn-success">주문하기</a>
    				</td>
    			</tr>
    		</table>
    	</div>
    	
    	<div style="padding-top: 50px">
    		<table class="table table-hover">
    			<tr>
    				<th>도서</th>
    				<th>가격</th>
    				<th>수량</th>
    				<th>소계</th>
    				<th>비고</th>
    			</tr>
    			<%
			    ArrayList<Book> cartList = (ArrayList<Book>) session.getAttribute("cartlist");
			    if (cartList == null) {
			        cartList = new ArrayList<Book>();
			    }
			
			    int sum = 0;
			    for (Book b : cartList) {
			        int subtotal = b.getUnitPrice() * b.getQuantity();
			        sum += subtotal;
					%>
					<tr>
					    <td><%= b.getName() %></td>
					    <td><%= String.format("%,d", b.getUnitPrice()) %>원</td>
					    <td><%= b.getQuantity() %></td>
					    <td><%= String.format("%,d", subtotal) %>원</td>
					    <td><a href="./removeCart.jsp?id=<%= b.getBookId() %>" class="badge text-bg-danger">삭제</a></td>
					</tr>
					<%
					    }
					%>
					<tr>
					    <td colspan="3" style="text-align:right;"><strong>총액</strong></td>
					    <td><strong><%= String.format("%,d", sum) %>원</strong></td>
					    <td></td>
					</tr>
    		</table>
    		<a href="./book.jsp" class="btn btn-secondary">&laquo; 쇼핑 계속하기</a>
    	</div>
    	
    </div>

    <%@ include file="footer.jsp" %>
  </div>
</body>
</html>