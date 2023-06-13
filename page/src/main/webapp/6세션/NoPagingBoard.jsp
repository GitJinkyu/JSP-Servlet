<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
<%@page import="dao.BoardDao"%>
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
    BoardDao Bdao = new BoardDao();
    List<Board> boardList;
    
    
    String searchField = request.getParameter("searchField");
    String searchWord = request.getParameter("searchWord");
    out.print(searchField);
    out.print(searchWord);
    
    int totalCnt = Bdao.getTotalCnt();
    //검색어가 Null이 아니면 검색 기능을 추가
	if (searchField != null && searchWord != null) {
    boardList = Bdao.searchBoards(searchField, searchWord);
	} else {
    boardList = Bdao.getList();
	}
    
    //검색창에 내용 남기기
    String output = searchWord != null ? searchWord : "";
    
%>

<jsp:include page="Link.jsp"></jsp:include>

<h1><%=session.getAttribute("userId")%>님 환영합니다.</h1>
<h2>목록보기(List)</h2>

총건수 : <%=totalCnt %>

<!-- 검색폼 -->
<table border="1" width="90%" >
  <tr align="center">
    <td >
      <form>
        <label for="selectbox"></label>
        <select name="searchField" id="selectbox">
          <option value="title" selected >제목</option>
          <option value="content">내용</option>
          <option value="id">작성자</option>
        </select>

        <label for="serachWord"></label>
        <input type="search" name="searchWord" id="searchWord" value="<%=output%>">
        <input type="submit" value="검색">
      </form>
    </td>
  </tr>
</table>
<!-- 검색폼 끝 -->

<table border='1' width="90%">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>내용</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
<%
if(boardList.isEmpty()){
	//게시글이 하나도 없을때 알람
%>
	<tr width="90%">
		<td colspan="6" align="center">등록된 게시물이 없습니다.</td>
	</tr>
<%
}else{
%>

<%
	for (Board board : boardList) { 
%>
	    <tr>
	        <td><%= board.getNum() %> </td>
	        <td><%= board.getTitle() %></td>
	        <td><%= board.getContent() %></td>
	        <td><%= board.getId() %></td>
	        <td><%= board.getPostdate() %></td>
	        <td><%= board.getVisitcount() %></td>
	    </tr>
	<% } %> <!-- for문 끝 -->
	
<% } %> <!-- if문 끝 -->
</table>

<table width="90%">
	<tr width="90%">
		<td align="right">
		 <input type="submit" value="글쓰기">
		</td>
	</tr>
</table>

</body>
</html>