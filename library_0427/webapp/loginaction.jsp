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

			
			MemberService service = new MemberService();
			Member member = service.login(id,pw);
			
			if(member != null && !member.getId().equals("")){
				out.print(member.getId()+"님 환영합니다.");
				if("Y".equals(member.getAdminyn())){
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