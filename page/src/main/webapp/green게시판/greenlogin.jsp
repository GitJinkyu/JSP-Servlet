<%@page import="util.CookieManager"%>
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
	String id = request.getParameter("userID");
	String pw = request.getParameter("userPW");
	
	out.print("id : "+ id+"<br>");
	out.print("pwd : "+ pw+"<br>");
	
	//쿠키 아이디 저장 체크박스
	String saveYN = request.getParameter("save_check");
	
	//아이디 저장하기 체크가 되어있다면
	//쿠키에 아이디를 저장한다
	if(saveYN != null && "Y".equals(saveYN)){
		//쿠키생성하는 메서드 호출
		CookieManager.makeCookie("userID", id, 3600, response);
		
	}
	
	//아이디가 abc, 비밀번호가 123이면 로그인 성공
	//id != null && id.equals("abc")
	if("abc".equals(id)&&"123".equals(pw)){
		//로그인 성공
		out.print("로그인 성공");
		
		//세션에 아이디 저장
		 session.setAttribute("id", id);
		
		
		//요청할 페이지 경로
		response.sendRedirect("gogreen.jsp");
		
	}else{
		//로그인실패
		out.print("로그인 실패");
		
		//요청할 페이지 경로
		response.sendRedirect("gogreen.jsp?loginErr=Y");
	}

%>
</body>
</html>