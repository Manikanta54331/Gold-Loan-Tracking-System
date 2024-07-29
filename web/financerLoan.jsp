<%@ page language="java" import="java.sql.,java.util.,java.text.*" session="true"%>
<html>
<head>
<title>Borrower Loans</title>
</head>
<body>
<%
try {
    int fid = (int) session.getAttribute("financerId");
    if (fid != 0) {
        Connection conn = null;
        PreparedStatement stmt = null, stmt1 = null;
        ResultSet rs = null, rs1 = null;
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/glts", "root", "root");
        String sql = "SELECT * FROM loan where financer_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, fid);
        rs = stmt.executeQuery();
        while (rs.next()) {
%>
<div class='container' style='margin: 5% 35% 30% 40%;'>
    <form id="loan">
        <label for='loan_amt'>Loan Amount</label><input type="text" name="loan_amt"
            value="<%=rs.getInt("loan_amount")%>" readonly />
        <label for='loan_rate'>Loan Rate</label><input type="text" name="loan_rate"
            value="<%=rs.getFloat("loan_rate")%>" readonly />
        <label for='loan_date'>Loan Date</label><input type="text" name="loan_date"
            value="<%=rs.getString("loan_date")%>" readonly />
        <label for='loan_due'>Loan Due Date</label><input type="text" name="loan_due"
            value="<%=rs.getString("loan_due")%>" readonly />
        <label for='interestAmt'>Loan Interest Amount:</label><input type="text" name="interestAmt"
            value="<%=rs.getDouble("interestAmt")%>" readonly />
        <label for='totalAmt'>Loan Total Amount:</label><input type="text" name="totalAmt"
            value="<%=rs.getDouble("totalAmt")%>" readonly />
        <label for='interestType'>Interest Type :</label><input type="text" name="interestType"
            value="<%=rs.getString("interestType")%>" />
        <label for='fname'>Financer Name: </label><input type="text" name="fname"
            value="<%
            String bid = rs.getString("borrower_id");
            String sql1 = "SELECT * FROM borrower where borrower_id = ?";
            stmt1 = conn.prepareStatement(sql1);
            stmt1.setString(1, bid);
            rs1 = stmt1.executeQuery();
            if (rs1.next()) {
                out.print(rs1.getString("borrower_name"));
            }
            %>" readonly />
        <input type="submit" name="submit" value="Calculate Interest">
    </form>
</div>
<script src="script.js"></script>
<% }
        }
        rs.close();
        rs1.close();
        stmt.close();
        stmt1.close();
        conn.close();
    }
} catch (SQLException ex) {
    ex.printStackTrace();
} catch (Exception e) {
    e.printStackTrace();
}
%>
</body>
</html>