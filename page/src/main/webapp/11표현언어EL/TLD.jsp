<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 
	TLD(Tag Library Descriptor)
		JSP에서 사용되는 커스텀 태그나 JSTL의 태그들에 대한 설정파일
		WEB-INF 하위에 위치 작성해야 인식 가능함
		
	prefix : EL에서 사용할 접두어
	uri : tld 파일의 경로
 -->
 <%
 	pageContext.setAttribute("response", response);
 %>
 <%@ taglib prefix="myTag" uri="../WEB-INF/MyTagLib.tld" %>
 
 <h3>TLD 파일에 등록 후 정적 메서드 호출하기</h3>
 	<ul>
 		<li>${myTag:isNumber("HI!") }</li>
 		<li>${myTag:isNumber("100") }</li>
 		<li>${myTag:makeCookie("cName", "cValue", 10, response) }</li>
 		<li>${cookie.cName.value }</li>
 	</ul>
</body>
</html>