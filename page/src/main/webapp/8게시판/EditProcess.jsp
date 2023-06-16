<%@page import="common.JSFunction"%>
<%@page import="dao.NewBoardDao"%>
<%@page import="dto.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file ="../6세션/isLogin.jsp"%>

<%
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String num = request.getParameter("num");

	
	String id = (String)session.getAttribute("userId");
	
	Board board =new Board(num,title,content,id,"","");
	
	NewBoardDao dao = new NewBoardDao();
	
	int res = dao.edit(board);
	
	if (res > 0 ){
		JSFunction.alertLocation("수정되었습니다.", "View.jsp?num="+num, out);
		
	}else {
		JSFunction.alertBack("수정 중 오류가 발생하였습니다.", out);
	}
	
	
	
%>
</body>
</html>