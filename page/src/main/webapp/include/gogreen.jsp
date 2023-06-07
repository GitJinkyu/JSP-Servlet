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
                	String name = request.getParameter("name");
					if (name != null && !name.equals("")) {
						//로그인 되었다고 판단
					    out.print(name+"님 환영합니다.<br>"); 
			        }else{
				%>   
	                <div id='login_wrap'>
	                    <form id='login_form' action="./greenlogin.jsp" method="post">
	                        <div id='login_form_input'>
	                            <input type="text" name="userID" id="userID" placeholder='ID를 입력하세요'required>
	                            <br>
	                            <input type="password" name="userPW" id="userPW" placeholder='PW를 입력하세요' required>
	                        </div>
	                        <div id='login_form_btn'>
	                            <input type="submit" value="로그인" id='login'>
	                        </div>
	                    </form>
	                    <div id='login_link'>
	                        <a href='#'>회원가입</a>
	                        <a href='#'>아이디찾기</a>
	                        <a href='#'>비밀번호찾기</a>
	                    </div>
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