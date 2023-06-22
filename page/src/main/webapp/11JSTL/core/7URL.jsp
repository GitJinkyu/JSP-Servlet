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
	<h4>url 태그를 이용해서 링크 걸기</h4>
	 	
	 <!-- 	
	 		c:URL
	 		지정한 경로와 매개변수를 이용해서 컨텍스트루트를 포함한 URL을 생성한다.
	 		a태그의 href 속성이나 form태그의 action 속성에 이용 할 수 있다.
	 		
	 		value	:경로
	 		var		:변수명
	 	
	 	 -->
	 	
	 	<a href="/12JSTL/inc/OtherPage.jsp">페이지 바로가기 </a> <br>
	 	
	 	<c:url value="/12JSTL/inc/OtherPage.jsp" var="url"></c:url>
	 	
	 	<a href="${url }">url태그를 이용한 페이지 바로가기 </a>
	 	
	 	<form action="${url }">
	 		<button>전송</button>
	 	</form>
	 	
	 	<h4>예외 처리</h4>
	 	<!-- 
	 	c:catch 태그
	 		예외가 발생하면 지정한 변수에 에러메세지가 저장되어 전달
	 	 -->
	 	 
	 	<%
	 		int num1 = 100;
	 	%>
	 	<c:catch var="eMessage">
	 	<%
	 		int res = num1/0;
	 	%>
	 	</c:catch>
	 	
	 	예외내용 : ${eMessage }
	 	
	 	
	 	<h4>EL에서의 예외</h4>
	 	<c:set var="num2" value="200"></c:set>
	 	
	 	<c:catch>
	 	${"일" + num2}
	 	</c:catch>
	 	
	 	 ${eMessage }
</body>
</html>