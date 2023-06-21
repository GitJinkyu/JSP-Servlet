<%@page import="common.JSFunction"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Arrays"%>
<%@page import="fileupload.fileDto"%>
<%@page import="fileupload.fileDao"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="javax.swing.plaf.multi.MultiMenuItemUI"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	//저장할 디렉터리의 실제 경로
	String saveDirectory = "C:/Upload";

	//파일의 최대 크기(1MB)
	int maxPostSize = 1024 * 1000;
	
	//인코딩 방식
	String encoding ="utf-8";

	try{
		// 1. MultipartRequest 객체 생성
		//		생성자의 매개변수로 저장경로, 파일의 최대크기, 인코딩 방식을 지정
		//		걱체가 정상적으로 생성되면 파일은 업로드 된다.
	MultipartRequest mr = new MultipartRequest(request,saveDirectory,maxPostSize,encoding);
	
	
	
	
	//2. 새로운 파일명 생성
	//	동일한 파일명이 계속 업로드 될 경우 , 기존파일을 덮어쓰기하므로 파일명을 변경해서 저장해야함
	String fileName = mr.getFilesystemName("attachedFile");
	
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
	
	
	
	//폼 요소의 값을 저장
	String name = mr.getParameter("name");
	String title = mr.getParameter("title");
	// 체크박스인 경우, 배열로 반환 받아서 문자열로 연결해서 저장
    String[] categoryArr = mr.getParameterValues("category");
    StringBuffer sb = new StringBuffer();
    if(categoryArr == null){
    	sb.append("선택없음");
    } else {	    	
	    for(String category : categoryArr){
	    	sb.append(category+",");
	    }
    }
    
    
    System.out.println("name : " + name);
    System.out.println("title : " + title);
    System.out.println("category : " + sb.toString());
    System.out.println("ofileName : " + fileName);
		
	// DTO 생성
	fileDto dto = new fileDto("",name,title,sb.toString(),fileName,newFileName,"");
	
	// DAO를 통해서 데이터베이스에 등록
	fileDao dao = new fileDao();
	
	int res = dao.insertFile(dto);
	
	if(res>0){
		//파일목록페이지로 이동
		JSFunction.alertLocation("등록되었습니다", "2FileList.jsp", out);
		
	}else{
		//이전페이지로 이동
		JSFunction.alertBack("파일 등록 실패하였습니다", out);
	}
	
		
	}catch(Exception e){
		e.printStackTrace();
		out.print(e);
		request.setAttribute("errorMessage", "파일업로드 오류 ");
		JSFunction.alertBack("파일업로드 오류 ", out);
		
		
	}
	
%>




</body>
</html>