<%@page import="com.util.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.library.service.MemberService"  %>
<%@page import="com.library.vo.Member"  %>
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
			
			//아이디 저장 체크박스
			String saveYN = request.getParameter("save_check");
			
			
			//아이디 저장하기 체크가 되어있다면
			//쿠키에 아이디를 저장한다
			if(saveYN != null && "Y".equals(saveYN)){
				//쿠키생성하는 메서드 호출
				CookieManager.makeCookie("userID", id, 3600, response);
			}
			
			MemberService service = new MemberService();
			Member member = service.login(id,pw);
			
			//세션에 아이디 저장		
			session.setAttribute("member", new Member(id,pw));
			
			if(member != null && !member.getId().equals("")){
				out.print(member.getId()+"님 환영합니다.");
				if("Y".equals(member.getAdminyn())){
					//로그인성공		
			
					//관리자페이지 호출
					response.sendRedirect("loginAdmin.jsp");
				}else{
					//사용자 페이지 호출
					response.sendRedirect("loginMember.jsp");
				}
				
			} else{
				response.sendRedirect("login.jsp?loginErr=Y");
			}
		%>

</body>
</html>