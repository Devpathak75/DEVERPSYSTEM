<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("faculty")) {
        response.sendRedirect("../login.jsp?error=sessionExpired");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Faculty Dashboard - College ERP</title>
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

        .top-gap { height: 12px; }

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

        /* NAVBAR */
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

        /* MAIN */
        .main {
            flex: 1;
            padding: 50px 60px;
        }

        .page-title {
            font-size: 24px;
            font-weight: bold;
            color: #333;
            margin-bottom: 30px;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 30px;
        }

        .card {
            background: white;
            padding: 35px 20px;
            border-radius: 14px;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
            transition: 0.3s;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
        }

        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 18px 40px rgba(0,0,0,0.25);
        }

        .card h3 {
            margin-bottom: 12px;
            color: #0d47a1;
        }

        .card p {
            color: #555;
            font-size: 14px;
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

<div class="navbar">
    <div class="nav-left">
        <a href="attendance.jsp">Attendance</a>
        <a href="assignment.jsp">Upload Assignment</a>
        <a href="viewAssignments.jsp">View Assignments</a>
    </div>
    <div class="nav-right">
        <a href="../index.jsp">Logout</a>
    </div>
</div>

<div class="main">

    <div class="page-title">Faculty Dashboard</div>

    <div class="cards">

        <a href="attendance.jsp" class="card">
            <h3>Mark Attendance</h3>
            <p>Mark Department Wise Attendance</p>
        </a>

        <a href="viewAssignments.jsp" class="card">
            <h3>Uploaded Assignments</h3>
            <p>View Department wise Uploaded Assignments</p>
        </a>

        <a href="assignment.jsp" class="card">
            <h3>Add Assignments</h3>
            <p>Add Department Wise Assignments</p>
        </a>

    </div>

</div>

<div class="footer">
    Developed by Dev Deepak Pathak
</div>

</body>
</html>