<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장객체 - request</title>
</head>
<body>
	<h2>1.클라이언트와 서버의 환경정보 읽기</h2>
	<!-- 메소드를 지정하지 않은 경우는 모두 get방식으로 호출됨 기본값 -->
	
	<!-- 404: 페이지를 찾을 수 없음  
		서버에 파일이 없는 경우, 또는 경로가 일치하지 않는 경우
		URL경로를 확인해봐야함
	-->
	<a href="RequestWebInfo.jsp?eng=hello&han=안녕">GET 방식 요청</a>
	
	
	<form action="RequestWebInfo.jsp" method="post">
		영어 : <input type="text" name="eng" value="Bye"><br> 
		한글 : <input type="text" name="han" value="잘가"><br>
		<input type="submit" value="post전송">
	</form>
	
	<h2>2.클라이언트의 요청 매개변수 읽기</h2>
	
	<form action="RequestParameter.jsp" method="post">
	<!-- 다양한 input태그를 사용하여 서버에 값을 전달 해봅시다. -->
	
	<table>
        <!-- 아이디 -->
        <tr>
            <th>ID</th>
            <td>
                <input type="text" name="userID" id="userID"  value="a" required size='10'>
                <input type="text" name="userID" id="userID"  value="b" required size='10'>                
            </td>
        </tr>

        <!-- 성별 -->
        <tr>
            <th><label for='frontphone'><b>성별</b></label></th>
            <td>
                <input type="radio" name="gender" id="gender" value='M'>남자
                <input type="radio" name="gender" id="gender" value='F'>여자
            </td>
        </tr>

        <!-- 취미 -->
        <tr>
            <th><label for='hobby'><b>취미</b></label></th>
            <td>
                <input type="checkbox" name="hobby" value='study'>공부
                <input type="checkbox" name="hobby" value='climbling'>등산
                <input type="checkbox" name="hobby" value='game'>게임
                <input type="checkbox" name="hobby" value='fishing'>낚시
                <input type="checkbox" name="hobby" value='shopping'>쇼핑
            </td>
        </tr>

        <!-- 자기소개 -->
        <tr>
            <th><label for='introduce '><b>자기소개</b></label></th>
            <td>
                <textarea name="intro" id="introduceself"  placeholder='자기소개를 100자 이내로 입력하세요'>
                </textarea>
            </td>
        </tr>
    </table>
	
	<input type="submit" value="post전송">
	</form>
		 
		
</body>
</html>