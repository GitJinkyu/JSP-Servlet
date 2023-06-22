package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fileupload.fileDao;
import fileupload.fileDto;

@WebServlet("/12파일업로드/2FileList.do")
public class FileListServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		fileDto dto = new fileDto();
		fileDao dao = new fileDao();
		List<fileDto> filelist = dao.getFileList(dto);
		
		req.setAttribute("filelist", filelist);
		req.getRequestDispatcher("2FileList.jsp").forward(req, resp);
	
	}
	
	public FileListServlet() {
		// TODO Auto-generated constructor stub
	}

}
