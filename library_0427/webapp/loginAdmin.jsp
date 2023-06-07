<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='js/library.js'></script>
</head>
<body>
	<h2>관리자 메뉴</h2>
	<ul>
		<li>
		<form id='bookAdd' action="adminMenu/bookAdd.jsp" method="post" accept-charset="UTF-8">
		    <div id='add_book_input'>
		         <input type="text" name="title" id="title" placeholder='도서명을 입력하세요'required>
		         <br>
		         <input type="text" name="author" id="author" placeholder='작가를 입력하세요' required>
		    </div>
		    <div id='addbtn'>
		         <input type="submit" value="도서등록" id='add'>
		    </div>
		</form>
		</li>
		<li><button id="btn2">도서삭제 - 도서 상세보기 삭제버튼을 이용하세요</button></li>
		<li><button id="btn3">사용자등록</button></li>
		<li><button id="btn4">사용자삭제</button></li>
	</ul>
</body>
</html>