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
<table  width="90%" >
	<tr>
		<td><h1><%=session.getAttribute("userId")%>님 환영합니다. 🙌</h1></td>
	</tr>
	<tr>
		<td><h2>회원제 게시판 - 글쓰기(Write)</h2></td>
	</tr>
</table>

<form name="writeFrm" method="post" action="WriteProcess.jsp"
      onsubmit="return validateForm(this);">
    <table border="1" width="90%">
        <tr>
            <td>제목</td>
            <td>
                <input type="text" name="title" style="width: 90%;" />
            </td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="content" style="width: 90%; height: 100px;"></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button" onclick="location.href='List.jsp';">
                    목록 보기</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>