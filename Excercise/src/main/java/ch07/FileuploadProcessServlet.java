package ch07;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/fileuploadProcess")
@MultipartConfig(
		fileSizeThreshold = 1024 * 1024 * 1,  
	    maxFileSize = 1024 * 1024 * 10,       
	    maxRequestSize = 1024 * 1024 * 50
)

public class FileuploadProcessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	public FileuploadProcessServlet() {
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		super.doGet(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String uploadPath = getServletContext().getRealPath("/upload");
		File uploadDir = new File(uploadPath);
		if(!uploadDir.exists()) {
			uploadDir.mkdirs();
		}
		
		String name = request.getParameter("name");
		String subject = request.getParameter("subject");
		
		int fileCount = 1;
		Collection<Part> fileParts = request.getParts();
		for (Part part : fileParts) {
			if ("upalodfile".equals(part.getName()) && part.getSize() > 0) {
				String fileName = part.getSubmittedFileName();
				
				File filesaveDir = new File(uploadPath);
				if (!filesaveDir.exists()) filesaveDir.mkdirs();
				
				part.write(uploadPath + File.separator + fileName); // 파일 저장
				out.println("<h3>파일 업로드 완료</h3>");
				out.println("업로드된 파일 " + fileCount + ": " + fileName + "<br>");
				out.println("이름: " + name + "<br>");
				out.println("제목: " + subject + "<br><br>");

				fileCount++;
			}
		}
		
	}
	
	
	
	
	
}
