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

<header>
	userId	: ${sessionScope.userId }
	adminyn : ${sessionScope.adminyn }
	
	<!-- 어드민 -->
	<c:if test="${sessionScope.adminyn eq'Y'}" var="res">
	  <div id="logo">  
      </div>
      <div><a href="#">도서관리</a></div>
      <div><a href="#">사용자관리</a></div>
      <div><a href="../login/logout.do">로그아웃</a></div>
	</c:if>
	
	<c:if test="${not res }">
	  <div id="logo">  
      </div>
      <nav>
        <ul id="topMenu">
          <li><a href="#">도서관리시스템</a></li>
        </ul>
      </nav>
      <a href="#">마이페이지</a>
      
		<!-- 로그인 전 사용자 -->
		<c:if test="${empty sessionScope.userId}" var="res1">
			<div><a href="../login/login.jsp">로그인</a></div>
		</c:if>
		
		<!-- 사용자 -->
		<c:if test="${not res1 }">
			<div><a href="../login/logout.do">로그아웃</a></div>
		
		</c:if>
	
	</c:if>
	
	
	
	
</header>



</body>
</html>