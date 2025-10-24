<%@page import="dao.BookRepository"%>
<%@page import="java.util.List"%>
<%@page import="dto.Book"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>도서 편집</title>
	
	<!-- 부트스트랩 연결 -->
	<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet"> -->
	<!-- 로컬로 직접 넣기 -->
	<link rel="stylesheet" href="./resources/css/bootstrap.min.css">
	
	<script type="text/javascript">
		function deleteConfirm(id) {
			if (confirm('해당 도서를 삭제합니다!!')){
				location.href = './deleteBook.jsp?id=' + id;
			}
		}
	</script>
</head>
<body>
	<!-- 도서 편집 페이지 -->
	<%
		String edit = request.getParameter("edit");
	%>
	<div class="container py-4">
		<%@ include file="menu.jsp" %>

		<jsp:include page="title.jsp">
			<jsp:param value="도서 편집" name="title"/>
			<jsp:param value="BookEditing" name="sub"/>
		</jsp:include>
	
		<%@ include file="dbconn.jsp" %>
		<%
			// List<Book> listOfBooks = bookDAO.getAllBooks();
		
			// BookRepository 공유 객체로 변경
			BookRepository dao = BookRepository.getInstance();
			List<Book> listBooks = dao.getAllBooks();
		%>
	
    <div class="row align-items-md-stretch text-center">
      <%
      	// book 테이블의 모든 데이터를 가져오도록 작성 
      	try {
      		String sql = "SELECT * FROM book";
      		pstmt = conn.prepareStatement(sql);
      		rs = pstmt.executeQuery();
      		// 가져온 레코드들을 반복하여 동적 바인딩
      		while (rs.next()){
      			String id = rs.getString("b_id");
      			String name = rs.getString("b_name");
      			String unitPrice = rs.getString("b_unitPrice");
      			String author = rs.getString("b_author");
      			String description = rs.getString("b_description");
      			String publisher = rs.getString("b_publisher");
      			String category = rs.getString("b_category");
      			String unitsInStock = rs.getString("b_unitsInStock");
      			String releaseDate = rs.getString("b_releaseDate");
      			String condition = rs.getString("b_condition");
      			String filename = rs.getString("b_fileName");
      		
      %>
      <div class="col-md-4">
      	<div class="h-100 p-2">
      		<!-- 웹 앱 내부 접근 시 -->
					<%--	<img alt="도서 이미지" src="./resources/images/<%= book.getFilename() %>" style="width: 250px; height: 350px"> --%>
      		<!-- 외부 폴더 접근 시 -->
      		<img alt="도서 이미지" src="<%= request.getContextPath() %>/images/<%= filename %>" style="width: 250px; height: 350px">
      		<h5><b><%= name %></b></h5>
      		<p>
      			<%= author %>
      			<br>
      			<%= publisher %> | <%= releaseDate %>
      		</p>
      		<p><%= description %>...</p>
      		<p><%= unitPrice %>원</p>
      		<p>
      			<%
      				if ("update".equals(edit)){
      			%>
      					<a href="./updateBook.jsp?id=<%= rs.getString("b_id") %>" class="btn btn-success" role="button">
      						수정 &raquo;
      					</a>
      			<%
      				} else if ("delete".equals(edit)){
      					
      			%>
      					<a href="javascript:void(0)" class="btn btn-danger" role="button" onclick="deleteConfirm('<%= rs.getString("b_id") %>')">
      						삭제 &raquo;
      					</a>
      			<%
      				}
      			%>
      		</p>
      		
      	</div>
      </div>	
      
      <%
      		}
      		rs.close();
      		pstmt.close();
      	} catch (SQLException e){
					out.println("book 테이블 호출이 실패했습니다.<br>"); 
					out.println("SQLException: " + e.getMessage()); 
      	} finally {
      		if (rs != null) rs.close();
					if (pstmt != null) rs.close();	
      	}
      %>
 		</div>

		<%@ include file="footer.jsp" %>
  </div>
</body>
</html>