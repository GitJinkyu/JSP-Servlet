
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 첨부형 게시판</title>
<script type="text/javascript">
	function setAction(action){
		viewForm.action=action;
	}
</script>
</head>
<body>
${map.message  }
<!-- 헤더 -->
<%@ include file="../common/header.jsp" %>
<h2>파일 첨부형 게시판 - 상세 보기(View)</h2>
<form name="viewForm" method="post" enctype="multipart/form-data" >
대여번호 : <input type="text" name="rentno" value="${view.rentno }">
도서번호 : <input type="text" name="no" value="${view.no }">
<table border="1">
    <colgroup>
        <col width="30%"/> 
        <col width="15%"/> <col width="20%"/>
        <col width="15%"/> <col width="20%"/>
    </colgroup>

    <!-- 게시글 정보 -->
    <tr>
        <td rowspan="3">
        	<img alt="${ view.title }이미지" width="200px" src="../images/bookImg/${view.sfile }">
        </td>
        <td>도서명</td><td>${ view.title }</td>
        <td>작가</td> <td>${ view.author }</td>
    </tr>
    <tr>
        <td>대여</td> 
        
        	<c:choose>
        		
        		<c:when test="${empty view.rentno}">
	        		<td><button onclick="setAction('../book/rent.book?no=${view.no}')">대여하기</button></td>
	        		<td>대여여부</td><td>${ view.rentyn }</td>
	        				
        		</c:when>
        		<c:when test="${view.id eq sessionScope.userId }"> 
        			<td><button onclick="setAction('../book/return.book?no=${view.no}')">반납하기</button></td>
        			<td>대여기간</td> <td>${ view.startDate } ~ ${ view.endDate }</td>
        		</c:when>
        		<c:otherwise>
        			<td>대여중</td>
        			<td>대여기간</td> <td>${ view.startDate } ~ ${ view.endDate }</td>
        		</c:otherwise>
        	</c:choose>
    </tr>
    <tr>
    	<td height="200px">상세설명</td><td colspan="3"></td>
    </tr>
    <!-- 하단 메뉴(버튼) -->
    <tr>
        <td colspan="5" align="center">
            <button type="button" onclick="location.href='./edit.book?no=${view.no}';">
                수정하기
            </button>
            <button type="button" onclick="location.href='../book/delete.book?delNo=${ view.no }';">
            	삭제하기
            </button>
            <button type="button" onclick="location.href='../book/list.book';">
                목록 바로가기
            </button>
           	<c:if test=""></c:if>
           	
            
            
        </td>
    </tr>
</table>
</form>
</body>
</html>
