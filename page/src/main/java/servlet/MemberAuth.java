package servlet;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDao;
import dto.Member;

public class MemberAuth extends HttpServlet{
	
	MemberDao dao ;
	Member member ;
	
	@Override
	public void init() throws ServletException {
		dao = new MemberDao();
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String admin_id = this.getInitParameter("admin_id");
		
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		
		member = dao.login(id, pw);
		
		if(member != null) {
			req.setAttribute("authMessage", member.getName()+"회원님 반갑습니다.");
			
			if(member.getId().equals(admin_id)) {
				req.setAttribute("authMessage", "admin_id"+"님은 관리자입니다.");
			}
			
		}else {
			req.setAttribute("authMessage", member.getName()+"로그인 실패");
		}
		
		req.getRequestDispatcher("./MemberAuth.jsp").forward(req, resp);
		
		
//		String str = URLEncoder.encode("MemberAuth.jsp");
//		str = URLEncoder.encode("../13서블릿/MemberAuth.jsp");
//		resp.sendRedirect(str);
	
	}
	

	
	public MemberAuth() {
		// TODO Auto-generated constructor stub
	}

}
