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
<script>
	function go(page){
		document.searchForm.pageNo.value=page;
		document.searchForm.submit();
	}
</script>

<!--생성자를 영역에 저장 -->
<c:set var="pageDto" value="<%=pageDto %>"></c:set>

	<!-- 맨 앞 페이지로 가기 -->
	<input type='button' value='맨앞으로' onclick='go(${1})'>

	<!-- 이전 페이지 가기 -->
	<c:if test="${pageDto.prev }">
		<input type='button' value='이전' onclick='go(${pageDto.getStartNo()-1 })'>
	</c:if>
	
	<!-- 페이지 번호 출력 -->
	<c:forEach begin="${pageDto.getStartNo() }" end="${ pageDto.getEndNo() }" var="page" varStatus="loop">
		<input type='button' value=${page } onclick='go(${page})'>
	</c:forEach>
	
	
	<!-- 다음 페이지 가기 -->
	<c:if test="${pageDto.next }">
		<input type='button' value='다음' onclick='go(${pageDto.getEndNo()+1 })'>
	</c:if>
	
	<!-- 마지막 페이지 가기 -->
	<input type='button' value='끝으로' onclick='go(${pageDto.getRealEnd()})'>
	
</body>
</html>