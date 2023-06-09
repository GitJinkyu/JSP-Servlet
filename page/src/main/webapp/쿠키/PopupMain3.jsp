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
    .off{
    	display: none;
    }

</style>
<script>
window.onload=function(){
	
	//closeBtn.onclick = function()함수로 요소를 숨겼을때
	//숨긴 버튼의 undefined 에러가 뜨기때문에 typeof로 undefined처리해줘야함
	if(typeof closeBtn != 'undefined'){
		closeBtn.onclick = function(){
		
			popup.style.display='none'; // 클래스 하나
			
			var chkVal = document.querySelector("input[id=inactiveToday]:checked").value;
			
			//체크박스가 체크된 상태라면
			if(chkVal != null && chkVal == 1){
				//자바스크립트를 이용한 쿠키 생성
				const date =  new Date();
				
				//12시간
				date.setTime(date.getTime()+ 12 * 60 * 60 * 1000);
				
				document.cookie="PopupClose=off;expires='+date+';"
			}
		}
	}
		
	


}

</script>
<title>쿠키를 이용한 팝업창 제어 ver 2.0</title>
</head>
<body>

	<h1>쿠키를 이용한 팝업창 제어ver 2.0</h1>

<%
String cValue = CookieManager.returnCookie("PopupClose", request);


	if(!cValue.equals("Y")){	
%>	
    <div id="popup" >
        <h2 align="center">공지사항 팝업입니다.</h2>
        <div align="right">
	        <form name="popFrm" >
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