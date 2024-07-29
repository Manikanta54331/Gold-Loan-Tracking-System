<%-- 
    Document   : financerDisplay
    Created on : Mar 16, 2024, 8:11:18 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.io.*,java.sql.*,java.text.*,java.util.*" session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Financers List</title>
    </head>
    <body>
        <%
            Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            // Establishing the connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/glts", "root", "root");

            // Creating the SQL statement
            String sql = "SELECT * FROM borrower";
            stmt = conn.createStatement();
            int i=1;
            // Executing the query
            rs = stmt.executeQuery(sql);
            
            
            // Processing the result
            
            
            out.println("<html lang='en'>");
            out.println("<head>");  
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("<link rel='stylesheet' type='text/css' href='/GLTS/table.css'>");
            out.println("<title>Borrower List</title>");
            out.println("</head>");
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
"    </header>");

           
            out.println("");
            out.println("");
            out.println("<section class='hero'>");
            out.println("<table align='center' border='1' id='tab'>");
            out.println("<tr>");
            out.println("<th>Borrower Id</th>");
            out.println("<th>Borrower Name</th>");
            out.println("<th>Borrower Password</th>");
            out.println("<th>Borrower Address</th>");
            out.println("<th>Borrower Email</th>");
            out.println("<th>Borrower Phone No</th>");
            out.println("<th>Financer Id</th>");
            out.println("<th>Update</th>");
            out.println("<th>Delete</th>");
            out.println("</tr>");
            while (rs.next()) {
                
            out.println("<tr><td>"+i+"</td><td>" + rs.getString("borrower_name") + "</td><td>" +rs.getString("borrower_password")+"</td><td>" + rs.getString("borrower_address") + "</td><td>"  + rs.getString("borrower_email") +"</td><td>" + rs.getString("borrower_phno") + "</td><td>" + rs.getInt("financer_id") + "</td><td ><a href='/GLTS/UpdateUser?id="+rs.getInt("borrower_id")+"' style='text-decoration:none;'>Update</a></td><td ><a href='/GLTS/DeleteServlet?id="+rs.getInt("borrower_id")+"' style='text-decoration:none;'>Delete</a></td></tr>");
                i++;
            }
            out.println("</table></section>");
            out.println("<footer><p>&copy; 2024 Gold Loan Tracker. All rights reserved.</p></footer>");
            out.println("</body>");
            out.println("</html>");
           
            
        } catch (Exception e) {
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
            %>
    </body>
</html>
