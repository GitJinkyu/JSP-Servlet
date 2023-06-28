package com.library.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.library.service.BookService;
import com.library.vo.Book;
import com.library.vo.Criteria;
import com.library.vo.PageDto;
import com.oreilly.servlet.MultipartRequest;
import com.util.FileUtil;
import com.util.JSFunction;

@WebServlet("*.book")
public class BookController extends HttpServlet{
	
	BookService bs =  new BookService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("두겟진입");
		
		String uri = req.getRequestURI();
		String no = req.getParameter("no");
		
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
	            req.setAttribute("view", bs.selectOne(no));
	            req.getRequestDispatcher("./view.jsp").forward(req, resp);
	        
	    
	    } else if(uri.indexOf("delete") > 0){
	    	String delNo = req.getParameter("delNo");
	    	System.out.println("No: "+req.getParameter("no"));
	    	if(delNo == null) {
	    		delNo = req.getParameter("no");
	    	}
	    	System.out.println("delNo: "+delNo);
	    	int res = bs.delete(delNo);
	    	
	    	//포워딩    
	    	req.setAttribute("message", ""+res+"건 삭제되었습니다.");
	    	
	    	//게시글 등록,수정,삭제의 경우 중복처리가 되면 안되기때문에
	    	//포워딩을 샌드 리다이렉트로준다. 대신 요청이 새로 만들어지기때문에 위의 message 처리가 안됨
	    	//req.getRequestDispatcher("../book/list.book").forward(req, resp);
	    	resp.sendRedirect("../book/list.book");
		    
	    	
	    } else if(uri.indexOf("write") > 0) {

	    	//도서등록 페이지에서 등록 버튼 누르면 먼저 등록 페이지로 포워딩    
	    	
		    req.getRequestDispatcher("./write.jsp").forward(req, resp);
		    
//	    	doget에서 전부 처리할때, 새로운 매핑 insert를 주고 밑에 코드를 실행하게함
//		    else if(uri.indexOf("insert") > 0) {
//	    	
//	    	//등록페이지에서 입력된 값을 insert.book으로 넘겨받음
//	    	String title = req.getParameter("title");
//	    	String author = req.getParameter("author");
//	    	
//	    	int res = bs.insert(title, author);
//	    	
//	    	//포워딩
//	    	req.setAttribute("message", ""+res+"건 추가되었습니다.");
//	    	
//	    	//게시글 등록,수정,삭제의 경우 중복처리가 되면 안되기때문에
//	    	//포워딩을 샌드 리다이렉트로준다. 대신 요청이 새로 만들어지기때문에 위의 message 처리가 안됨
//	    	resp.sendRedirect("../book/list.book");
//	    }
	    } 
	    		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("두포스트진입");
		String uri = req.getRequestURI();
		String saveDirectory ="C:\\Users\\user\\git\\JSP-Servlet\\library_0427\\webapp\\images\\bookImg";
		MultipartRequest mr =  FileUtil.uploadFile(req, saveDirectory, 1024*1000);
		
		if(uri.indexOf("write") > 0) {
			//도서등록
			Book book = new Book(mr.getParameter("title"),mr.getParameter("author"));
			
			String ofile = mr.getFilesystemName("bookImg");
			
			if(ofile != null && !"".equals(ofile)) {
				String sfile = FileUtil.fileNameChange(saveDirectory, ofile);
				
				book.setOfile(ofile);
				book.setSfile(sfile);
			}
		    int res = bs.insert(book);
		    
		    if(res > 0 ) {
		    	JSFunction.alertLocation(resp, "도서가 등록되었습니다.", "../book/list.book");
		    }
	    }else if(uri.indexOf("rent") > 0) {
	    	//로그인 아이디 확인
	    	HttpSession session = req.getSession();
	    	if(session.getAttribute("userId") == null) {
	    		JSFunction.alertBack(resp, "로그인후 이용 가능한 메뉴 입니다.");
	    		return;
	    	}
	    	System.out.println("렌트 아이디 접속확인성공");
	    	//대여하기 - 책번호, 로그인 아이디
	    	Book book = new Book();
	    	System.out.println("req.getParameter(no): "+req.getParameter("no"));
	    	book.setNo(req.getParameter("no"));
	    	book.setId(session.getAttribute("userId").toString());
	    	
	    	int res = bs.rentBook(book);
	    	System.out.println("렌트북메서드 실행성공");
	    	if(res > 0) {
	    		JSFunction.alertLocation(resp, "대여되었습니다.", "../book/view.book?no="+book.getNo());
	    	}else {
	    		JSFunction.alertBack(resp, "대여중 오류가 발생하였습니다.");
	    	}	
	    }else if(uri.indexOf("return") > 0) {
	    	//로그인 아이디 확인
	    	HttpSession session = req.getSession();
	    	if(session.getAttribute("userId") == null) {
	    		JSFunction.alertBack(resp, "로그인후 이용 가능한 메뉴 입니다.");
	    		return;
	    	}
	    	System.out.println("리턴 아이디 접속확인성공");
	    	//반납하기
	    	Book book = new Book();
	    	System.out.println("req.getParameter(no): "+req.getParameter("no"));
	    	book.setNo(req.getParameter("no"));
	    	book.setId(session.getAttribute("userId").toString());
	    	
	    	int res = bs.returnBook(book);
	    	System.out.println("리턴북메서드 실행성공");
	    	if(res > 0) {
	    		JSFunction.alertLocation(resp, "반납되었습니다.", "../book/view.book?no="+book.getNo());
	    	}else {
	    		JSFunction.alertBack(resp, "반납중 오류가 발생하였습니다.");
	    	}	
	    }
		
		
	}
	
	
	public BookController() {
		// TODO Auto-generated constructor stub
	}

}
