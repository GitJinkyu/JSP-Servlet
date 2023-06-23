package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.JSFunction;
import model2.mvcboard.dao.MVCBoardDAO;
import model2.mvcboard.dto.MVCBoardDTO;

public class WriteController extends HttpServlet {
	
	
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
			//화면 페이지 전환
			req.getRequestDispatcher("/14MVCBoard/Write.jsp").forward(req, resp);
	
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			int res= 0;
			
			String name = req.getParameter("name");
			String title = req.getParameter("title");
			String content = req.getParameter("content");
			String pass = req.getParameter("pass");
			
			MVCBoardDAO dao = new MVCBoardDAO();
			MVCBoardDTO dto = new MVCBoardDTO("",name,title,content,"","","","",pass,"");
			dto.setName(name);
			dto.setTitle(title);
			dto.setContent(content);
			dto.setPass(pass);

			//글 작성
			res = dao.insert(dto);
			
			if (res > 0) {
		        // 글 작성 성공한 경우 처리
				JSFunction.alertLocation(resp, "글 작성 성공", "../mvcboard/write.do");
			
		    } else {
		        // 글 작성 실패한 경우 처리
		        // 적절한 오류 처리를 수행하거나 다시 작성 페이지로 이동하는 등의 로직을 구현
		    	System.out.println("오류발생");
		    	JSFunction.alertBack(resp, "글 작성중 오류 발생했습니다.");
		    }
	
		
	}
	public WriteController() {
		// TODO Auto-generated constructor stub
	}

}
