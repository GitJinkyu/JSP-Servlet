<%@page import="dto.Person"%>
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
 request.setAttribute("request_str", "request");
 request.setAttribute("request_int", 10000);
 request.setAttribute("request_Person", new Person("하니",20));
%>

	<h2>request 영역의 속성값 읽어 오기</h2>
	<%
		String str = (String)request.getAttribute("request_str");
		int request_int = (Integer)request.getAttribute("request_int");
		Person person = (Person)request.getAttribute("request_Person");
	%>
	
	<ul>
		<li><%=str%></li>
		<li><%=request_int%></li>
		<li><%=person.getName()%>,<%=person.getAge()%></li>
	</ul>
	
	<h2>request 영역의 속성값 삭제하기</h2>
	<%
		request.removeAttribute("request_str");
		request.removeAttribute("request_int");
	%>
	request_str 삭제: <%=request.getAttribute("request_str") %>
	
	<h2>forward된 페이지에서 request 영역 속성값 읽어 오기</h2>
	<%
	
	request.getRequestDispatcher("RequestForward.jsp").forward(request,response);
	
	%>
	
	
	
	
	
	
	
	
</body>
</html>