<%@page import="dto.Board"%>
<%@page import="common.JSFunction"%>
<%@page import="dao.NewBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file = "../6세션/isLogin.jsp" %>
<%@ include file = "../6세션/Link.jsp" %>
<%
		NewBoardDao dao = new NewBoardDao();
		Board board = new Board();
		int res = 0;

		//매개변수로 받는 방법
		//String title = request.getParameter("title");
		//String content = request.getParameter("content");
		//String id =  (String)session.getAttribute("userId");
		
		//매개변수로 받는 함수 호출
		//res = dao.writePost(title,content,id);
		
		
		//board 객체로 받는방법
		board.setTitle(request.getParameter("title"));
		board.setContent(request.getParameter("content"));
		board.setId((String)session.getAttribute("userId"));

		//board 객체로 받는 함수 호출
		res = dao.writePost(board);
	
		if(res > 0){
			JSFunction.alertLocation("글이 작성되었습니다", "List.jsp", out);
		}else{
			JSFunction.alertBack("글 작성 중 오류가 생겼습니다.", out);
		}
%>

</body>
</html>