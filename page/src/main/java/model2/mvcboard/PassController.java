package model2.mvcboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JFileChooser;

import common.JSFunction;
import model2.mvcboard.dao.MVCBoardDAO;
import model2.mvcboard.dto.MVCBoardDTO;

@WebServlet("/mvcboard/pass.do")
public class PassController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//화면 전환
		req.getRequestDispatcher("/14MVCBoard/Pass.jsp").forward(req, resp);
	}
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//값 받아와서 변수에 저장해놓기
		String idx = req.getParameter("idx");
		String mode = req.getParameter("mode");
		String pass = req.getParameter("pass");
		
		
		//리퀘스트 영역 저장
		req.setAttribute("idx", idx);
		req.setAttribute("mode", mode);
		req.setAttribute("pass", pass);
		
		MVCBoardDAO dao = new MVCBoardDAO();
		
		boolean confirmed = dao.confirmPassword(pass,idx);
		
		//비밀번호가 일치할 경우 
		if(confirmed) {
		 
			System.out.println("비밀번호 검증 성공");
			if(mode.equals("edit")) {
				System.out.println("mode 값은 : "+mode);
				//화면 페이지 전환
				resp.sendRedirect("../mvcboard/edit.do?idx="+idx);
				//req.getRequestDispatcher("../mvcboard/edit.do?idx="+idx).forward(req, resp);
				
			}else if(mode.equals("delete")){
				//삭제
				System.out.println("mode 값은 : "+mode);
				
				int res = dao.delete(idx);
				
				if(res > 0) {
					//삭제 성공
					JSFunction.alertLocation(resp, "게시물 삭제 성공하였습니다.", "../mvcboard/list.do");
				}else {
					//삭제 실패
					JSFunction.alertBack(resp, "게시물 삭제 중 오류 발생");
				}
				
				
			}
		//비밀번호 불일치할 경우
		}else {
			JSFunction.alertBack(resp,"비밀번호 검증에 실패 하였습니다.");
		}
		
	}
	
	
	public PassController() {
		// TODO Auto-generated constructor stub
	}

}
