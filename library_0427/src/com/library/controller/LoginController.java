package com.library.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.library.service.MemberService;
import com.library.vo.Member;
import com.util.CookieManager;


@WebServlet("/login/loginController.do")
public class LoginController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		String id = req.getParameter("userID");
		String pw = req.getParameter("userPW");
		
		//아이디 저장 체크박스
		String saveYN = req.getParameter("save_check");
		
		
		//아이디 저장하기 체크가 되어있다면
		//쿠키에 아이디를 저장한다
		if(saveYN != null && "Y".equals(saveYN)){
			//쿠키생성하는 메서드 호출
			CookieManager.makeCookie("userID", id, 3600, resp);
		}
		
		MemberService service = new MemberService();
		Member member = service.login(id,pw);
		
		
		if(member != null && !member.getId().equals("")){
			HttpSession session =  req.getSession();
			
			//로그인성공
			
			session.setAttribute("member", member);
			session.setAttribute("userId", member.getId());
			System.out.println(member.getId()+"님 환영합니다.");
			
			
			if("Y".equals(member.getAdminyn())){
				//관리자인 경우 adminYN=Y
				session.setAttribute("adminyn","Y"); 
			}
			
			resp.sendRedirect("../book/list.book");
			//req.getRequestDispatcher("../book/list.book").forward(req, resp);
		
	
			
		} else{
			resp.sendRedirect("login.jsp?loginErr=Y");
		}
	
	}
	
	
	
	public LoginController() {
		// TODO Auto-generated constructor stub
	}

}
