<%@page import="util.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>하루동안 팝업창이 열리지 않도록 쿠키 생성</title>
</head>
<body>
	<h2>쿠키를 활용한 팝업창 제어</h2>
	
	<%
		//하루동안 팝업창이 열리지 않도록 쿠기 생성
		CookieManager.makeCookie("PopupClose", "Y", 60*60*24, response);
		//response.sendRedirect("PopupMain.jsp");
	%>
</body>
</html>