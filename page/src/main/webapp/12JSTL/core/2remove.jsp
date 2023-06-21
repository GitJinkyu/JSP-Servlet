<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 변수 선언 -->
<c:set var="scopeVar" value="Page Value"/> <!-- 스코프를 지정하지 않으면 page 영역 -->
<c:set var="scopeVar" value="request Value" scope="request"/>
<c:set var="scopeVar" value="session Value" scope="session"/>
<c:set var="scopeVar" value="application Value" scope="application"/>
	
	<h4>출력하기</h4>
	<ul>
		<li>page scope : ${scopeVar }</li>
		<li>request scope : ${requestScope.scopeVar }</li>
		<li>session scope : ${sessionScope.scopeVar }</li>
		<li>application scope : ${applicationScope.scopeVar }</li>
	</ul>


	<h4>session 영역에서 삭제하기</h4>
	<c:remove var="scopeVar" scope="session"/>
	<ul>
		<li>page scope : ${scopeVar }</li>
		<li>request scope : ${requestScope.scopeVar }</li>
		<li>session scope : ${sessionScope.scopeVar }</li>
		<li>application scope : ${applicationScope.scopeVar }</li>
	</ul>
	
	<!-- 영역을 지정하지 않고 삭제하기 -->
	<c:remove var="scopeVar" /> 
	<p>삭제할때 영역을 지정하지않으면 같은 이름의 모든 영역의 변수를 삭제함</p> 
	
	<ul>
		<li>page scope : ${scopeVar }</li>
		<li>request scope : ${requestScope.scopeVar }</li>
		<li>session scope : ${sessionScope.scopeVar }</li>
		<li>application scope : ${applicationScope.scopeVar }</li>
	</ul>
	



</body>
</html>