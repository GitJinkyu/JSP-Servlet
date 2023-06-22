package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class HelloServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setAttribute("message", "서블릿 호출");
		PrintWriter out = res.getWriter();
		out.print("<h1>서블릿호출<h1>");
		
		//샌드다이렉트는 request 영역 공유 안됨
		//res.sendRedirect("HelloServlet.jsp");
		
		//포워드는 request 영역을 공유 함
		//req.getRequestDispatcher("HelloServlet.jsp").forward(req, res);
	}

	public HelloServlet() {
		// TODO Auto-generated constructor stub
	}

}
