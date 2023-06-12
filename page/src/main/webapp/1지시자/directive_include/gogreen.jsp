<%@page import="util.CookieManager"%>
<%@page import="java.awt.Button"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>실습</title>
    <link rel='stylesheet' href='css/실습1.css'>
</head>
<body>
    <div class="wrap">
        <!-- 헤더 인클루드 -->
        <%@ include file="header.jsp" %>
        <!-- 헤더 인클루드 -->
        
        <main>
            <aside id='leftside'>
                <img src='images/left_img.jpg' >
            </aside>
            <div id="maincontent">
                <ul>
                    <li><img src='images/main_img1.jpg'>나무를 심는 사람들</li>
                    <li><img src='images/main_img2.jpg'>아이들에게 녹색미래를..</li>
                    <li><img src='images/main_img3.jpg'>설악산을 살리는 길</li>
                    <li><img src='images/main_img4.jpg'>사라지는 북극곰들</li>
                </ul>
            </div>
            <aside id='rightside'>
                <!-- 로그인영역 -->
                <!-- 로그인 에러: 알림창 띄우기 -->
                <%
					if (request.getParameter("loginErr") != null && request.getParameter("loginErr").equals("Y")) {
			            out.print("로그인 실패 ❌<br>"); 
			            out.print("<script>"); 
			            out.print("alert('아이디/비밀번호를 확인해주세요') "); 
			            out.print("</script>"); 
			        }
				%>   
				
                <!-- 로그인 성공: 환영합니다 -->
                <%
                //아이디 저장 체크했을때 쿠키로 아이디박스에 쿠키값 출력하기
                String cookieValue = CookieManager.returnCookie("userID", request);
                
                String id = "";
               	//형변환하기전에 null체크를 해야좋음 혹시 모를 예외발생을 막기위해
                if(session.getAttribute("id") != null){
                id = (String)session.getAttribute("id");	
                }
                
				if (id != null && !id.equals("")) {
				    out.print(id+"님 환영합니다.<br>"); 
				%>
				<!-- 로그아웃 -->
				<button onclick="location.href='logout.jsp'">로그아웃</button>
				<%	
						
			    }else{
				%>   
	                <div id='login_wrap'>
	                    <form id='login_form' action="./greenlogin.jsp" method="post">
	                        <div id='login_form_input'>
	                            <input type="text" name="userID" id="userID" placeholder='ID를 입력하세요'required value="<%=cookieValue%>">
	                            <br>
	                            <input type="password" name="userPW" id="userPW" placeholder='PW를 입력하세요' required>
	                        </div>
	                        <div id='login_form_btn'>
	                            <input type="submit" value="로그인" id='login'>
	                        </div>
	                        	<!-- 
	                        		아이디 저장하기 체크해놓기
	                        	< %=!cookieValue.equals("")? "checked" : ""%>
	                        	 -->
	                            <input type="checkbox" name="save_check" value="Y" <%=!cookieValue.equals("")? "checked" : ""%>>아이디 저장하기
	                    </form>
	                    <!-- 
	                    <div id='login_link'>
	                        <a href='#'>회원가입</a>
	                        <a href='#'>아이디찾기</a>
	                        <a href='#'>비밀번호찾기</a>
	                    </div>
	                     -->
	                    <!-- 로그인영역끝 --> 
	                </div>
               	<%
               	}
				%>
                    <img src='images/right_img.jpg' width='250px' height='300px'>
                    <img src='images/me_chat.jpg'width='250px'>
            </aside>
        </main>  
        
        <!-- 풋터 인클루드-->     
        <%@ include file="footer.jsp" %>
        <!-- 풋터 인클루드-->
    </div>
</body>
</html>