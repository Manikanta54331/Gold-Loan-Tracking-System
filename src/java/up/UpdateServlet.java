package up;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class UpdateServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        
        int id    = Integer.parseInt(request.getParameter("id"));
        String name  = request.getParameter("name");
        String email = request.getParameter("email");
 String pass = request.getParameter("password");
 String com= request.getParameter("company");
 String phno= request.getParameter("phno");
 int bid= Integer.parseInt(request.getParameter("bid"));
String add= request.getParameter("add");
        
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Establishing the connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/glts", "root", "root");
             
            // Creating the SQL statement
            String sql = "UPDATE financer SET financer_name=?, financer_password=?, financer_company=?, financer_address=? , financer_email=?, financer_phno=?, borrower_id=?  where financer_id=?";
           
            stmt = conn.prepareStatement(sql);
         
            stmt.setString(1, name);
            stmt.setString(2, pass);
		stmt.setString(3, com);
		stmt.setString(4, add);
		stmt.setString(5, email);
		stmt.setString(6, phno);
		stmt.setInt(7, bid);
                stmt.setInt(8, id);
                
            // Executing the statement
            stmt.executeUpdate();
                
            // Redirect to a success page
            response.sendRedirect("financerDisplay.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Closing resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
