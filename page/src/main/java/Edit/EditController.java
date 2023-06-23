package Edit;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model2.mvcboard.dao.MVCBoardDAO;
import model2.mvcboard.dto.MVCBoardDTO;

@WebServlet("/mvcboard/edit.do")
public class EditController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("두겟으로 옴");
		
		MVCBoardDAO dao = new MVCBoardDAO();
		MVCBoardDTO dto = dao.selectOne(req.getParameter("idx"));
		
		req.setAttribute("dto", dto);
		
		req.getRequestDispatcher("../14MVCBoard/Edit.jsp").forward(req, resp);


		
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("두포스트로 옴");
		
		MVCBoardDAO dao = new MVCBoardDAO();
		MVCBoardDTO dto = dao.selectOne(req.getParameter("idx"));
		
		req.setAttribute("dto", dto);
		
		req.getRequestDispatcher("../14MVCBoard/Edit.jsp").forward(req, resp);
		
	}
	
	public EditController() {
		// TODO Auto-generated constructor stub
	}

}
