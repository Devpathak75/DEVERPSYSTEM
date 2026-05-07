<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,com.collegeerp.dao.FeesDAO" %>

<%
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("admin")){
        response.sendRedirect("../login.jsp");
        return;
    }

    String deptIdStr = request.getParameter("departmentId");

    FeesDAO dao = new FeesDAO();
    List<Object[]> list = null;

    if(deptIdStr != null && !deptIdStr.equals("") && !deptIdStr.equals("null")){
        int departmentId = Integer.parseInt(deptIdStr);
        list = dao.getStudentsWithFeesByDepartment(departmentId);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Fees Management - Admin Panel</title>
    <meta charset="UTF-8">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* ===== TOP GAP ===== */
        .top-gap {
            height: 10px;
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

        /* ===== LIMITED NAVBAR ===== */
        .navbar {
            background: #0d47a1;
            padding: 14px 30px;
            display: flex;
            align-items: center;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            margin-right: 20px;
        }

        .logout {
            margin-left: auto;
            color: #ff5252 !important;
            font-weight: bold;
        }

        /* ===== MAIN CONTENT ===== */
        .main {
            flex: 1;
            padding: 40px 60px;
        }

        .page-title {
            font-size: 24px;
            margin-bottom: 25px;
            color: #333;
        }

        /* ===== FORM CONTROLS ===== */
        select, input[type=number] {
            padding: 8px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 13px;
        }

        /* ===== TABLE ===== */
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
        }

        th {
            background: #1a237e;
            color: white;
            padding: 14px;
            font-size: 14px;
            text-align: center;
        }

        td {
            padding: 12px;
            font-size: 14px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background: #f1f5ff;
        }

        .save-btn {
            padding: 8px 14px;
            background: #1565c0;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
        }

        .save-btn:hover {
            background: #0d47a1;
        }

        .success {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
            width: fit-content;
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
        <a href="dashboard.jsp">← Back to Dashboard</a>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main">

        <div class="page-title">
            Fees Management (Department Wise)
        </div>

        <% if(request.getParameter("success") != null){ %>
            <div class="success">
                ✅ Fees updated successfully!
            </div>
        <% } %>

        <!-- DEPARTMENT FILTER -->
        <form method="get">
            <label><b>Select Department</b></label><br>
            <select name="departmentId" onchange="this.form.submit()" required>
                <option value="">-- Select Department --</option>
                <option value="1" <%= "1".equals(deptIdStr)?"selected":"" %>>Artificial Intelligence & Data Science</option>
                <option value="2" <%= "2".equals(deptIdStr)?"selected":"" %>>Computer Engineering</option>
                <option value="3" <%= "3".equals(deptIdStr)?"selected":"" %>>Mechanical Engineering</option>
                <option value="4" <%= "4".equals(deptIdStr)?"selected":"" %>>Civil Engineering</option>
            </select>
        </form>

        <br>

        <% if(list != null){ %>

        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Department</th>
                <th>Year</th>
                <th>Amount</th>
                <th>Status</th>
                <th>Update</th>
            </tr>

            <% for(Object[] row : list){ %>
            <tr>
                <form action="../updateFees" method="post">
                    <td><%= row[0] %></td>
                    <td><%= row[1] %></td>
                    <td><%= row[2] %></td>
                    <td><%= row[3] %></td>
                    <td><%= row[4] %></td>

                    <td>
                        <input type="number" name="amount" value="<%= row[5] %>" required>
                    </td>

                    <td>
                        <select name="status">
                            <option value="Paid" <%= "Paid".equals(row[6])?"selected":"" %>>Paid</option>
                            <option value="Pending" <%= "Pending".equals(row[6])?"selected":"" %>>Pending</option>
                        </select>
                    </td>

                    <td>
                        <input type="hidden" name="studentId" value="<%= row[0] %>">
                        <input type="hidden" name="departmentId" value="<%= deptIdStr %>">
                        <button type="submit" class="save-btn">Save</button>
                    </td>
                </form>
            </tr>
            <% } %>

        </table>

        <% } %>

    </div>

    <!-- FOOTER -->
    <div class="footer">
        Developed by Dev Deepak Pathak
    </div>

</body>
</html>
