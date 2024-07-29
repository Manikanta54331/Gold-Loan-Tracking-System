<%@ page language="java" import="java.sql.*,java.util.*,java.text.*" session="true"%>
<html>
<head>
    <title>Interest</title>
    <link rel="stylesheet" href="main.css">
</head>
<body>
<%
    boolean success = false;

    double loanRate = Double.parseDouble(request.getParameter("loan_rate"));
    double loanAmount = Double.parseDouble(request.getParameter("loan_amt"));
    String loanDateStr = request.getParameter("loan_date");
    String interestType = request.getParameter("interestType");

    try {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date loanDate = sdf.parse(loanDateStr);
        java.util.Date currentDate = new java.util.Date();

        if (interestType.equals("CI")) {
            long loanDateMs = loanDate.getTime();
            long currentDateMs = currentDate.getTime();
            int months = (int) ((currentDateMs - loanDateMs) / (1000 * 60 * 60 * 24 * 30));
            double compoundInterest = loanAmount * Math.pow(1 + loanRate, months);
            double intAmt = Double.parseDouble(String.format("%.2f", compoundInterest));
            request.setAttribute("interestAmt", intAmt);
            request.setAttribute("totalAmt", intAmt + loanAmount);
        } else {
            long numberOfDays = (currentDate.getTime() - loanDate.getTime()) / (1000 * 60 * 60 * 24);
            double interestAmount = (loanAmount * loanRate * numberOfDays) / (100 * 365);
            double intAmt = Double.parseDouble(String.format("%.2f", interestAmount));
            double totalAmt = intAmt + loanAmount;

            Connection conn = null;
            PreparedStatement stmt1 = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/glts", "root", "root");
                String sql1 = "UPDATE loan SET interestAmt = ?, totalAmt = ? WHERE borrower_id = ?";
                stmt1 = conn.prepareStatement(sql1);
                stmt1.setDouble(1, intAmt);
                stmt1.setDouble(2, totalAmt);
                stmt1.setString(3, session.getAttribute("borrowerId").toString());
                stmt1.executeUpdate();
                success = true;
            } catch (SQLException ex) {
                ex.printStackTrace();
            } finally {
                if (stmt1 != null) stmt1.close();
                if (conn != null) conn.close();
            }
        }
    } catch (ParseException e) {
        e.printStackTrace();
    }

    if (success) {
        response.sendRedirect("borrowerLoan.jsp");
    } else {
        out.println("Error processing loan interest. Please try again.");
    }
%>
</body>
</html>
