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
	
	<h2>MVC 모델 2 게시판</h2>
    <!-- 게시물 목록 테이블(표) --> 
    <table border="1" width="90%">
        <!-- 각 칼럼의 이름 --> 
        <tr>
            <th>번호</th>
            <th>작성자</th>
            <th>제목</th>
            <th>내용</th>
            <th>작성일</th>
            <th>원본파일명</th>
            <th>새파일명</th>
            <th>다운로드횟수</th>
            <th>조회수</th>
            <th>다운로드</th>
        </tr>
        
        <!-- 목록의 내용 --> 
        <!-- JSTL 사용 -->
        <c:set var="list" value="${requestScope.boardlist }"/>
        
        <c:if test="${empty list }" var="result">
	 	<!-- 조건이 참인 경우 실행되는 부분 -->
		 	<tr>
					<td colspan='11' align="center">등록된 게시물이 없습니다.</td>
			</tr>
	 	</c:if>
	 	
	 	<c:if test="${not result }" >
	 		<!-- 
	 		반복문을 통해 리스트에 담긴 board 객체를 출력
	 		items : 향상된 for문
	 		 -->
			<c:forEach items="${list }" var="dto">
		        <tr align="center">     
		            <td align="center">${dto.getIdx() }</td>         
		            <td align="center">${dto.getName() }</td>         
		            <td align="center">${dto.getTitle() }</td>         
		            <td align="center">${dto.getContent() }</td>         
		            <td align="center">${dto.getPostdate() }</td>  
		            <td align="center">${dto.getOfile() }</td>         
		            <td align="center">${dto.getSfile() }</td>
		            <td align="center">${dto.getDowncount() }</td>
		            <td align="center">${dto.getVisitcount() }</td>      
		            <td align="center"><a href="Download.jsp?oName=${dto.ofile }&sName=${dto.sfile } ">다운로드</a></td>  
		        </tr>
			 </c:forEach>
		</c:if>
	
	 </table>
	 
	<!--목록 하단의 [글쓰기] 버튼-->
	<form action="Write.do" method="get">
    <table border="1" width="90%">
        <tr align="right">
            <td><button type="submit">글쓰기</button></td>
        </tr>
    </table>
    </form>
</body>
</html>