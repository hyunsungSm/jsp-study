package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import util.DBUtil;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dao.BookRepository;
import dto.Book;

/**
 * Servlet implementation class ProcessAddBookServlet
 */
@WebServlet("/processUpdateBook")
@MultipartConfig(
	fileSizeThreshold = 1024 * 1024 * 1,   // 메모리 임시 저장 임계값(1MB) -> 이 크기 초과 시 디스크에 임시 저장
	maxFileSize = 1024 * 1024 * 10,        // 업로드 최대 파일 크기(10MB)
	maxRequestSize = 1024 * 1024 * 50      // 전체 요청 크기(50MB)
)
public class ProcessUpdateBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

        // ==== 일반 텍스트 데이터 처리 ====
        String bookId = request.getParameter("bookId");
        String name = request.getParameter("name");
        String unitPrice = request.getParameter("unitPrice");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String releaseDate = request.getParameter("releaseDate");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String unitsInStock = request.getParameter("unitsInStock");
        String condition = request.getParameter("condition");

        int price = 0;
        if (unitPrice != null && !unitPrice.isEmpty()) {
            price = Integer.parseInt(unitPrice);
        }

        long stock = 0;
        if (unitsInStock != null && !unitsInStock.isEmpty()) {
            stock = Long.parseLong(unitsInStock);
        }
        
        // ==== 파일 업로드 처리 ====
        Part filePart = request.getPart("bookImage");
        String fileName = null;
        
        if (filePart != null && filePart.getSize() > 0) {
        	fileName = filePart.getSubmittedFileName();
        	
        	String uploadPath = "D:/upload";
        	File uploadDir = new File(uploadPath);
        	if(!uploadDir.exists()) {
        		uploadDir.mkdirs();
        	}
        	
        	filePart.write(uploadPath + File.separator + fileName);
        }
        
        // 도서 등록 처리 DB 연동 
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

              
        
        // 공통 메소드로 커넥션 획득
        conn = DBUtil.getConnection();
        try {
        	String sql = "SELECT * FROM book WHERE b_id = ?"; 
        	pstmt = conn.prepareStatement(sql);
    		pstmt.setString(1, bookId);
    		rs = pstmt.executeQuery();
    		if (rs.next()) {
    			sql = "UPDATE book SET b_name = ?, b_unitPrice = ?, b_author =?, "
    					+ "b_description = ?, b_publisher = ?, b_category = ?, b_unitsInStock = ?, "
    					+ "b_releaseDate = ?, b_condition = ?, b_fileName = ? WHERE b_id = ?";
    			pstmt = conn.prepareStatement(sql);
    			pstmt.setString(1, name);
    			pstmt.setString(2, unitPrice);
    			pstmt.setString(3, author);
    			pstmt.setString(4, description);
    			pstmt.setString(5, publisher);
    			pstmt.setString(6, category);
    			pstmt.setString(7, unitsInStock);
    			pstmt.setString(8, releaseDate);
    			pstmt.setString(9, condition);
    			pstmt.setString(10, fileName);
    			pstmt.setString(11, bookId);
    			pstmt.executeUpdate();    			
    		}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt, conn); // 공통 메소드로 자원 해제
		}
        
        
        // 수정 후 도서 목록 페이지로 리다이렉트
        response.sendRedirect("editBook.jsp?edit=update");
		
		
	}

}
