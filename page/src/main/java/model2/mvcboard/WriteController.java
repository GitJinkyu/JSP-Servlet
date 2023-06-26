package model2.mvcboard;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import common.FileUtil;
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
		
		String saveDirectory = "c:/upload";
		//파일업로드: 업로드드 경로,최대 사이즈
		MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, 1024*1000);
		
		if(mr == null) {
			//파일 업로드 실패
			JSFunction.alertBack(resp, "파일업로드중 오류가 발생하였습니다.");
			return;
		}
		
		//파일 업로드 외에 저장
		//form 값을 DTO에 저장
		MVCBoardDTO dto = new MVCBoardDTO();
		
		dto.setName(mr.getParameter("name"));
		dto.setTitle(mr.getParameter("title"));
		dto.setContent(mr.getParameter("content"));
		dto.setPass(mr.getParameter("pass"));
		
		//원본 파일명과 저장된 파일이름
		//2. 새로운 파일명 생성
		//	동일한 파일명이 계속 업로드 될 경우 , 기존파일을 덮어쓰기하므로 파일명을 변경해서 저장해야함
		String fileName = mr.getFilesystemName("attachedFile");
		
		
		if(fileName != null) {
			// 첨부파일의 확장자
			String ext = fileName.substring(fileName.lastIndexOf("."));
			
			
			// H : 0~23, S: milisecond
			// 현재시간을 파일이름으로 지정
			String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
			String oFileName = fileName.substring(0,fileName.lastIndexOf("."));
			
			String newFileName = oFileName +"_"+ now + ext;
			
			//3.파일명 변경
			File oldFile = new File(saveDirectory + File.separator + fileName);
			File newFile = new File(saveDirectory + File.separator + newFileName);
			oldFile.renameTo(newFile);
			
			//dto에 파일명 저장
			
			dto.setOfile(fileName); //원본파일명
			dto.setSfile(newFileName); //저장파일명
			
		}else {
			dto.setOfile(null); //원본파일명
			dto.setSfile(null); //저장파일명
		}
		
		MVCBoardDAO dao = new MVCBoardDAO();
		int res = dao.insert(dto);
		
		System.out.println("res = " + res);
		
		if(res>0) {
			JSFunction.alertLocation(resp, "작성되었습니다.","../mvcboard/list.do");
		}else {
			JSFunction.alertBack(resp, "작성중 오류가 발생하였습니다. 관리자에게 문의해주세요.");
		}
		
	}
	public WriteController() {
		// TODO Auto-generated constructor stub
	}

}
