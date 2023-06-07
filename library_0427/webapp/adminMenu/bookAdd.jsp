<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.library.service.BookService"  %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
		BookService bookService = new BookService();
		String title = request.getParameter("title");
		String author = request.getParameter("author");
	
		bookService.insert(title, author);
		out.print(bookService.getList());

%>
</body>
</html>