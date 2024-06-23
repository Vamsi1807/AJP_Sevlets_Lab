

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Insertion
 */
@WebServlet("/Insertion")
public class Insertion extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");
		PrintWriter pw=response.getWriter();
		String name=request.getParameter("name1");
		String password=request.getParameter("pwd");
		String email=request.getParameter("mailid");
		String num=request.getParameter("ph_num");
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection conn=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","Krishna");
			//Statement stmt=conn.createStatement();
			PreparedStatement ps=conn.prepareStatement("Insert into java_lab17 values(?,?,?,?)");
			ps.setString(1, name);
			ps.setString(2,password);
			ps.setString(3, email);
			ps.setString(4, num);
			ps.executeUpdate();
			/*stmt.executeQuery("create table sample(name varchar2(20), id integer);");
			System.out.println("created");*/
			RequestDispatcher rd;
			rd=request.getRequestDispatcher("/operation.html");
			pw.print("<script>window.alert('Values inserted...');</script>");
			rd.include(request, response);
		}
		catch(ClassNotFoundException a) {
			pw.print(a);
		} 
		catch (SQLException e) {
			pw.print(e);
		}
	}

}
