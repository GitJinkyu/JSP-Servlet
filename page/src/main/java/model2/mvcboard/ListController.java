package model2.mvcboard;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Criteria;
import model2.mvcboard.dao.MVCBoardDAO;
import model2.mvcboard.dto.MVCBoardDTO;

public class ListController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		String pageNo = req.getParameter("pageNo");
		
		MVCBoardDAO dao = new MVCBoardDAO();
		Criteria criteria = new Criteria(searchField,searchWord,pageNo);
		
		//리스트 조회
		List<MVCBoardDTO> boardlist = dao.getList(criteria);
		//request영역에 저장
		req.setAttribute("boardlist", boardlist);
		//화면 페이지 전환
		req.getRequestDispatcher("/14MVCBoard/List.jsp").forward(req, resp);
	}
	
	
	public ListController() {
		// TODO Auto-generated constructor stub
	}

}
