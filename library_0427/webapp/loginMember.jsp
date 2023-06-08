<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@page import="com.library.vo.Member"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//세션에 저장된 멤버 객체로 부터 아이디를 출력해온다.
	if(session.getAttribute("member") != null){
		Member m = (Member)session.getAttribute("member");
%>
	<%=m.getId() %>님 환영합니다.
	
	<button onclick="location.href='logout.jsp'">로그아웃</button>
	
	<h2>사용자 메뉴</h2>
	<ul>
		<li>도서대여</li>
		<li>도서반납</li>
		<li>도서대여현황</li>
	</ul>
<%
}
%>
</body>
</html>