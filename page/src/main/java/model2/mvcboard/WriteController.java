package model2.mvcboard;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model2.mvcboard.dao.MVCBoardDAO;
import model2.mvcboard.dto.MVCBoardDTO;

public class WriteController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			int res= 0;
			MVCBoardDAO dao = new MVCBoardDAO();
			MVCBoardDTO dto = new MVCBoardDTO();
			res = dao.insert(dto);
		
			//글 작성
			
			//request영역에 저장
			req.setAttribute("boardlist", boardlist);
			//화면 페이지 전환
			req.getRequestDispatcher("/14MVCBoard/List.jsp").forward(req, resp);
	
	}
	public WriteController() {
		// TODO Auto-generated constructor stub
	}

}
