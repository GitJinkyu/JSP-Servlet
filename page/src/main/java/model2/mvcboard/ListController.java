package model2.mvcboard;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Criteria;
import dto.PageDto;
import model2.mvcboard.dao.MVCBoardDAO;
import model2.mvcboard.dto.MVCBoardDTO;

public class ListController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		MVCBoardDAO dao = new MVCBoardDAO();
		
		//검색어 페이지정보 세팅
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		String pageNo = req.getParameter("pageNo");

	

		//검색어,페이지 정보 세팅
		Criteria criteria = new Criteria(searchField,searchWord,pageNo);
		System.out.println("======페이지 관련 파라메터 확인======");
		System.out.println(criteria.getPageNo());
		System.out.println(criteria.getStartNo());
		System.out.println(criteria.getEndNo());
		
		//검색필드,검색어를 입력받았을경우 그 값으로 세팅해주기
		criteria.setSearchField(searchField);
		criteria.setSearchWord(searchWord);
		

		
		//게시물 건수 조회
		int TotalCnt = dao.getTotalCnt(criteria);
		
		//게시물페이징 네비게이션 생성을 위해 pageDto 생성
		PageDto pageDto = new PageDto(TotalCnt,criteria);
		
		//리스트 조회
		
		List<MVCBoardDTO> boardlist = dao.getListPage(criteria);
		
		//request영역에 저장
		req.setAttribute("boardlist", boardlist);
		req.setAttribute("TotalCnt", TotalCnt);
		req.setAttribute("pageDto", pageDto);


		
		//화면 페이지 전환
		req.getRequestDispatcher("/14MVCBoard/List.jsp").forward(req, resp);
	}
	
	public ListController() {
		// TODO Auto-generated constructor stub
	}

}
