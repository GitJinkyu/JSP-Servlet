<%@page import="com.util.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<link rel='stylesheet' href='css/실습1.css'>
<body>
<aside id='rightside'>
<%
	if (request.getParameter("loginErr") != null && request.getParameter("loginErr").equals("Y")) {
           out.print("로그인 실패 ❌<br>"); 
           out.print("<script>"); 
           out.print("alert('아이디/비밀번호를 확인해주세요') "); 
           out.print("</script>"); 
       }
%>
   
<%
	//쿠키에 저장된 아이디가 있다면 id필드의 value 속성에 아이디 값을 넣어준다.
	String cookieValue = CookieManager.returnCookie("userID", request);
%>  
     <form id='login_form' action="./loginController.do" method="post">
         <div id='login_form_input'>
             <input type="text" name="userID" id="userID" placeholder='ID를 입력하세요'required value="<%=cookieValue%>">
             <br>
             <input type="password" name="userPW" id="userPW" placeholder='PW를 입력하세요' required>
         </div>
         <div id='login_form_btn'>
             <input type="submit" value="로그인" id='login'>
             
             <!-- 
             체크박스는 체크 되었을때만 value값이 서버에 넘어간다 
             선택안하면 null이 출력됨
             -->
             <input type="checkbox" name="save_check" value="Y" <%=!cookieValue.equals("")? "checked" : ""%>>아이디 저장하기
         </div>
     </form>
     <!-- 
     <div id='login_link'>
         <a href='./signup.jsp'>회원가입</a>
         <a href='./forgotid.jsp'>아이디찾기</a>
         <a href='./forgotpw.jsp'>비밀번호찾기</a>
     </div>
      -->
</aside>
            
</body>
</html>