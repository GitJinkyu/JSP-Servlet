<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
</head>
<body>
<form name="writeForm" method="post" action="WriteProcess.jsp" enctype=“multipart/formdata>
<h2>회원제 게시판 - 글쓰기(Write)</h2>
    <table border="1" width="90%">
     	<tr>
            <td>작성자</td>
            <td>
                <input type="text" name="name" style="width: 10%;" />
            </td>
        </tr>
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
            <td>첨부파일</td>
            <td>
                <input type="file" name="attachedFile" style="width: 90%;" />
            </td>
        </tr>
        <tr>
            <td>비밀번호</td>
            <td>
                <input type="password" name="pass" style="width: 10%;" />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button">목록 보기</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>