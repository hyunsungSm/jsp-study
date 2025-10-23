<%@page import="java.util.ArrayList"%>
<%@page import="dto.Book"%>
<%@page import="dao.BookRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 장바구니에 등록된 개별 도서 삭제 페이지 작성하기 -->
	<%
		// 1. 요청 파라미터 검증
		// 쿼리 스트링으로 보낸 데이터
		String id = request.getParameter("id");
		
		// id가 null인지 빈 문자열인지 검증
		if (id == null || id.trim().isEmpty()){ 
			response.sendRedirect("books.jsp");
			return;
		}
		
		// 2. 도서 조회 
		BookRepository dao = BookRepository.getInstance();
		Book book = dao.getBookById(id);
		if (book == null){
			response.sendRedirect("exceptionNoBookId.jsp");
			return;
		}
		
		// 3. 세션에서 장바구니 정보 가져오기(없으면 새로 생성)
		// "cartlist"
		ArrayList<Book> cartList = (ArrayList<Book>) session.getAttribute("cartlist");

		if (cartList == null){
			cartList = new ArrayList<Book>();
			session.setAttribute("cartlist", cartList);
			// 장바구니 정보를 세션에 저장 
			// 실무에서는 보통 DB에 저장하지만 상황에 따라 다름 
		}
		
		// 4. 장바구니에 동일 도서가 있으면 삭제 
		for (Book b : cartList){
			if (b.getBookId().equals(id)){
				cartList.remove(b);
				break; // break가 없으면 동시성 예외 발생!!(다른 해결책: iterator() 사용)
			}
		}
		
		// 5. 상세 페이지로 리다이렉트
		response.sendRedirect("book.jsp?id=" + id);
	%>
</body>
</html>