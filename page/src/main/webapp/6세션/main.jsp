<%@page import="dto.Member"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="common.ConnectionUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<h2>게시판</h2>
	
	<h1><%=session.getAttribute("userId")%>님 환영합니다.</h1>
	<button onclick="location.href='logout.jsp'">로그아웃</button>
	
	<table border='1'>
	<%
	String sql="select num, title, content, id, postdate, visitcount from board order by num desc";
	
	Connection con = ConnectionUtil.getConnection();
	
	PreparedStatement pstm = con.prepareStatement(sql);
	
	ResultSet rs = pstm.executeQuery();
	
	
	
	out.print(
			String.format("<thead>\n" +
					" <tr>\n" +
					" <th>글번호</th>\n" +
					" <th>제목</th>\n" +
					" <th>내용</th>\n" +
					" <th>작성자</th>\n" +
					" <th>작성시간</th>\n" +
					" <th>조회수</th>\n" +
					" </tr>\n" +
					" </thead>\n"));
	
	while(rs.next()){
		String num = rs.getString("num");
		String title = rs.getString("title");
		String content = rs.getString("content");
		String id = rs.getString("id");
		String postdate = rs.getString("postdate");
		String visitcount = rs.getString("visitcount");
		
		out.print(
		String.format(
				" <tbody>\n" +
				" <tr>\n" +
				" <td>%s</td>\n" +
				" <td>%s</td>\n" +
				" <td>%s</td>\n" +
				" <td>%s</td>\n" +
				" <td>%s</td>\n" +
				" <td>%s</td>\n" +
				" </tr>\n" +
				" </tbody>",num, title,content, id, postdate, visitcount));
	}
	rs.close();
	pstm.close();
	con.close();
	
	%>
	</table>
</body>
</html>