<%@page import="java.net.URLEncoder"%>
<%@page import="fileupload.fileDao"%>
<%@page import="fileupload.fileDto"%>
<%@page import="java.util.List"%>
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
<%
fileDto dto = new fileDto();
fileDao dao = new fileDao();
List<fileDto> filelist = dao.getFileList(dto);

%>



<h2>DB에 등록된 파일 목록 보기</h2>
<a href="1FileUpload.jsp">파일등록하기</a> 
    <!-- 게시물 목록 테이블(표) --> 
    <table border="1" width="90%">
        <!-- 각 칼럼의 이름 --> 
        <tr>
            <th>번호</th>
            <th>작성자</th>
            <th>제목</th>
            <th>카테고리</th>
            <th>원본파일명</th>
            <th>저장된파일명</th>
            <th>작성일</th>
            <th>다운로드</th>
        </tr>
        
        <!-- 목록의 내용 --> 
        <!-- JSTL 사용 -->
        <c:set var="list" value="<%=filelist %>"/>
        
        <c:if test="${empty list }" var="result">
	 	<!-- 조건이 참인 경우 실행되는 부분 -->
		 	<tr>
					<td colspan='8' align="center">등록된 게시물이 없습니다.</td>
			</tr>
	 	</c:if>
	 	
	 	<c:if test="${not result }" >
	 		<!-- 
	 		반복문을 통해 리스트에 담긴 board 객체를 출력
	 		items : 향상된 for문
	 		 -->
			<c:forEach items="${list }" var="file">
		        <tr align="center">     
		            <td align="center">${file.getIdx() }</td>         
		            <td align="center">${file.getName() }</td>         
		            <td align="center">${file.getTitle() }</td>         
		            <td align="center">${file.getCate() }</td>         
		            <td align="center">${file.getOfile() }</td>         
		            <td align="center">${file.getSfile() }</td>         
		            <td align="center">${file.getPostdate() }</td>  
		            <td align="center"><a href="Download.jsp?oName=${file.ofile }&sName=${file.sfile } ">다운로드</a></td>  
		        </tr>
			 </c:forEach>
		</c:if>

 


    </table>
</body>
</html>