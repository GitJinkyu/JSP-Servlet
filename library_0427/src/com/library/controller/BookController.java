package com.library.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.service.BookService;
import com.library.vo.Criteria;
import com.library.vo.PageDto;

@WebServlet("*.book")
public class BookController extends HttpServlet{
	
	BookService bs =  new BookService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		String noString = req.getParameter("no");
		
		//검색 조건 세팅
    	Criteria cri = new Criteria(req.getParameter("searchField")
    												,req.getParameter("searchWord")
    												,req.getParameter("pageNo"));
    	
		int totalCnt =bs.getTotalCnt(cri);
		PageDto pageDto = new PageDto(totalCnt,cri);
		
		
		 // 만약 uri 안에 list가 포함되어 있다면
		System.out.println("요청 uri : "+ uri);
	    if (uri.indexOf("list") > 0) {
	    	
	    	//리스트 조회 및 리퀘스트 영역에 저장
	    	req.setAttribute("pageDto", pageDto);
	    	//req.setAttribute("totalCnt", totalCnt);
	    	req.setAttribute("map", bs.getList(cri));
	    	
		    //포워딩    
		    req.getRequestDispatcher("./list.jsp").forward(req, resp);
	        
	    } else if (uri.indexOf("view") > 0) {
	    	
	        if (noString != null) {
	            int no = Integer.parseInt(noString);
	            req.setAttribute("view", bs.selectOne(no));
	            req.getRequestDispatcher("./view.jsp").forward(req, resp);
	        } else {
	            // 오류 처리: no 파라미터가 없을 경우
	            // 적절한 예외 처리 또는 오류 페이지로 이동할 수 있습니다.
	            // 예를 들어, 오류 페이지로 리다이렉트하거나 오류 메시지를 설정할 수 있습니다.
	        	System.out.println("뷰 전환 에러");
	            resp.sendRedirect("./error.jsp");
	        }
	    } else if(uri.indexOf("delete") > 0){
	    	String delNo = req.getParameter("delNo");
	    	int res = bs.delete(delNo);
	    	
	    	//포워딩    
	    	req.setAttribute("message", ""+res+"건 삭제되었습니다.");
	    	
	    	//게시글 등록,수정,삭제의 경우 중복처리가 되면 안되기때문에
	    	//포워딩을 샌드 리다이렉트로준다.
	    	resp.sendRedirect("../book/list.book");
		    
	    	
	    } else if(uri.indexOf("write") > 0) {

	    	//도서등록 페이지에서 등록 버튼 누르면 먼저 등록 페이지로 포워딩    
	    	
		    req.getRequestDispatcher("./write.jsp").forward(req, resp);
		    
	    } else if(uri.indexOf("insert") > 0) {
	    	
	    	//등록페이지에서 입력된 값을 insert.book으로 넘겨받음
	    	String title = req.getParameter("title");
	    	String author = req.getParameter("author");
	    	
	    	int res = bs.insert(title, author);
	    	
	    	//포워딩
	    	req.setAttribute("message", ""+res+"건 추가되었습니다.");
	    	
	    	//게시글 등록,수정,삭제의 경우 중복처리가 되면 안되기때문에
	    	//포워딩을 샌드 리다이렉트로준다.
	    	resp.sendRedirect("../book/list.book");
	    }
	    		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
	}
	
	
	public BookController() {
		// TODO Auto-generated constructor stub
	}

}
