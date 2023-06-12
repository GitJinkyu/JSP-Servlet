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
<style>
table{
border=1
}
</style>
</head>
<body>
	<h2>회원목록 조회 </h2>
	<table >
	<%
	Connection con = ConnectionUtil.getConnection();
	
	String sql="select id, name, regidate from member";
	
	PreparedStatement pstm = con.prepareStatement(sql);
	
	ResultSet rs = pstm.executeQuery();
	
	while(rs.next()){
		String id = rs.getString("id");
		String name = rs.getString("name");
		String regidate = rs.getString("regidate");
		
		out.print(
				String.format("<tr> <td>%s</td> <td>%s</td> <td>%s</td> </tr>",id ,name ,regidate));
	}
	rs.close();
	pstm.close();
	con.close();
	
	%>
	</table>
</body>
</html>