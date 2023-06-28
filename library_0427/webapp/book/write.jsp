<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' href='../css/library.css'>
<script type="text/javascript">
    function validateForm(form) {  // 필수 항목 입력 확인
        
        if (form.title.value == "") {
            alert("제목을 입력하세요.");
            form.title.focus();
            return false;
        }
        if (form.content.value == "") {
            alert("저자를 입력하세요.");
            form.content.focus();
            return false;
        }
        
    }
</script>
</head>
<body>
<!-- 헤더 -->
<%@ include file="../common/header.jsp" %>

<h2>책 등록하기</h2>
<form name="writeFrm" method="post" enctype="multipart/form-data"
      action="../book/write.book" onsubmit="return validateForm(this);">
<table border="1" width="90%">
    <tr>
        <td>제목</td>
        <td>
            <input type="text" name="title" style="width:90%;" />
        </td>
    </tr>
    <tr>
        <td>저자</td>
        <td>
            <textarea name="author" style="width:90%;height:100px;"></textarea>
        </td>
    </tr>
    <tr>
        <td>책 이미지</td>
        <td>
            <input type="file" name="bookImg" />
        </td>
    </tr>
    
	
	    <!-- 하단 메뉴(버튼) -->
	    <tr>
	        <td colspan="2" align="center">
	            <button type="submit">등록하기</button>
	            <button type="reset">다시 작성</button>
	            <button type="button" onclick="location.href='../book/list.book';">목록</button>
	        </td>
	    </tr>
	</table>
</form>
</body>
</html>