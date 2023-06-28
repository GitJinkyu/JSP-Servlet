package common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

public class FileUtil {
	
	/**
	 * 파일 다운로드
	 * @param request
	 * @param response
	 * @param saveDirectory
	 */
	public static void Download(HttpServletRequest request
									, HttpServletResponse response
									, String saveDirectory) {
		
		//원본 파일 이름
		String originalFileName = request.getParameter("ofile");
		//저장된 파일 이름
		String saveFileName = request.getParameter("sfile");

		
		try{
			File file = new File(saveDirectory,saveFileName);
			
			System.out.println("file : "+ file);
			
			//파일 입력 스트링 생성
			InputStream inStream = new FileInputStream(file);
			
			//한글 파일명 깨짐 방지
			String client = request.getHeader("User-Agent");
			//ie체크
			if(client.indexOf("WOW64")== -1 ){
				originalFileName = new String(originalFileName.getBytes("UTF-8"),"ISO-8859-1");
			}else{
				originalFileName = new String(originalFileName.getBytes("KSC5601"),"ISO-8859-1");
			}
			
			
			
			
			//파일 다운로드용 응답 헤더 설정
			response.reset();
			
			//파일 다운로드 창을 띄우기 위한 컨텐츠 타입을 지정
			// octet - stream은 8비트 단위의 바이너리 데이터를 의미
			response.setContentType("application/octet-stream");
			
			//원본파일이름으로 다운로드 받을 수 있게 설정
			response.setHeader("Content-Disposition", "attachement; filename=\""+ originalFileName + "\"");
			
			response.setHeader("Content-Length",""+	file.length());
			
			//출력스트림 초기화
			//기존out객체를 비우고 새로 쓸 준비를 함
			//out.clear();
			//out = pageContext.pushBody();
			
			//response 내장 객체로부터 새로운 출력 스트림을 생성
			OutputStream outStream = response.getOutputStream();
			
			//출력 스트림에 파일 내용 출력
			byte b[] = new byte[(int)file.length()];
			int readBuffer = 0;
			while ((readBuffer = inStream.read(b)) > 0){
				outStream.write(b,0,readBuffer);
			}
			
			//입/출력 스트림 모음;
			inStream.close();
			outStream.close();
		}
		catch(FileNotFoundException e){
			JSFunction.alertBack(response, "파일을 찾을수 없습니다.");
			
		}catch(Exception e){
			JSFunction.alertBack(response, "파일 다운로드중 오류가 발생하였습니다.");
			
			
		}
		
	}
	
	
	/**
	 * 파일 업로드
	 * @return
	 */
	public static MultipartRequest uploadFile(HttpServletRequest request
													,String saveDirectory
													,int maxPostSize) {
		
	try {
		//파일 업로드
		return new MultipartRequest(request,saveDirectory,maxPostSize,"UTF-8");
		
		
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		return null;
	}
		
	}
	
	/**
	 * 파일 삭제 
	 */
	public static void deleteFile(String saveDirectory,String filename) {
		File file = new File(saveDirectory+File.separator+filename);
		
		//파일이 존재하면 제거
		if(file.exists()) {
			file.delete();
			
		}
		
	}
	
	
	
	
	public FileUtil() {
		// TODO Auto-generated constructor stub
	}

}
