<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,com.collegeerp.dao.AttendanceDAO" %>

<%
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("faculty")){
        response.sendRedirect("../login.jsp");
        return;
    }

    String deptIdStr = request.getParameter("departmentId");
    String yearStr   = request.getParameter("year");

    AttendanceDAO dao = new AttendanceDAO();

    List<Object[]> students = null;
    List<Object[]> subjects = null;

    Integer departmentId = null;
    Integer year = null;
    Integer semester = null;

    if(deptIdStr != null && yearStr != null &&
       !deptIdStr.isEmpty() && !yearStr.isEmpty()){

        departmentId = Integer.parseInt(deptIdStr);
        year = Integer.parseInt(yearStr);

        // ✅ CORRECT YEAR → SEMESTER MAPPING
        if(year == 1){
            semester = 1;
        } else if(year == 2){
            semester = 3;
        } else if(year == 3){
            semester = 5;
        } else {
            semester = 7;   // ✅ FINAL YEAR FIX
        }

        students = dao.getStudentsForAttendance(departmentId, year);
        subjects = dao.getSubjectsByDepartmentAndSemester(departmentId, semester);
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Mark Attendance - Faculty</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
        }

        .header {
            background: #1a237e;
            color: white;
            padding: 16px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header img { height: 45px; }

        .navbar {
            background: #0d47a1;
            padding: 12px 30px;
            display: flex;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin-right: 20px;
            font-weight: bold;
        }

        .logout {
            margin-left: auto;
            color: #ff5252 !important;
        }

        .main {
            padding: 40px 60px;
        }

        select {
            padding: 10px;
            width: 280px;
            margin-bottom: 15px;
        }

        table {
            width: 100%;
            background: white;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        th {
            background: #1a237e;
            color: white;
            padding: 12px;
        }

        td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }

        .btn {
            margin-top: 20px;
            padding: 12px 30px;
            background: #1565c0;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 6px;
        }

        .btn:hover {
            background: #0d47a1;
        }

        .success {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 12px 18px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-weight: bold;
            width: fit-content;
        }

        .msg {
            margin-top: 20px;
            color: red;
            font-weight: bold;
        }

        .footer {
            background: #0b0b0b;
            color: #e0e0e0;
            text-align: center;
            padding: 18px;
            margin-top: 40px;
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

    <h2>Mark Attendance</h2>

    <% if("1".equals(request.getParameter("success"))){ %>
        <div class="success">✅ Attendance marked successfully</div>
    <% } %>

    <!-- FILTER -->
    <form method="get">
        <b>Department</b><br>
        <select name="departmentId" required>
            <option value="">-- Select Department --</option>
            <option value="1" <%= "1".equals(deptIdStr)?"selected":"" %>>AI & DS</option>
            <option value="2" <%= "2".equals(deptIdStr)?"selected":"" %>>Computer</option>
            <option value="3" <%= "3".equals(deptIdStr)?"selected":"" %>>Mechanical</option>
            <option value="4" <%= "4".equals(deptIdStr)?"selected":"" %>>Civil</option>
        </select><br>

        <b>Year</b><br>
        <select name="year" required>
            <option value="">-- Select Year --</option>
            <option value="1" <%= "1".equals(yearStr)?"selected":"" %>>1st Year</option>
            <option value="2" <%= "2".equals(yearStr)?"selected":"" %>>2nd Year</option>
            <option value="3" <%= "3".equals(yearStr)?"selected":"" %>>3rd Year</option>
            <option value="4" <%= "4".equals(yearStr)?"selected":"" %>>Final Year</option>
        </select><br>

        <button class="btn" type="submit">Load Students</button>
    </form>

    <% if(students != null){ %>

        <h3>Semester: <%= semester %></h3>

        <% if(students.isEmpty()){ %>
            <div class="msg">❌ No students found</div>
        <% } else { %>

        <form action="../markAttendance" method="post">

            <input type="hidden" name="departmentId" value="<%= departmentId %>">

            <b>Subject</b><br>
            <select name="subjectId" required>
                <option value="">-- Select Subject --</option>
                <% for(Object[] sub : subjects){ %>
                    <option value="<%= sub[0] %>"><%= sub[1] %></option>
                <% } %>
            </select>

            <table>
                <tr>
                    <th>Enrollment</th>
                    <th>Name</th>
                    <th>Attendance</th>
                </tr>

                <% for(Object[] s : students){ %>
                <tr>
                    <td><%= s[2] %></td>
                    <td><%= s[1] %></td>
                    <td style="text-align:left;">
                        <label>
                            <input type="radio" name="status_<%= s[0] %>" value="Present" required>
                            Present
                        </label>
                        &nbsp;&nbsp;
                        <label>
                            <input type="radio" name="status_<%= s[0] %>" value="Absent">
                            Absent
                        </label>

                        <input type="hidden" name="studentIds" value="<%= s[0] %>">
                    </td>
                </tr>
                <% } %>
            </table>

            <button class="btn" type="submit">Submit Attendance</button>
        </form>

        <% } %>
    <% } %>

</div>

<div class="footer">
    Developed by Dev Deepak Pathak
</div>

</body>
</html>