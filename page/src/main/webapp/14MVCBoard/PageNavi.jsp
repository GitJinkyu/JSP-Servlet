<%@page import="dto.Criteria"%>
<%@page import="dto.PageDto"%>
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

	<!-- 컨트롤러에서 생성한 pageDto 넘겨받기 -->
	<c:set var="pageDto" value="${pageDto }"></c:set>
../mvcboard/list.do

	<!-- 맨 앞 페이지로 가기 -->
	<a href='List.do?pageNo=1'>첫페이지</a>
	
	<!-- 이전 페이지 가기 -->
	<c:if test="${pageDto.isPrev() }">
		<a href='List.do?pageNo=${pageDto.startNo-1 }'>이전</a>
	</c:if>
	
	
	<c:forEach begin="${pageDto.startNo }" end="${pageDto.endNo }" var="i">
		<a href='List.do?pageNo=${i }'>${i }</a>
	</c:forEach>
	

	<!-- 다음 페이지 가기 -->
	<c:if test="${pageDto.isNext() }">
		<a href='List.do?pageNo=${pageDto.endNo+1 }'>다음</a>
	</c:if>
	
	<!-- 마지막 페이지로 가기 -->
	<a href='List.do?pageNo=${pageDto.realEnd }'>마지막페이지</a>
	
	
	
	

	



</body>
</html>