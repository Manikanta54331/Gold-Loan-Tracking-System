package up;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class UpdateUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = null;
        Statement stmt = null;
        PreparedStatement stmt1 = null;
        ResultSet rs = null;
        String id = request.getParameter("id");
       
        
        
        try {
            // Establishing the connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/glts", "root", "root");

            // Creating the SQL statement
            String sql = "SELECT * FROM financer where financer_id=" + id;
            stmt = conn.createStatement();

            // Executing the query
            rs = stmt.executeQuery(sql);

            // Processing the result
            PrintWriter out = response.getWriter();
            
            out.println("<html lang='en'>");
            out.println("<head>");  
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
                        out.println("<link rel='stylesheet' type='text/css' href='/GLTS/main.css'>");

            out.println("<title>Financer Update</title>");
            out.println("</head>");
            
            out.println("<body>");
              out.println("<body>");
            out.println("<header>\n" +
"        <h1>Gold Loan Tracker</h1>\n" +
"        <center><p><em>Track your gold loan status with ease.</em></p></center>\n" +
"        <nav style='text-align: center;'>\n" +
"            <ul>\n" +
"                <li>Logged In As Admin</li>\n" +
"            </ul>\n" +
"        </nav>\n" +
"        <button id='logoutButton' style='position: fixed; top: 10px; right: 10px; padding: 10px; background-color: #f5f5f5; color: #3b3c36; cursor: pointer;' onclick=\"window.location.href='logout.jsp'\"><b>Logout</b></button>\n" +
"    </header><div class='container' style= margin:  '5% 35% 30% 40%;'>");
            out.println("<form method=get name='update' action='/GLTS/UpdateServlet'>");
            out.println("<input type='hidden' name='id' value="+id+">");
            while (rs.next()) {
                out.println("<label for='name'>Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input type='text' id='name' name='name' value='" + rs.getString("financer_name") + "' required><br><label for='password'>Password:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;</label><input type='text' id='password' name='password' value='" + rs.getString("financer_password") + "' required><br><label for='company'>Company:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> <input type='text' id='company' name='company' value='" + rs.getString("financer_company") + "' required><br><label for='email'>Email:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input type='email' id='email' name='email' value='" + rs.getString("financer_email") + "'><br><label for='phno'>Phone Number:&nbsp;</label><input type='text' id='phno' name='phno' value='" + rs.getString("financer_phno") +  "' required><br><label for='bid'>Borrower Id:&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;</label><input type='text' id='bid' name='bid' value='" + rs.getInt("borrower_id") + "' required><label for='add'>Address:&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;</label><input type='text' id='bid' name='add' value='" + rs.getString("financer_address") + "' required><br><input type='submit' name='submit' value='change'> </a>");
            
            out.println("</form></div>");
            out.println("<footer><p>&copy; 2024 Gold Loan Tracker. All rights reserved.</p></footer>");

            out.println("</body>");
            out.println("</html>");
        }
        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Closing resources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
