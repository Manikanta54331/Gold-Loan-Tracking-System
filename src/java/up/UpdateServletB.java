package up;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class UpdateServletB extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        
        int id    = Integer.parseInt(request.getParameter("id"));
        String name  = request.getParameter("name");
        String email = request.getParameter("email");
 String pass = request.getParameter("password");
 String phno= request.getParameter("phno");
 int fid= Integer.parseInt(request.getParameter("fid"));
String add= request.getParameter("add");
        
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Establishing the connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/glts", "root", "root");
             
            // Creating the SQL statement
            String sql = "UPDATE borrower SET borrower_name=?, borrower_password=?, borrower_address=? , borrower_email=?, borrower_phno=?, financer_id=?  where borrower_id=?";
           
            stmt = conn.prepareStatement(sql);
         
            stmt.setString(1, name);
            stmt.setString(2, pass);
		
		stmt.setString(3, add);
		stmt.setString(4, email);
		stmt.setString(5, phno);
		stmt.setInt(6, fid);
                stmt.setInt(7, id);
                
            // Executing the statement
            stmt.executeUpdate();
                
            // Redirect to a success page
            response.sendRedirect("borrowerDisplay.jsp");
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
