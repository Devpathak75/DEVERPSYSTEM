<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,com.collegeerp.dao.StudentDAO" %>

<%
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("admin")){
        response.sendRedirect("../login.jsp");
        return;
    }

    StudentDAO dao = new StudentDAO();
    List<Object[]> list = dao.getAllStudentsWithFees();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel - College ERP</title>
    <meta charset="UTF-8">

    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .top-gap {
            height: 13px;
            background: #f4f6f9;
        }

        .header {
            background: #1a237e;
            color: white;
            padding: 16px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header img { height: 48px; }

        .header-title {
            font-size: 26px;
            font-weight: bold;
            flex: 1;
            text-align: center;
        }

        /* 🔥 FIXED NAVBAR */
        .navbar {
            background: #0d47a1;
            padding: 14px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-left a {
            color: white;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            margin-right: 22px;
        }

        .nav-left a:hover {
            color: #ffeb3b;
            text-decoration: underline;
        }

        /* 🔥 LOGOUT BUTTON */
        .nav-right a {
            background: #ff5252;
            color: white;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
        }

        .nav-right a:hover {
            background: #ff1744;
        }

        .main {
            flex: 1;
            padding: 45px 60px;
        }

        .page-title {
            font-size: 24px;
            margin-bottom: 25px;
            color: #333;
        }

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
            padding: 14px;
            font-size: 14px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background: #f1f5ff;
        }

        .footer {
            background: #0b0b0b;
            color: #e0e0e0;
            text-align: center;
            padding: 20px;
            font-size: 15px;
        }
    </style>
</head>

<body>

<div class="top-gap"></div>

<div class="header">
    <img src="../images/university.png">
    <div class="header-title">Devs Institute of Technology and Engineering</div>
    <img src="../images/college.png">
</div>

<!-- 🔥 FIXED NAVBAR -->
<div class="navbar">
    <div class="nav-left">
        <a href="addStudent.jsp">Add Student</a>
        <a href="fees.jsp">Fees</a>
        <a href="notice.jsp">Notice</a>
    </div>

    <div class="nav-right">
        <a href="../index.jsp">Logout</a>
    </div>
</div>

<div class="main">
    <div class="page-title">All Students List (Admin View)</div>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Enrollment No</th>
            <th>Department</th>
            <th>Year</th>
            <th>Current Semester</th>
        </tr>

        <% if(list != null){
               for(Object[] row : list){

                   int year = (Integer) row[5];
                   int currentSemester = (year * 2) - 1;
        %>
        <tr>
            <td><%= row[0] %></td>
            <td><%= row[1] %></td>
            <td><%= row[2] %></td>
            <td><%= row[3] %></td>
            <td><%= row[4] %></td>
            <td><%= year %></td>
            <td><%= currentSemester %></td>
        </tr>
        <%     }
           } %>
    </table>
</div>

<div class="footer">
    Developed by Dev Deepak Pathak
</div>

</body>
</html>