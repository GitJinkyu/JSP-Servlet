<%@page import="dto.Criteria"%>
<%@page import="dto.PageDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%
	//컨트롤러에서 생성한 pageDto 넘겨받기
	PageDto pageDto = (PageDto) request.getAttribute("pageDto"); 


	//맨 앞 페이지로 가기
	out.print("<input type='button' value='<<=' onclick='go("+1+")'>");
	
	//이전 페이지 가기
	if(pageDto.isPrev()){
		out.print("<input type='button' value='<' onclick='go("+(pageDto.getStartNo()-1)+")'>");
	}
	
	for(int i =pageDto.getStartNo(); i <= pageDto.getEndNo(); i++){
		out.print("<input type='button' value='"+i+"' onclick='go("+i+")'>");
	}
	
	//다음 페이지 가기
	if(pageDto.isNext()){
		out.print("<input type='button' value='>' onclick='go("+(pageDto.getEndNo()+1)+")'>");
	}
	
	//마지막 페이지로 가기
	out.print("<input type='button' value='=>>' onclick='go("+(pageDto.getRealEnd())+")'>");
%>



</body>
</html>