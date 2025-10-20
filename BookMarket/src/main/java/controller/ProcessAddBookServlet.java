package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import dao.BookRepository;
import dto.Book;

/**
 * Servlet implementation class ProcessAddBookServlet
 */
@WebServlet("/processAddBook")
@MultipartConfig(
	fileSizeThreshold = 1024 * 1024 * 1,   // 메모리 임시 저장 임계값(1MB) -> 이 크기 초과 시 디스크에 임시 저장
	maxFileSize = 1024 * 1024 * 10,        // 업로드 최대 파일 크기(10MB)
	maxRequestSize = 1024 * 1024 * 50      // 전체 요청 크기(50MB)
)
public class ProcessAddBookServlet extends HttpServlet {
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
        	// 파일 이름 가져오기 
        	fileName = filePart.getSubmittedFileName();
        	
        	// 업로드 폴더 경로(2가지 경로 테스트)
        	// 1) webapp 내부 경로 사용 
//        	String uploadPath = getServletContext().getRealPath("/resources/images");
        	// 장점: 내부 경로라서 리소스에 바로 접근 가능 
        	// 단점: 서버 재배포 시 초기화됨(즉, 업로드 파일 사라짐)
        	
        	// 2) 외부 업로드 폴더 사용
        	String uploadPath = "D:/upload";
        	// JSP 페이지에서 /images/파일명으로 바로 접근하려면 톰캣 설정(외부 폴더 매핑)을 추가해야 함
        	// server.xml 또는 프로젝트별 context.xml
        	
        	File uploadDir = new File(uploadPath);
        	if(!uploadDir.exists()) {
        		uploadDir.mkdirs();
        	}
        	
        	filePart.write(uploadPath + File.separator + fileName);
        }
        
        // ==== Book 객체 생성 및 저장 ====
        Book newBook = new Book();
        newBook.setBookId(bookId);
        newBook.setName(name);
        newBook.setUnitPrice(price);
        newBook.setAuthor(author);
        newBook.setPublisher(publisher);
        newBook.setReleaseDate(releaseDate);
        newBook.setDescription(description);
        newBook.setCategory(category);
        newBook.setUnitsInStock(stock);
        newBook.setCondition(condition);
        newBook.setFilename(fileName); // 이미지 이름 저장(상대 경로로 JSP 페이지에서 접근하기 위해)
        // (참고) 보통은 이미지 경로도 같이 저장
        
        BookRepository dao = BookRepository.getInstance();
        dao.addBook(newBook);
        
        // 등록 후 도서 목록 페이지로 리 다이렉트
        response.sendRedirect("books.jsp");
		
		
	}

}
