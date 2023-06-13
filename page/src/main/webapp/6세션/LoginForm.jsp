<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head><title>Session</title></head>
<body>
	<jsp:include page="Link.jsp" />
    <h2>로그인 페이지</h2>
    <span style="color: red; font-size: 1.2em;"> 
    </span>
    
<%=
	//로그인 실패시 에러메세지 출력
	request.getAttribute("LoginErrMsg") == null ?
		 "" : request.getAttribute("LoginErrMsg")
%>
   
   
<!-- 
	1. 로그인 성공시 로그인 폼을 숨긴다.
	2. 로그인 사용자 이름과 환영합니다 문구 출력
 -->    
<%
	if(session.getAttribute("userId") != null){
%>
		<h1><%=session.getAttribute("userId")%>님 환영합니다.</h1>
<% 			
	}else{
%>
    <form action="LoginProcess.jsp" method="post" name="loginFrm"
        onsubmit="return validateForm(this);">
        아이디 : <input type="text" name="user_id" required="required"/><br />
        패스워드 : <input type="password" name="user_pw" required="required"/><br />
        <input type="submit" value="로그인하기" />
    </form>
<%
    }
%>
</body>
</html>