<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 헤더 -->
<%@ include file="../common/header.jsp" %>

<h2>도서 상세정보</h2>
<table border="1" width="90%">

    <colgroup>
        <col width="15%"/> <col width="35%"/>
        <col width="15%"/> <col width="*"/>
    </colgroup>

    <!-- 게시글 정보 -->
    <tr>
        <td>번호</td> <td>${ view.no }</td>
        <td>도서명</td> <td>${ view.title }</td>
    </tr>
    <tr>
        <td>저자</td> <td>${ view.author}</td>
        <td>대출여부</td> <td>${ view.rentyn}</td>
    </tr>

    <!-- 하단 메뉴(버튼) -->
    <tr>
        <td colspan="4" align="center">
            <button type="button" onclick="location.href='../mvcboard/pass.do?mode=edit&idx=${ param.idx }';">
                수정하기
            </button>
            <button type="button" onclick="location.href='../mvcboard/pass.do?mode=delete&idx=${ param.idx }';">
                삭제하기
            </button>
            <button type="button" onclick="location.href='../login/loginController.do';">
                목록 바로가기
            </button>
        </td>
    </tr>
</table>
</body>
</html>