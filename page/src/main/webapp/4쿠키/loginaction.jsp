
<%@page import="dto.Member"%>
<%@page import="dao.MemberDao"%>
<%@page import="util.CookieManager"%>
<%@page import="java.net.URLEncoder"%>
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
String id = request.getParameter("userID");
	String pw = request.getParameter("userPW");
	
	MemberDao dao = new MemberDao();
	Member member = dao.login(id, pw);
	
	//아이디 저장 체크박스
	String saveYN = request.getParameter("save_check");
	
	
	//아이디 저장하기 체크가 되어있다면
	//쿠키에 아이디를 저장한다
	if("Y".equals(saveYN)){
		
		//쿠키생성하는 메서드 호출
		CookieManager.makeCookie("userID", id, 3600, response);
		
		/* 메서드를 쓰면 더이상 아래방법은 안써도됨  
		//userID, 사용자 아이디
		Cookie cookie = new Cookie("userID",
		URLEncoder.encode(id,"utf-8"));
		
		//쿠키 유지시간 설정
		cookie.setMaxAge(3600);
		
		//응답객체에 쿠키 담기
		response.addCookie(cookie);
		*/
	}
	
	
	
	//DB 조회결과 id/pw가 일치하는 회원이 있으면 로그인 성공
	if(member != null && !"".equals(member.getName())){
		//로그인 성공
		out.print("로그인 성공");
		
		//요청할 페이지 경로
		response.sendRedirect("login.jsp?name="+id);
		
	}else{
		//로그인실패
		out.print("로그인 실패");
		
		//요청할 페이지 경로
		//response.sendRedirect("login.jsp?loginErr=Y");
	}
%>
</body>
</html>