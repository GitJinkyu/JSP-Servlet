<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="dto.Criteria"%>
<%@page import="dto.PageDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
	function go(page){
		document.searchForm.pageNo.value=page;
		document.searchForm.submit();
	}
</script>

</head>
<body>

<c:set var="pageDto" value="${pageDto }"/>

<!-- 첫페이지버튼 -->
<input type='button' value='처음으로' onclick='go(1)'>

<!-- 이전버튼 -->
<c:if test="${pageDto.prev }">
	<input type='button' value='이전' onclick='go(${pageDto.startNo-1})'>
</c:if>

<!-- 페이지번호 출력 -->
<c:forEach begin="${pageDto.startNo }" end="${pageDto.endNo }" var="i">
	<input type='button' value='${i }' onclick='go(${i})'>
</c:forEach>

<!-- 다음버튼 -->
<c:if test="${pageDto.next }">
	<input type='button' value='다음' onclick='go(${pageDto.endNo+1})'>		
</c:if>

<!-- 마지막페이지버튼 -->
<input type='button' value='끝으로' onclick='go(${pageDto.realEnd})'>

</body>
</html>




















