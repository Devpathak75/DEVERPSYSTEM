<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("admin")){
        response.sendRedirect("../login.jsp");
        return;
    }

    // 🔥 SUCCESS MESSAGE FROM SESSION
    String successMsg = (String) session.getAttribute("successMsg");
    if(successMsg != null){
        session.removeAttribute("successMsg"); // one-time message
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Student - Admin Panel</title>
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

        .top-gap { height: 10px; }

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

        .main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 0;
        }

        .box {
            width: 480px;
            background: white;
            padding: 35px;
            border-radius: 14px;
            box-shadow: 0 12px 30px rgba(0,0,0,0.18);
        }

        .box h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #1a237e;
        }

        label {
            font-weight: 600;
            font-size: 14px;
        }

        input, select {
            width: 100%;
            padding: 12px;
            margin: 8px 0 18px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        button {
            width: 100%;
            padding: 14px;
            background: #1565c0;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background: #0d47a1;
        }

        .success {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 14px;
            font-weight: bold;
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
    <div class="header-title">
        Devs Institute of Technology and Engineering
    </div>
    <img src="../images/college.png">
</div>

<div class="navbar">
    <a href="dashboard.jsp">← Back to Dashboard</a>
</div>

<div class="main">

    <div class="box">

        <% if(successMsg != null){ %>
            <div class="success">
                ✅ <%= successMsg %>
            </div>
        <% } %>

        <h2>Add Student</h2>

        <form action="../addStudent" method="post">

            <label>Student Name</label>
            <input type="text" name="name" required>

            <label>Email</label>
            <input type="email" name="email" required>

            <label>Password</label>
            <input type="password" name="password" required>

            <label>Enrollment Number</label>
            <input type="text" name="enrollment" required>

            <label>Department</label>
            <select name="departmentId" required>
                <option value="">-- Select Department --</option>
                <option value="1">Artificial Intelligence & Data Science</option>
                <option value="2">Computer Engineering</option>
                <option value="3">Mechanical Engineering</option>
                <option value="4">Civil Engineering</option>
            </select>

            <label>Year</label>
            <select name="year" required>
                <option value="">-- Select Year --</option>
                <option value="1">First Year</option>
                <option value="2">Second Year</option>
                <option value="3">Third Year</option>
                <option value="4">Final Year</option>
            </select>

            <button type="submit">Add Student</button>

        </form>

    </div>

</div>

<div class="footer">
    Developed by Dev Deepak Pathak
</div>

</body>
</html>