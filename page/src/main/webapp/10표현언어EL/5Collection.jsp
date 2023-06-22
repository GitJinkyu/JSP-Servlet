<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="dto.Member"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	//리스트 생성(타입=Object -> 어떤 타입이든지 저장 가능)	
	List<Object> aList =  new ArrayList<Object>();
	aList.add("정혜진");
	aList.add(new Member("test","","하니","2000"));
	
	
	//페이지 영역에 리스트 객체 저장
	pageContext.setAttribute("aList", aList);
	
%>
	<h2>List 컬렉션</h2>
	<ul>
		<li>0번째 요소 ${aList[0] }</li> <!-- 영역을 직접 지정 하진 않았지만 페이지영역에 저장된 aList값 출력 -->
		<li>
		<p>1번째 요소 ${aList[1].id } </p>
		<p> 1번째 요소 ${aList[1].name }</p>
		</li> 
		
		<li>2번째 요소 ${aList[2] }</li> <!-- 예외가 발생하지 않고 출력되지 않음 -->
	</ul>
	
	<h2>Map 컬렉션</h2>
	
	<%
		Map<String, String> map = new HashMap<String,String>();
		/* map.put 키  , 벨류 설정 */
		map.put("한글","훈민정음");
		map.put("Eng","English");
		
		pageContext.setAttribute("map", map);
	
	%>
	
	<ul></ul>
		<!-- map은 키 값으로 접근 -->
		<!--한글,특수문자는 . 으로 접근 불가. 대괄호안에 입력 -->
		<li>한글 : 
		<p>${map['한글'] }</p> 
		<p>${map["한글"] }</p>
		<!-- el코드 주석처리 방법 : 앞에 \를 붙여준다 -->
		<p>\${map.한글 }</p>
		<p> <%=map.get("한글") %> </p>
		</li>
		
		
		<li>영어 : <p>${map.Eng }</p></li>
	</ul>
</body>
</html>