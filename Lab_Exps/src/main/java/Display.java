

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Display
 */
@WebServlet("/Display")
public class Display extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter pw=response.getWriter();
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","Krishna");
			Statement stmt=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
			pw.print("<h3>Data in JAVA_LAB17 table is....</h3>");
			ResultSet rs=stmt.executeQuery("select * from java_lab17");
			pw.print("<html>"
					+ "<head>"
					+ "		<link rel='stylesheet' href='tableStyle.css'>"
					+ "</head>"
					+ "<body>"
					+ "<div class='tab'><table>");
			ResultSetMetaData rsmd=rs.getMetaData();
			if(rs.first()==false) {
				pw.print("<br>No data to be shown....");
			}
			else {
				pw.print("<tr>");
				for(int i=1;i<=rsmd.getColumnCount();i++) {
					pw.print("<th>"+rsmd.getColumnName(i)+"</th>");
				}
				pw.print("</tr>");
				while (rs.first()) {
					do {
						pw.print("<tr>");
						for (int i = 1; i <= rsmd.getColumnCount(); i++) {
							String value = rs.getString(i);
							pw.println("<td>" + value + "</td>");
						}
						pw.print("</tr>");
					}while(rs.next());
					break;
				}
			}
			pw.print("</table></div>"
					+ "</body>"
					+ "</html>");
		}
		catch(ClassNotFoundException e){pw.print(e);}
		catch(SQLException a) {pw.print(a);}
	}
	
}
