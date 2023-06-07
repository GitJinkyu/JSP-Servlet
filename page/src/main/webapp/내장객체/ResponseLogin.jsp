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
	String id = request.getParameter("user_id");
	String pw = request.getParameter("user_pwd");
	
	out.print("id : "+ id+"<br>");
	out.print("pwd : "+ pw+"<br>");
	
	//아이디가 abc, 비밀번호가 123이면 로그인 성공
	//id != null && id.equals("abc")
	if("abc".equals(id)&&"123".equals(pw)){
		//로그인 성공
		out.print("로그인 성공");
		
		//요청할 페이지 경로
		response.sendRedirect("ResponseWelcome.jsp");
		
	}else{
		//로그인성공
		out.print("로그인 실패");
		
		//요청할 페이지 경로
		response.sendRedirect("ResponseMain.jsp?loginErr=Y");
	}

%>
</body>
</html>