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
<!-- 
	import : 외부파일을 현재 위치에 삽입
	
		url		: 외부파일 파일 경로
		scope	: 영역
		var		: 변수명
					변수명을 사용하면 선언과 삽입을 분리 할 수 있다.
					
	외부파일에 매개변수 넣기
		- url의 쿼리스트링으로 전달하기
		- c:param 태그를 이용하기
 -->
 
 	<c:import url="/6세션/Link.jsp" var="Link">
 		<c:param name="param1" value="헤더영역"></c:param>
 	</c:import>
 	
 	<h4>다른 문서 삽입하기</h4>
 	${Link }
 	
 	<h4>iframe을 이용한 외부자원 삽입하기</h4>
 	<iframe src="../inc/GoldPage.jsp" style="width:100%;height:100px;"></iframe>
 	
 	<c:set var="iTag">
 		i 태그는 <i>기울임</i>을 표현합니다.
 	</c:set>
 	
 	<h4>EL 출력 </h4>
 	${iTag }
 	
 	<h4>out 태그 기본사용</h4>
 	<c:out value="${iTag }"></c:out>
 	
 	<h4>escapeXml 속성</h4>
 	<c:out value="${iTag }" escapeXml="false" />
 	
 	<h4>default 속성</h4>
 	<c:out value="${param.name }" default="이름없음"/>
 	<c:out value="" default="빈 문자열도 값입니다."/>
 	
 	<h4>redirect</h4>
 	<!-- 리다이렉트는 리퀘스트 영역 변수는 공유되지않는다 -->

 	<c:set var="requestVar" value="리퀘스트 영역 변수" scope="request"></c:set>
 	<c:redirect url="../inc/OtherPage.jsp">
 		<c:param name="param1" value="출판사"></c:param>
 		<c:param name="param2" value="골든래빗"></c:param>
 	</c:redirect> 

 	
 	
</body>
</html>