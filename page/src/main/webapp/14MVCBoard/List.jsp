<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
          <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
       <%@page import="dto.PageDto"%>   
          
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2>MVC 모델 2 게시판</h2>
	<p >총건수 : ${requestScope.TotalCnt }</p>
    <!-- 검색폼 --> 
    <form method="get" name="searchForm" >  
    <table border="1" width="90%">
    <tr>
        <td align="center">
    	<input type='hidden' name='pageNo'>
            <select name="searchField"> 
       	<!-- 검색했을때 검색 설정을 저장해놓기위해 param으로 받아와서 비교 ex(제목으로 검색했을때 검색후에도 검색이 체크상태) -->
                <option value="title" ${param.searchField eq "title" ? "selected" : " " }>제목</option> 
                <option value="content" ${param.searchField eq "content" ? "selected" : " " }>내용</option>
            </select>
            <input type="text" name="searchWord" value="${param.searchWord }"/>
            <input type="submit" value="검색하기" />
        </td>
    </tr>   
    </table>
    </form>
	
	
    <!-- 게시물 목록 테이블(표) --> 
    <table border="1" width="90%">
        <!-- 각 칼럼의 이름 --> 
        <tr>
            <th>번호</th>
            <th>작성자</th>
            <th>제목</th>
            <th>내용</th>
            <th>작성일</th>
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
					<td colspan='9' align="center">등록된 게시물이 없습니다.</td>
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
		            <td align="center"><a href="../mvcboard/view.do?idx=${dto.idx }">${dto.getTitle() }</a></td>         
		            <td align="center">${dto.getContent() }</td>         
		            <td align="center">${dto.getPostdate() }</td>  
		            <td align="center">${dto.getDowncount() }</td>
		            <td align="center">${dto.getVisitcount() }</td>      
		            <td align="center"><a href="Download.jsp?oName=${dto.ofile }&sName=${dto.sfile } ">다운로드</a></td>  
		        </tr>
			 </c:forEach>
		</c:if>
	
	
	 </table>
	 
	<!--목록 하단의 [글쓰기] 버튼-->
	<form action="../mvcboard/write.do" method="get">
    <table border="1" width="90%">
        <tr align="right">
            <td><button type="submit">글쓰기</button></td>
        </tr>
    </table>
    </form>
    
    <!-- 페이지블럭 생성 시작 -->
	<table border="1" width="90%">
		<tr>
			<td align="center">
			<%-- <c:import url="/14MVCBoard/PageNavi.jsp"></c:import> --%>
			<%@include file = "../9페이지/PageNavi.jsp" %>

			</td>
		</tr>
	</table>
	<!-- 페이지블럭 생성 끝 -->
</body>
</html>