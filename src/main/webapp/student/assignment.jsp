<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,com.collegeerp.dao.AssignmentDAO" %>

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
    // STUDENT SESSION DATA
    // ===============================
    Integer departmentId = (Integer) session.getAttribute("departmentId");
    Integer year = (Integer) session.getAttribute("year");

    if(departmentId == null || year == null){
        response.sendRedirect("../login.jsp");
        return;
    }

    // ===============================
    // ✅ CORRECT YEAR → SEMESTER MAPPING
    // ===============================
    int semester;

    if(year == 1){
        semester = 1;
    } else if(year == 2){
        semester = 3;
    } else if(year == 3){
        semester = 5;
    } else {
        semester = 7;   // ✅ FINAL YEAR FIX
    }

    // ===============================
    // FETCH ASSIGNMENTS
    // ===============================
    AssignmentDAO dao = new AssignmentDAO();
    List<Object[]> list = dao.getAssignmentsForStudent(departmentId, semester);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Your Assignments</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .header {
            background: #1a237e;
            color: white;
            padding: 16px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header h2{
            color: #ffffff;
            font-weight: 700;
            letter-spacing: 1px;
            margin: 0;
            text-align: center;
            flex: 1;
        }

        .header img { height: 48px; }

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
        }

        .main {
            flex: 1;
            padding: 50px 70px;
        }

        .page-title {
            font-size: 24px;
            margin-bottom: 6px;
            color: #333;
        }

        .sub-title {
            margin-bottom: 25px;
            color: #555;
            font-size: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        th {
            background: #1a237e;
            color: white;
            padding: 14px;
            text-align: left;
        }

        td {
            padding: 14px;
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background: #f1f5ff;
        }

        .download {
            text-decoration: none;
            color: #1565c0;
            font-weight: bold;
        }

        .download:hover {
            text-decoration: underline;
        }

        .no-data {
            text-align: center;
            padding: 25px;
            color: #666;
        }

        .footer {
            background: #0b0b0b;
            color: #e0e0e0;
            text-align: center;
            padding: 20px;
        }
    </style>
</head>

<body>

<div class="header">
    <img src="../images/university.png">
    <h2>Devs Institute of Technology and Engineering</h2>
    <img src="../images/college.png">
</div>

<div class="navbar">
    <a href="dashboard.jsp">← Dashboard</a>
</div>

<div class="main">

    <div class="page-title">Your Assignments</div>
    <div class="sub-title">
        Semester <b><%= semester %></b> Assignments
    </div>

    <table>
        <tr>
            <th>Subject</th>
            <th>Assignment File</th>
            <th>Date</th>
        </tr>

        <% if(list == null || list.isEmpty()){ %>
        <tr>
            <td colspan="3" class="no-data">
                No assignments uploaded for your semester
            </td>
        </tr>
        <% } else {
            for(Object[] row : list){ %>
        <tr>
            <td><%= row[0] %></td>
            <td>
                <a class="download"
                   href="../downloadAssignment?file=<%= row[1] %>">
                    Download
                </a>
            </td>
            <td><%= row[2] %></td>
        </tr>
        <% }} %>
    </table>

</div>

<div class="footer">
    Developed by Dev Deepak Pathak
</div>

</body>
</html>