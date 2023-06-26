package com.library.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.service.BookService;

@WebServlet("*.book")
public class BookController extends HttpServlet{
	
	BookService bs =  new BookService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		String noString = req.getParameter("no");
		//int no = Integer.parseInt(req.getParameter("no"));
		
		
		System.out.println("요청 uri : "+ uri);
//		//만약 uri안에 list가 포함되어있다면
//		if(uri.indexOf("list") > 0 ) {
//			req.setAttribute("list", bs.getList());
//			req.getRequestDispatcher("./list.jsp").forward(req, resp);
//			
//		}else if(uri.indexOf("view") > 0) {
//			req.setAttribute("view", bs.selectOne(no));
//			req.getRequestDispatcher("./view.jsp").forward(req, resp);
//		}
//	
		
		 // 만약 uri 안에 list가 포함되어 있다면
		
	    if (uri.indexOf("list") > 0) {
	        req.setAttribute("list", bs.getList());
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
	            resp.sendRedirect("./error.jsp");
	        }
	    }
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doPost(req, resp);
	}
	
	
	public BookController() {
		// TODO Auto-generated constructor stub
	}

}
