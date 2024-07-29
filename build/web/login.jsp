<%-- 
    Document   : login
    Created on : 15-Mar-2024, 1:06:46 pm
    Author     : Mani
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.io.*,java.sql.*,java.text.*,java.util.*" session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <%
            String uname,tab, pass;
            tab=request.getParameter("role");
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            uname = request.getParameter("uname");
            pass= request.getParameter("password");
            //out.println(rs);
            try {
                // Establish connection
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/glts", "root", "root");

                // Creating the SQL statement
                String sql = "SELECT * FROM " + tab;
                ps = conn.prepareStatement(sql);
                //out.println(rs);
                // Executing the query
                rs = ps.executeQuery();
                //out.println(rs);
                // Process the result set
                while (rs.next()) {
                out.println(tab + "_name");
                    if(rs.getString(tab + "_name")==null || !rs.getString(tab + "_name").equals(uname) || !rs.getString(tab + "_password").equals(pass))
                        {
                           //out.println(tab + "_name");
                            response.sendRedirect("/GLTS/invalidUser.html");
                        }

                        // Redirect to a success page
                        else if(rs.getString(tab + "_name").equals(uname) && rs.getString(tab + "_password").equals(pass)){
                        session.setAttribute(tab + "Id", rs.getInt(tab + "_id")); 
                        //out.println(rs.getInt(tab + "_id"));
                        response.sendRedirect("/GLTS/" + tab + "home.html");

                        }
                }

            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                // Closing resources
                try {
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }


%>
    </body>
</html>
