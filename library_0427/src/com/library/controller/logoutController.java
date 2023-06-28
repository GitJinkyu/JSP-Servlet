package com.library.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login/logout.do")
public class logoutController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//세션의 기본 유효시간은 30분
		HttpSession session = req.getSession();
		
		//세션 무효화
		session.invalidate();
		
		//세션 아이디 새로 발급
		req.getSession(true);
		
		//로그인화면으로 돌아가기
		resp.sendRedirect("login.jsp");
		//request.getRequestDispatcher("gogreen.jsp").forward(request,response);
		
	}
	
	public logoutController() {
		// TODO Auto-generated constructor stub
	}

}
