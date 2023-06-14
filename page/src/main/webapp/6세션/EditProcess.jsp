<%@page import="common.JSFunction"%>
<%@page import="dto.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 작성도중 세션만료되었을 경우 처리 -->
<%@include file="isLogin.jsp" %>

<%
	request.setCharacterEncoding("utf-8");

	int res=0;
	BoardDao Bdao = new BoardDao();
	Board board = new Board();
	
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	//사용자가 로그아웃을 하지 않았더라도
	//일정시간이 경과되면 세션이 제거되므로 오류가 발생할수있다

	
	res = Bdao.edit(title, content, request.getParameter("num"));

	if(res>0){
		JSFunction.alertLocation("✔ 글이 수정되었습니다.", "List.jsp", out);

	}else{
		JSFunction.alertBack("❌ 글 수정중 에러가 발생했습니다.", out);

}
	
	
%>
</body>
</html>