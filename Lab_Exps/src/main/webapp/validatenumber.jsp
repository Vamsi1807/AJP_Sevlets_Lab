<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<%@ page import="java.util.*,java.sql.*" %>
    <%
        String roll = request.getParameter("roll");
    	out.print("Your roll number is : "+roll+"<br>");// Use getParameter

        if (roll != null && !roll.isEmpty()) { // Validate roll
        	
        	HttpSession ses=request.getSession();
        	ses.setAttribute("rollnum",roll);
        	
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "System", "Krishna");

                PreparedStatement pstmt = conn.prepareStatement("select * from studata where roll_no = ?");
                pstmt.setString(1, roll);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    String attempt = rs.getString("attempt");
                    String marks = rs.getString("marks");
                    if ("yes".equals(attempt)) {
           
                        out.print("Exam has completed with marks "+marks+"\n");
                        out.print("<form action='login.jsp' method='get'>");
                        out.print("<input type='submit' value='Home'>");
                        out.print("</form>");
                    } else {
                        response.sendRedirect("questions.html");
                    }
                } else {
                    out.print("You are not eligible for the exam!!");
                }
            } catch (Exception e) {
                // Handle exception (log or display user-friendly message)
                e.printStackTrace(); // For debugging purposes (remove in production)
            }
        } else {
            out.print("Please enter a valid registration number.");
        }
    %>
</body>
</html>
