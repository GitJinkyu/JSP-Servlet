<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

*{
	padding:0;
	margin:0;
}

body{
	margin: 0 auto;
	width: 900px;
	border: 1px solid black;
}
header{
	border: 1px solid black;
	width: 100%;
	height: 50px;
	lint-height: 50px;
	display: flex;
}

header div{
	padding : 20px;
}
</style>

<script>

	let message = '${message}'
	if(message != null && "" != message){
		alert(message);
	}


	function deleteBook(){
		//체크박스가 선택된 요소의 값을 ,로 연결
		delNoList = document.querySelectorAll("[name=delNo]:checked");
		
		//체크된 박스의 값 뽑아내기
		let delNo = "";
		delNoList.forEach((e)=>{
			delNo += e.value + ',';
		});
		
		//마지막요소일때 , 제거
		delNo = delNo.substr(0,delNo.length-1);
		
		console.log("삭제할번호 : " + delNo);
		//삭제요청
		searchForm.action = "../book/delete.book";
		
		//서치폼 delNo 인풋 박스의 벨류 값을 위에서 구한 delNo를 대입
		searchForm.delNo.value=delNo;
		searchForm.submit();
		
	}
	
	function allCheck() {
		  // 체크박스의 상태를 확인하고 원하는 동작을 수행합니다.
		  if (document.getElementsByName("allCheck")[0].checked) {
		    // 체크박스가 체크된 상태일 때 실행할 코드
		    // 함수 호출 또는 원하는 동작을 수행하세요.
		    delNoBox = document.querySelectorAll("[name=delNo]");
		    delNoBox.forEach(function(checkbox) {
		        checkbox.checked = checkbox.checked = true});
		
		    console.log("체크박스가 체크되었습니다.");
		  } else {
		    // 체크박스가 체크 해제된 상태일 때 실행할 코드
		    // 함수 호출 또는 원하는 동작을 수행하세요.
		    delNoBox = document.querySelectorAll("[name=delNo]");
		    delNoBox.forEach(function(checkbox) {
		        checkbox.checked = checkbox.checked = false});
		    
		    console.log("체크박스가 체크 해제되었습니다.");
		  }
		}
	

</script>

</head>
<body>
<!-- 헤더 -->
<%@ include file="../common/header.jsp" %>
<h2>도서 목록</h2>
<p >총건수 :${requestScope.map.totalCnt }</p>

<!-- 검색폼 -->
<%@ include file="../common/searchForm.jsp" %>
<!-- 검색폼 끝 -->    
	
    <!-- 게시물 목록 테이블(표) --> 
    <table border="1" width="100%">
        <!-- 각 칼럼의 이름 -->
        
        <c:if test="${sessionScope.adminyn eq 'Y' }">
	        <tr>
	        	<td colspan="5" class="right">
	        	<!-- 어드민 계정인 경우 등록,삭제 버튼을 출력 -->
	        	<button onclick="window.location.href = '../book/write.book'">도서 등록</button>
	        	<button onclick="deleteBook()">도서 삭제</button>
	        	</td>
	        </tr> 
        </c:if>
        
        <tr>
        	<th><input type="checkbox" name="allCheck" onclick="allCheck()"></th>
            <th>번호</th>
            <th>도서명</th>
            <th>저자</th>
            <th>대출여부</th>
        </tr>
        
        <!-- 목록의 내용 --> 
        <!-- JSTL 사용 -->
        <c:set var="list" value="${requestScope.map.list }"/>
        
        <c:if test="${empty map.list }" var="result">
	 	<!-- 조건이 참인 경우 실행되는 부분 -->
		 	<tr>
				<td colspan='5' align="center">등록된 게시물이 없습니다.</td>
			</tr>
	 	</c:if>
	 	
	 	<c:if test="${not result }" >
 		<!-- 
 		반복문을 통해 리스트에 담긴 board 객체를 출력
 		items : 향상된 for문
 		 -->
			<c:forEach items="${map.list }" var="book">
		        <tr align="center">
		        	<td class="center">
		        	<input type="checkbox" name="delNo" value=${book.no }>
		        	</td>
		            <td align="center">${book.getNo() }</td>         
		            <td align="center"><a href="../book/view.book?no=${book.no }">${book.getTitle() }</a></td>         
		            <td align="center">${book.getAuthor() }</td>         
		            <td align="center">${book.getRentyn() }</td>         
					
				
		        </tr>
			 </c:forEach>
		</c:if>
	 </table>

	<!-- 페이지블럭 생성 시작 -->
	<table border="1" width="100%">
		<tr>
			<td align="center">
			<%-- <c:import url="../common/PageNavi.jsp"></c:import> --%>
			<%@include file = "../common/PageNavi.jsp" %>
			</td>
		</tr>
	</table>
	<!-- 페이지블럭 생성 끝 -->
</body>
</html>