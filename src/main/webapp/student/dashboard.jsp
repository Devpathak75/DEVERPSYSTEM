<%
Integer studentId = (Integer) session.getAttribute("studentId");
Integer departmentId = (Integer) session.getAttribute("departmentId");
String studentName = (String) session.getAttribute("studentName");
Integer year = (Integer) session.getAttribute("year");   // 🔥 NOW IT EXISTS

if(studentId == null || departmentId == null || studentName == null || year == null){
    response.sendRedirect("../login.jsp?error=sessionExpired");
    return;
}

// 🔥 CURRENT SEMESTER LOGIC
int currentSemester = (year * 2) - 1;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard</title>

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

        .top-gap { height: 8px; }

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
            padding: 12px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-left a,
        .nav-right a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            font-size: 15px;
            margin-right: 25px;
        }

        .nav-left a:last-child {
            margin-right: 0;
        }

        /* 🔥 LOGOUT STYLE */
        .nav-right a {
            background: #ff5252;
            padding: 8px 16px;
            border-radius: 6px;
        }

        .nav-right a:hover {
            background: #ff1744;
        }

        .main {
            flex: 1;
            padding: 50px 70px;
        }

        .welcome {
            font-size: 22px;
            margin-bottom: 10px;
            color: #333;
        }

        .semester {
            font-size: 16px;
            margin-bottom: 40px;
            color: #0d47a1;
            font-weight: bold;
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
    <div class="header-title">
        Devs Institute of Technology and Engineering
    </div>
    <img src="../images/college.png">
</div>

<!-- 🔥 FIXED NAVBAR STRUCTURE -->
<div class="navbar">
    <div class="nav-left">
        <a href="attendance.jsp">Attendance</a>
        <a href="assignment.jsp">Assignment</a>
        <a href="fees.jsp">Fees</a>
        <a href="notice.jsp">Notice</a>
    </div>

    <div class="nav-right">
        <a href="../index.jsp">Logout</a>
    </div>
</div>

<div class="main">

    <div class="welcome">
       <b> Welcome - <%= studentName %></b> 
    </div>
    
    <h3>Manage Your All Academic Activities From Here</h3>

    <div class="semester">
        Current Semester: <%= currentSemester %>
    </div>

    <div class="cards">

        <a href="profile.jsp" class="card">
            <h3>My Profile</h3>
            <p>View your personal details</p>
        </a>

        <a href="attendance.jsp" class="card">
            <h3>Attendance</h3>
            <p>View subject-wise attendance details</p>
        </a>

        <a href="fees.jsp" class="card">
            <h3>Fees</h3>
            <p>Check paid and pending fee status</p>
        </a>

        <a href="notice.jsp" class="card">
            <h3>Notices</h3>
            <p>Read latest college announcements</p>
        </a>

        <a href="assignment.jsp" class="card">
            <h3>Assignments</h3>
            <p>View and submit assignments</p>
        </a>

    </div>

</div>

<div class="footer">
    Developed by Dev Deepak Pathak
</div>

</body>
</html>