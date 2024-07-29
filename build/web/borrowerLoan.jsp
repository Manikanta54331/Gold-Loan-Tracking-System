<%@ page language="java" import="java.sql.*,java.util.*,java.text.*" session="true"%>
<html>
<head>
    <title>Borrower Loans</title>
    <link rel="stylesheet" href="main.css">
</head>

<body>
<header>
    <h1>Gold Loan Tracker</h1>
    <center><p><em>Track your gold loan status with ease.</em></p></center>
    <nav style="text-align: center;">
        <ul>
            <li>Logged In As Borrower</li>
        </ul>
    </nav>
    <button id="logoutButton" style="position: fixed; top: 10px; right: 10px; padding: 10px; background-color: #f5f5f5; color: #3b3c36; cursor: pointer;" onclick="window.location.href='logout.jsp';"><b>Logout</b></button>
</header>

<%
Connection conn = null;
PreparedStatement stmt = null, stmt1 = null;
ResultSet rs = null, rs1 = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/glts", "root", "root");
    String sql = "SELECT * FROM loan where borrower_id = ?";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, session.getAttribute("borrowerId").toString());
    rs = stmt.executeQuery();
    while (rs.next()) {
%>
<div class='container' style='margin: 5% 15% 10% 15%; width:900px; height: 200px;'>
    <form id="loan" name="loan" method="post" action='Interest.jsp'>
        <label for='loan_amt'>Loan Amount : </label>
        <input type="text" name="loan_amt" value="<%=rs.getInt("loan_amount")%>" readonly />
        <label for='loan_rate'>Loan Rate : </label>
        <input type="text" name="loan_rate" value="<%=rs.getFloat("loan_rate")%>" readonly /><br>
        <label for='loan_date'>Loan Date : </label>
        <input type="text" name="loan_date" value="<%=rs.getString("loan_date")%>" readonly />
        <label for='loan_due'>Loan Due Date : </label>
        <input type="text" name="loan_due" value="<%=rs.getString("loan_due")%>" readonly /><br>
        <label for='interestAmt'>Loan Interest Amount : </label>
        <input type="text" name="interestAmt" value="<%=rs.getDouble("interestAmt")%>" />
        <label for='totalAmt'>Loan Total Amount : </label>
        <input type="text" name="totalAmt" value="<%=rs.getDouble("totalAmt")%>" /><br>
        <input type="hidden" name="interestType" value="<%=rs.getString("interestType")%>" />
        <label for='fname'>Financer Name : </label>
        <input type="text" name="fname" value="<%
            String fid = rs.getString("financer_id");
            String sql1 = "SELECT * FROM financer where financer_id = ?";
            stmt1 = conn.prepareStatement(sql1);
            stmt1.setString(1, fid);
            rs1 = stmt1.executeQuery();
            if (rs1.next()) {
                out.print(rs1.getString("financer_name"));
            }
            %>" readonly />
        <input class="btn1" type="submit" name="submit" value="Calculate Interest">
    </form>
</div>

<%  }
}
finally{
try{
    if (rs != null) rs.close();
    if (stmt1 != null) stmt1.close();
    if (stmt != null) stmt.close();
    if (conn != null) conn.close();
}
catch (Exception e) {
        e.printStackTrace();
    }

}
%>
<footer>
    <p>&copy; 2024 Gold Loan Tracker. All rights reserved.</p>
</footer>

</body>
</html>
