package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model2.mvcboard.dao.MVCBoardDAO;
import model2.mvcboard.dto.MVCBoardDTO;

@WebServlet("/mvcboard/view.do")
public class ViewController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String idx = req.getParameter("idx");
		
		//게시물 조회
		MVCBoardDAO dao = new MVCBoardDAO();
		MVCBoardDTO dto =dao.selectOne(idx);
		
		
		
		//리퀘스트 영역 저장
		req.setAttribute("dto", dto);
		
		//화면 페이지 전환
		req.getRequestDispatcher("/14MVCBoard/View.jsp").forward(req, resp);
		
		
		
	
	}
	
	

}
