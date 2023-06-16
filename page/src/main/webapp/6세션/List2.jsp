<%@page import="dto.Criteria"%>
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
<style >
* {
  box-sizing: border-box;
  margin:0 auto;
  padding:0;
}
.contdainer{

  width: 90%;
  height: 800px;
       
}
</style>
</head>
<body>
<div class="container">
<%
    BoardDao Bdao = new BoardDao();
    
    //검색어,검색필드
    String searchField = request.getParameter("searchField");
    String searchWord = request.getParameter("searchWord");
    String pageNo = request.getParameter("pageNo");
    
    Criteria criteria = new Criteria(searchField,searchWord,pageNo);
    
    
    List<Board> boardList = Bdao.getListPage(criteria);
    
    
    int totalCnt = Bdao.getTotalCnt(criteria);
    //검색어가 Null이 아니면 검색 기능을 추가

    
    //검색창에 검색 내용 남기기
    String output = searchWord != null ? searchWord : "";
    
%>

<jsp:include page="Link.jsp"></jsp:include>

<table  width="90%" >
	<tr>
		<td><h1><%=session.getAttribute("userId")%>님 환영합니다. 🙌</h1></td>
	</tr>
	
	<tr>
		<td><h2>목록보기(List)</h2></td>
	</tr>
	
	<tr>
		<td><p >총건수 : <%=totalCnt %></p></td>
	</tr>
</table>
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
	        <td><a href="View.jsp?num=<%= board.getNum() %>"><%= board.getTitle() %></a></td>
	        <td><%= board.getContent() %></td>
	        <td><%= board.getId() %></td>
	        <td><%= board.getPostdate() %></td>
	        <td><%= board.getVisitcount() %></td>
	    </tr>
	<% } %> <!-- for문 끝 -->
	
<% } %> <!-- if문 끝 -->
</table>

<% //로그인 했을때만 글쓰기 버튼 보여주기
if(session.getAttribute("userId") != null){ 
%>
<table width="90%" border='1'>
	<tr width="90%">
		<td align="right">
		 <input type="submit" value="글쓰기" onclick="location.href='Write.jsp';">
		</td>
	</tr>
</table>
<%}%>

</div>
</body>
</html>