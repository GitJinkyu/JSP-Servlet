<%@page import="dto.Member"%>
<%@page import="dao.MemberDao"%>
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
	String id = request.getParameter("user_id");
	String pw = request.getParameter("user_pw");
	
	MemberDao dao = new MemberDao();
	Member member = dao.login(id, pw);
	
	if(member != null){
		//로그인 성공 -> 세션에 member 객체를 저장
		session.setAttribute("userId", member.getId()); 
		session.setAttribute("member", member);
		
		response.sendRedirect("LoginForm.jsp");
		
	}else{
		//로그인 실패 ->loginForm 페이지로 다시 이동, 확인을 위해 오류 메세지 출력
		
		//리퀘스트 영역에 속성 저장
		request.setAttribute("LoginErrMsg", "아이디/비밀번호를 확인해주세요.");
		
		//LoginForm으로 포워드
		request.getRequestDispatcher("LoginForm.jsp").forward(request, response);
	}
	

%>


</body>
</html>