<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.Arrays" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//한글깨짐 처리
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("userID");
	String gender = request.getParameter("gender");
	
	//줄바꿈이 있는 경우 \r\n -> <br>로 .replace해야함
	String intro = request.getParameter("intro");
	
	//체크박스는 여러개가 선택 될수있기때문에 배열형태로 받아서 처리해야한다
	String[] hobby = request.getParameterValues("hobby");
	String hobbyStr ="";
	out.print(Arrays.toString(hobby));
	
%>
<ul>
	<li>아이디: <%= id %></li>
	<li>성별: <%= gender %></li>
	<li>관심사항: <%= Arrays.toString(hobby) %></li>	
	
	<!-- 줄바꿈처리 -->
	<!-- 줄바꿈이 있는 경우 \r\n -> <br>로 .replace해야함 -->
	<li>자기소개: <%= intro.replace("\n\r","<br>") %></li>
</ul>
</body>
</html>