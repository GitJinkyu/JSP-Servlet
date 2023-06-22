package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@어노테이션을 지정해주면 web.xml에 추가안해줘도 매핑됨
@WebServlet("/13서블릿/AnnotationMapping.do")
//HttpServlet객체를 상속받은 클래스를 서블렛이라고한다
public class AnnotationMapping extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setAttribute("message", "AnnotationMapping.do 호출");
		
		req.getRequestDispatcher("HelloServlet.jsp").forward(req, resp);
	}

	public AnnotationMapping() {
		// TODO Auto-generated constructor stub
	}

}
