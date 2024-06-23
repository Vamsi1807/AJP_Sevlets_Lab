<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<style>
		table,
		th,
		td{
			border:2px solid black;
			border-collapse: collapse;
			text-align: center;
			padding:10px 15px 10px 15px
		}
		.tab{
			display:flex;
			justify-content: center;
			align-items: center;
			border:0px;
		}
	</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ page import="java.sql.*" %>	
	<%
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","Krishna");
		Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
		ResultSet rs=stmt.executeQuery("select * from java_lab17");
		ResultSetMetaData rsmd=rs.getMetaData();
	%>
	<h1>Data in JAVA_LAB17 table is....</h1>
	<div class='tab'>
	<table>
		<%
			out.print("<tr>");
			for(int i=1;i<=rsmd.getColumnCount();i++){
				out.print("<th>"+rsmd.getColumnName(i)+"</th>");
			}
			out.print("</tr>");
			while (rs.first()) {
				do {
					out.print("<tr>");
					for (int i = 1; i <= rsmd.getColumnCount(); i++) {
						String value = rs.getString(i);
						out.println("<td>" + value + "</td>");
					}
					out.print("</tr>");
				}while(rs.next());
				break;
			}
		%>
		
	</table>
	</div>
</body>
</html>