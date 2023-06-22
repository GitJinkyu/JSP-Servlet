<%@page import="dto.PageDto"%>
<%@page import="dto.Criteria"%>
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
	//총게시물수,검색 조건(페이지번호,페이지당 게시물수,검색어,검색조건)
	int pageNo=request.getParameter("pageNo")== null
						? 1 :Integer.parseInt(request.getParameter("pageNo"));
	
	int totalCnt = 300;
	Criteria criteria = new Criteria(pageNo);
	
	PageDto pageDto = new PageDto(totalCnt,criteria);
	
	if(pageDto.isPrev()){
		//시작 페이지번호가 1보다 클 경우
		out.print("<a href='PagingNavi.jsp?pageNo="+(pageDto.getStartNo()-1)+"'>");
		out.print("<");
		out.print("</a>");
	}
	
	for(int i = pageDto.getStartNo(); i <= pageDto.getEndNo(); i++){
		out.print("<a href='PagingNavi.jsp?pageNo="+i+"'>");
		out.print(i);
		out.print("</a>");
	}
	
	if(pageDto.isNext()){
		//마지막 번호가 게시물의 끝페이지 번호와 일치하지않을때
		out.print("<a href='PagingNavi.jsp?pageNo="+(pageDto.getEndNo()+1)+"'>");
		out.print(">");
		
	}

%>
</body>
</html>