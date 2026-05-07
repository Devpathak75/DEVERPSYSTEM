<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,com.collegeerp.dao.AttendanceDAO,com.collegeerp.model.Attendance" %>

<%
    // ===============================
    // AUTH CHECK
    // ===============================
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("student")){
        response.sendRedirect("../login.jsp");
        return;
    }

    Integer studentId = (Integer) session.getAttribute("studentId");
    Integer year = (Integer) session.getAttribute("year");

    if(studentId == null || year == null){
        response.sendRedirect("../login.jsp");
        return;
    }

    // ===============================
    // ✅ CORRECT YEAR → SEMESTER LOGIC
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

    AttendanceDAO dao = new AttendanceDAO();
    List<Attendance> list = dao.getAttendanceByStudent(studentId);

    // ===============================
    // OVERALL SUMMARY
    // ===============================
    int total = 0;
    int present = 0;

    // ===============================
    // SUBJECT-WISE SUMMARY
    // ===============================
    Map<String,Integer> subjectTotal = new LinkedHashMap<>();
    Map<String,Integer> subjectPresent = new LinkedHashMap<>();

    if(list != null){
        for(Attendance a : list){

            // 🔒 SAFE LINE (structure unchanged)
            if(!a.getSubject().contains("")){ /* dummy safe line */ }

            // 🔥 EACH ROW = ONE LECTURE
            total++;

            String subject = a.getSubject();
            subjectTotal.put(subject, subjectTotal.getOrDefault(subject,0) + 1);

            if("Present".equalsIgnoreCase(a.getStatus())){
                present++;
                subjectPresent.put(subject, subjectPresent.getOrDefault(subject,0) + 1);
            }
        }
    }

    int percentage = (total == 0) ? 0 : (present * 100 / total);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Attendance</title>

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

        .header img { height: 45px; }

        .navbar {
            background: #0d47a1;
            padding: 12px 30px;
            text-align: right;
        }

        .navbar a {
            color: #ff5252;
            font-weight: bold;
            text-decoration: none;
        }

        .main {
            padding: 40px 70px;
        }

        .cards {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            flex: 1;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
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

        .present { color: #2e7d32; font-weight: bold; }
        .absent { color: #c62828; font-weight: bold; }

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

    <h2>Attendance Dashboard</h2>
    <h4>Semester <%= semester %></h4>

    <div class="cards">
        <div class="card">
            <h3>Total Lectures</h3>
            <p><%= total %></p>
        </div>

        <div class="card">
            <h3>Present</h3>
            <p><%= present %></p>
        </div>

        <div class="card">
            <h3>Overall %</h3>
            <p style="color:<%= percentage >= 75 ? "#2e7d32" : "#c62828" %>">
                <%= percentage %>%
            </p>
        </div>
    </div>

    <h3>Subject-wise Attendance</h3>

    <table>
        <tr>
            <th>Subject</th>
            <th>Total</th>
            <th>Present</th>
            <th>%</th>
        </tr>

        <% if(subjectTotal.isEmpty()){ %>
        <tr>
            <td colspan="4">No attendance data</td>
        </tr>
        <% } else {
            for(String subject : subjectTotal.keySet()){
                int t = subjectTotal.get(subject);
                int p = subjectPresent.getOrDefault(subject,0);
                int per = (t==0)?0:(p*100/t);
        %>
        <tr>
            <td><%= subject %></td>
            <td><%= t %></td>
            <td><%= p %></td>
            <td><%= per %>%</td>
        </tr>
        <% }} %>
    </table>

</div>

<div class="footer">
    Developed by Dev Deepak Pathak
</div>

</body>
</html>