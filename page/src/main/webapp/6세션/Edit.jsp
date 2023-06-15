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
  height: 800px;
       
}
</style>
</head>
<body>
<jsp:include page="Link.jsp"></jsp:include>

<!-- 작성도중 세션만료되었을 경우 처리 -->
<%@include file="isLogin.jsp" %>


<%
	BoardDao BDao= new BoardDao();

	//게시글 1건을 조회 후 board객체에 담아서 반환
	Board board = BDao.selectOne(request.getParameter("num"));
	
	
	
	if(board == null){
		JSFunction.alertBack("게시글이 존재하지 않습니다.", out);
	
		return;
	}  
	
%>


<table  width="90%" >
	<tr>
		<td><h1><%=session.getAttribute("userId")%>님 환영합니다. 🙌</h1></td>
	</tr>
	<tr>
		<td><h2>글 수정하기</h2></td>
	</tr>
</table>

<form name="editFrm" method="post" action="EditProcess.jsp?num=<%=board.getNum()%>"
      onsubmit="return validateForm(this);">
    <table border="1" width="90%">
        <tr>
            <td>제목</td>
            <td>
                <input type="text" name="title" style="width: 90%;" value="<%= board.getTitle() %>" />
            </td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="content" rows=10 style="width: 90%;  "><%= board.getContent() %></textarea>
               
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">수정하기</button>
                <button type="reset">다시 입력</button>
                <button type="button" onclick="location.href='List.jsp';">목록 보기</button>
            </td>
        </tr>
    </table>
</form>


</body>
</html>