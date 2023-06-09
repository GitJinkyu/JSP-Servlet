
<%@page import="util.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
    div#popup {
        position: absolute; top:100px; left:50px; color:yellow;  
        width:270px; height:100px; background-color:gray;
    }
    div#popup>div {
        position: relative; background-color:#ffffff; top:0px;
        border:1px solid gray; padding:10px; color:black;
    }

</style>
<script>
window.onload=function(){
	
	//closeBtn.onclick = function()함수로 요소를 숨겼을때
	//숨긴 버튼의 undefined 에러가 뜨기때문에 typeof로 undefined처리해줘야함
	if(typeof closeBtn != 'undefined'){
		
		closeBtn.onclick = function(){
			if(document.querySelector("#inactiveToday").checked){
				//체크박스가 체크되었으면 popFrm폼을 서브밋 처리 -> PopupCookie.jsp요청
				//PopupCookie.jsp=> 쿠키 생성 페이지
				popFrm.submit();	
			}else{
				popup.style.display='none'; // 클래스 하나	
			}
		}
		
	}
	


}
</script>
<title>쿠키를 이용한 팝업창 제어 ver 1.0 </title>
</head>
<body>

	<h1>쿠키를 이용한 팝업창 제어</h1>
	
	<%
	//쿠키에 PopupClose 값이 등록 되어 있지 않으면 팝업창을 보여줌
	String cValue = CookieManager.returnCookie("PopupClose", request);
	
	if(!cValue.equals("Y")){
	%>
    <div id="popup">
        <h2 align="center">공지사항 팝업입니다.</h2>
        <div align="right">
	        <form name="popFrm" action="PopupCookie.jsp">
	            <input type="checkbox" id="inactiveToday" value="1" /> 
	            하루 동안 열지 않음
	            <input type="button" value="닫기" id="closeBtn" /> 
	        </form>
        </div>
    </div>
    <%
	}
    %>
</body>
</html>