<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠키 값 출력하기</title>
</head>
<body>
	
	<h2>쿠키값 확인하기</h2>
	<p>처음 접속시 저장된 쿠키가 없는 경우 빈 페이지가 출력 될 수 있다</p>
	<%
	Cookie[] cookies = request.getCookies();
	if(cookies != null){
		for(Cookie cookie : cookies){
			String cookieName = cookie.getName();
			String cookieValue = cookie.getValue();
			
			out.print("cookieName : "+cookieName);
			out.print("<br>");
			out.print("cookieValue : "+cookieValue);
			out.print("<br><br>");
		}
		
	}
	
	
	
	%>
	
	
</body>
</html>