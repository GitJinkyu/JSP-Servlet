<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 검색폼 --> 
    <form method="get" name="searchForm" >
    
    <!-- 페이지번호 -->  
   	<input type='hidden' name='pageNo'>
   	<input type='hidden' name='delNo'>
   	
    <table border="1" width="100%">
    <tr>
        <td align="center">
            <select name="searchField"> 
       	<!-- 검색했을때 검색 설정을 저장해놓기위해 param으로 받아와서 비교 ex(제목으로 검색했을때 검색후에도 검색이 체크상태) -->
                <option value="title" ${param.searchField eq "title" ? "selected" : " " }>도서명</option> 
                <option value="author" ${param.searchField eq "content" ? "selected" : " " }>작가명</option>
            </select>
            <input type="text" name="searchWord" value="${param.searchWord }"/>
            <input type="submit" value="검색하기" />
        </td>
    </tr>   
    </table>
    </form>
	<!-- 검색폼 끝 -->
</body>
</html>