
<%@page import="util.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
		
		
			/* 메서드 쓰면 아래 방법은 안써도됨
			Cookie[] cookies = request.getCookies();
			String userID = "";
			//null처리 안하면 쿠키가 존재하지않을때 오류뜸
			if(cookies != null){
				for(Cookie cookie : cookies){
					if("userID".equals(cookie.getName())){
						userID= cookie.getValue();
						break;
					}
				}
			}
			*/
		
            String name = request.getParameter("name");
			if (name != null && !name.equals("")) {
				//로그인 되었다고 판단
			    out.print(name+"님 환영합니다.<br>"); 
	        }else{
		%>  
     <form id='login_form' action="./loginaction.jsp" method="post">
         <div id='login_form_input'>
             <input type="text" name="userID" id="userID" placeholder='ID를 입력하세요'required value="<%=cookieValue%>"><br>
             <input type="password" name="userPW" id="userPW" placeholder='PW를 입력하세요' required><br>
             <input type="checkbox" name="save_check" value="Y">아이디 저장하기
         </div>
         
         <div id='login_form_btn'>
             <input type="submit" value="로그인" id='login'>
         </div>
     </form>
     <div id='login_link'>
         <a href='./signup.jsp'>회원가입</a>
         <a href='./forgotid.jsp'>아이디찾기</a>
         <a href='./forgotpw.jsp'>비밀번호찾기</a>
     </div>
     	<%
	        }
     	%>
</body>
</html>