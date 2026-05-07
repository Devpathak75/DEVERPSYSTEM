<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.collegeerp.dao.FeesDAO,com.collegeerp.model.Fees" %>

<%
    // ===============================
    // AUTH CHECK
    // ===============================
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("student")){
        response.sendRedirect("../login.jsp");
        return;
    }

    // ===============================
    // GET STUDENT ID
    // ===============================
    Integer studentId = (Integer) session.getAttribute("studentId");

    FeesDAO dao = new FeesDAO();
    Fees fees = dao.getFeesByStudent(studentId);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Your Fees Status</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* ===== TOP GAP ===== */
        .top-gap {
            height: 8px;
            background: #f4f6f9;
        }

        /* ===== HEADER ===== */
        .header {
            background: #1a237e;
            color: white;
            padding: 16px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header img {
            height: 48px;
        }

        .header-title {
            font-size: 26px;
            font-weight: bold;
            letter-spacing: 1px;
            flex: 1;
            text-align: center;
        }

        /* ===== NAVBAR ===== */
        .navbar {
            background: #0d47a1;
            padding: 12px;
            text-align: right;
            padding-right: 40px;
        }

        .navbar a {
            color: #ff5252;
            text-decoration: none;
            font-weight: bold;
            font-size: 15px;
        }

        /* ===== MAIN CONTENT ===== */
      .main {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
}
        .page-title {
            font-size: 24px;
            margin-bottom: 25px;
            color: #333;
        }

        /* ===== TABLE ===== */
        table {
            width: 60%;
            background: white;
            border-collapse: collapse;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        th {
            background: #1a237e;
            color: white;
            padding: 16px;
            text-align: left;
            font-size: 15px;
        }

        td {
            padding: 22px;
            border-bottom: 3px solid #eee;
            font-size: 15px;
        }

        .paid {
            color: #2e7d32;
            font-weight: bold;
        }

        .pending {
            color: #c62828;
            font-weight: bold;
        }

        .no-data {
            text-align: center;
            padding: 25px;
            color: #666;
        }

        /* ===== FOOTER ===== */
        .footer {
            background: #0b0b0b;
            color: #e0e0e0;
            text-align: center;
            padding: 20px;
            font-size: 15px;
            letter-spacing: 0.5px;
        }
    </style>
</head>

<body>

    <!-- TOP GAP -->
    <div class="top-gap"></div>

    <!-- HEADER -->
    <div class="header">
        <img src="../images/university.png" alt="University Logo">

        <div class="header-title">
            Devs Institute of Technology and Engineering
        </div>

        <img src="../images/college.png" alt="College Logo">
    </div>

    <!-- NAVBAR -->
    <div class="navbar">
        <a href="dashboard.jsp">Back to Dashboard</a>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main">

       <head>
    <title>Your Fees Status</title>
    <meta charset="UTF-8">
</head>

        <table>
            <tr>
                <th>Total Amount</th>
                <th>Status</th>
            </tr>

            <%
                if(fees == null){
            %>
                <tr>
                    <td colspan="2" class="no-data">
                        Fees record not found
                    </td>
                </tr>
            <%
                } else {
                    String status = fees.getStatus();
            %>
                <tr>
                    <td>₹ <%= fees.getAmount() %></td>
                    <td class="<%= "Paid".equalsIgnoreCase(status) ? "paid" : "pending" %>">
                        <%= status %>
                    </td>
                </tr>
            <%
                }
            %>

        </table>

    </div>

    <!-- FOOTER -->
    <div class="footer">
        Developed by Dev Deepak Pathak
    </div>

</body>
</html>
