<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.util.*, java.sql.*" %>
<%
    String roll = (String) session.getAttribute("rollnum");
    out.print("Your roll number is : "+roll);

    if (roll != null && !roll.isEmpty()) { // Validate roll
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "System", "Krishna");
            

            String attemptQuery = "SELECT attempt FROM studata WHERE roll_no = ?";
            pstmt = conn.prepareStatement(attemptQuery);
            pstmt.setString(1, roll);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String attempt = rs.getString("attempt");

                if ("no".equals(attempt)) {
                    String q1 = request.getParameter("1");
                    String q2 = request.getParameter("2");
                    String q3 = request.getParameter("3");
                    String[] arr = {q1, q2, q3};
                    int count = 0;

                    String answerQuery = "SELECT * FROM answers";
                    Statement stmt = conn.createStatement();
                    ResultSet rs2 = stmt.executeQuery(answerQuery);

                    int i = 0;
                    while (rs2.next() && i < arr.length) {
                        if (arr[i].equals(rs2.getString(2))) {
                            count++;
                        }
                        i++;
                    }

                    rs2.close();
                    stmt.close();

                    out.print("<br>Your marks are " + count);
                    String updateQuery = "UPDATE studata SET marks = ?, attempt = 'yes' WHERE roll_no = ?";
                    pstmt = conn.prepareStatement(updateQuery);
                    pstmt.setInt(1, count);
                    pstmt.setString(2, roll);
                    pstmt.executeUpdate();
                    out.print("<form action='login.jsp' method='get'>");
                    out.print("<input type='submit' value='Home'>");
                    out.print("</form>");
                } 
            } else {
                out.print("Invalid roll number.");
            }

        } catch (Exception e) {
            out.print(e); // For debugging purposes (remove in production)
        }
    } else {
        out.print("Please enter a valid registration number.");
    }
%>
</body>
</html>
