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
<h2>도서 목록</h2>
<p >총건수 :  </p>

<!-- 검색폼 -->
<%@ include file="../common/searchForm.jsp" %>
<!-- 검색폼 끝 -->    
	
    <!-- 게시물 목록 테이블(표) --> 
    <table border="1" width="90%">
        <!-- 각 칼럼의 이름 -->
        
        <c:if test="${sessionScope.adminyn eq 'Y' }">
	        <tr>
	        	<td colspan="5" class="right">
	        	<!-- 어드민 계정인 경우 등록,삭제 버튼을 출력 -->
	        	<button>도서 등록</button>
	        	<button>도서 삭제</button>
	        	</td>
	        </tr> 
        </c:if>
        
        <tr>
        	<th></th>
            <th>번호</th>
            <th>도서명</th>
            <th>저자</th>
            <th>대출여부</th>
        </tr>
        
        <!-- 목록의 내용 --> 
        <!-- JSTL 사용 -->
        <c:set var="list" value="${requestScope.list }"/>
        
        <c:if test="${empty list }" var="result">
	 	<!-- 조건이 참인 경우 실행되는 부분 -->
		 	<tr>
				<td colspan='5' align="center">등록된 게시물이 없습니다.</td>
			</tr>
	 	</c:if>
	 	
	 	<c:if test="${not result }" >
 		<!-- 
 		반복문을 통해 리스트에 담긴 board 객체를 출력
 		items : 향상된 for문
 		 -->
			<c:forEach items="${list }" var="book">
		        <tr align="center">
		        	<td class="center">
		        	<input type="checkbox" name="delNo" value=${book.no }>
		        	</td>
		            <td align="center">${book.getNo() }</td>         
		            <td align="center"><a href="../book/view.book?no=${book.no }">${book.getTitle() }</a></td>         
		            <td align="center">${book.getAuthor() }</td>         
		            <td align="center">${book.getRentyn() }</td>         
					
				
		        </tr>
			 </c:forEach>
		</c:if>
	 </table>

</body>
</html>