<%@page import="common.JSFunction"%>
<%@page import="dto.Board"%>
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
.container{
  width: 90%;
  height: 1500px;
       
}
</style>


</head>

<body>
<%
	BoardDao BDao= new BoardDao();

	//게시글 1건을 조회 후 board객체에 담아서 반환
	Board board = BDao.selectOne(request.getParameter("num"));
	
	//게시글 조회하면 조회수 1상승 
	int visit = BDao.visitCounting(request.getParameter("num"));
	
	
	if(board == null){
		JSFunction.alertBack("게시글이 존재하지 않습니다.", out);
	
		return;
	}  
	
%>
<script>
	function deletePost(){
		var res = confirm("삭제 하시겠습니까?");
		if(res){
			location.href = "DeleteProcess.jsp?num=<%= board.getNum() %>";
		}
	}
</script>

<jsp:include page="Link.jsp"></jsp:include>

<table  width="90%" >
	<tr>
		<td><h1><%=session.getAttribute("userId")%>님 환영합니다. 🙌</h1></td>
	</tr>
	
	<tr>
		<td><h2>상세보기</h2></td>
	</tr>

</table>

<form >
    <table border="1" width="90%" >
        <tr>
            <td>번호</td>
            <td><%= board.getNum() %></td>
            <td>작성자</td>
            <td><%= board.getId() %></td>
        </tr>
        
        <tr>
            <td>작성일</td>
            <td><%= board.getPostdate() %></td>
            <td>조회수</td>
            <td><%= board.getVisitcount() %></td>
        </tr>
        
        <tr>
            <td>제목</td>
            <td colspan="3"><%= board.getTitle() %></td>
        </tr>
        
        <tr height=200px>
            <td>내용</td>
            <td colspan="3" ><%= board.getContent() %></td>
        </tr>
     
        <tr>
            <td colspan="4" align="center">
            <%
            //로그인 상태라면 글수정, 글삭제 버튼 보여주기
            if(session.getAttribute("userId") != null &&
            board.getId().equals(session.getAttribute("userId"))){
            %>
            <button type="button" onclick="location.href='Edit.jsp?num=<%=board.getNum()%>'">글 수정</button>
            <button type="button" onclick="deletePost()">글 삭제</button>
            <%
            }
            %>
     		<button type="button" onclick="location.href='List.jsp'">목록 보기</button>
            </td>
        </tr>
	</table>
</form>



</body>

</html>