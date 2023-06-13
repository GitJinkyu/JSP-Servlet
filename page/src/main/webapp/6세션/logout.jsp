<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
</head>
<body>
<%
	//세션의 기본 유효시간은 30분
	
	//방법1. 세션 무효화
	//session.invalidate();

	//방법2. 회원 인증 정보 속성 삭제
	session.removeAttribute("userId");
	session.removeAttribute("member");
	
	
	//세션 아이디 새로 발급
	request.getSession(true);
	
	//로그인화면으로 돌아가기
	response.sendRedirect("LoginForm.jsp");
	
%>

</body>
</html>