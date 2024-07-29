/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package up;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class DeleteUser extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
PrintWriter out=response.getWriter();
        Connection conn = null;
        PreparedStatement stmt = null,stmt1=null,stmt2=null,stmt3=null,stmt4=null ;

        try {
            // Establishing the connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/glts", "root", "root");

            // Creating the SQL statement
            String sql3 = "DELETE FROM loan WHERE financer_id = ?";
            String sql2 = "UPDATE borrower SET financer_id= null where financer_id = ?";
            String sql1 = "UPDATE financer SET borrower_id= null where financer_id = ?";
            String sql4 = "UPDATE loan SET borrower_id= null where financer_id = ?";
            String sql = "DELETE FROM financer WHERE financer_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt4 = conn.prepareStatement(sql4);
            stmt2 = conn.prepareStatement(sql2);
            stmt1 = conn.prepareStatement(sql1);
            stmt3 = conn.prepareStatement(sql3);
             stmt3.setInt(1, id);
            stmt.setInt(1, id);
             stmt4.setInt(1, id);
            stmt1.setInt(1, id);
            stmt2.setInt(1, id);
            // Executing the statement
           
            stmt1.executeUpdate();
              stmt2.executeUpdate();
            stmt4.executeUpdate();
            stmt3.executeUpdate();
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
