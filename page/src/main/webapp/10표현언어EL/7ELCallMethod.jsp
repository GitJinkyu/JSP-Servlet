<%@page import="util.CookieManager"%>
<%@page import="EL.MyElClass"%>
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
	MyElClass myClass = new MyElClass();
	pageContext.setAttribute("myClass", myClass);
	pageContext.setAttribute("response", response);
%>

	<h3>영역에 저장 후 메서드 호출하기</h3>
		001129-3000000 => ${myClass.getGender("001129-3000000") } <br>
		001129-4000000 => ${myClass.getGender("001129-4000000") } <br>
		<br>
		
		
	<h3>정적메서드 호출하기</h3>	
	<p>생성자 필요없이 바로 클래스명.메서드명으로 호출 가능</p>
		isNumber? => ${MyElClass.isNumber("isNumber") } <br>
		1~9단 출력 => ${MyElClass.showGugudan(9) }
		
	<h3>정적메서드 호출하기 - 쿠키 생성하기</h3>
	${CookieManager.makeCookie("ELCookie", "EL좋아요!", 10, response) } <br>
	${cookie.ELCookie.value }
		
	
	<h3>메서드 호출하기</h3>
	${"123-123".replace("-","") }


</body>
</html>