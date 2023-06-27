<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 헤더 -->
<%@ include file="../common/header.jsp" %>

<h2>도서 등록</h2>
<form name="writeFrm" methd="post" action="../book/insert.book">
	<table border="1" width="90%">
	
	    <colgroup>
	        <col width="15%"/> <col width="35%"/>
	        <col width="15%"/> <col width="*"/>
	    </colgroup>
	
	    <!-- 게시글 정보 -->
	    <tr>
	        <td>도서명</td> <td><input type="text" name="title" style="width:150px;" /></td>
	    </tr>
	    <tr>
	        <td>저자</td> <td><input type="text" name="author" style="width:150px;" /></td>
	    </tr>
	
	    <!-- 하단 메뉴(버튼) -->
	    <tr>
	        <td colspan="2" align="center">
	            <button type="submit">등록하기</button>
	            <button type="reset">다시 작성</button>
	            <button type="button" onclick="location.href='../book/list.book';">목록</button>
	        </td>
	    </tr>
	</table>
</form>
</body>
</html>