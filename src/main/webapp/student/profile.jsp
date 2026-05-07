<%@ page import="com.collegeerp.dao.StudentDAO, java.util.*" %>

<%
Integer studentId = (Integer) session.getAttribute("studentId");

if(studentId == null){
    response.sendRedirect("../login.jsp?error=sessionExpired");
    return;
}

StudentDAO dao = new StudentDAO();
Object[] profile = dao.getStudentProfile(studentId);

if(profile == null){
    response.sendRedirect("../login.jsp?error=profileNotFound");
    return;
}

// ===== CORRECT MAPPING (DAO ORDER) =====
String name = profile[0] != null ? profile[0].toString() : "";
String email = profile[1] != null ? profile[1].toString() : "";
String enrollment = profile[2] != null ? profile[2].toString() : "";
String departmentName = profile[3] != null ? profile[3].toString() : "";

int year = profile[4] != null ? Integer.parseInt(profile[4].toString()) : 0;
int currentSemester = profile[5] != null ? Integer.parseInt(profile[5].toString()) : 0;
int departmentId = profile[6] != null ? Integer.parseInt(profile[6].toString()) : 0;

// ===== SUBJECTS =====
List<String> subjects =
    dao.getCurrentSemesterSubjects(departmentId, currentSemester);
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Profile</title>

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
            height: 8px;
            background: #f4f6f9;
        }

        /* ===== HEADER ===== */
        .header {
            background: #1a237e;
            color: white;
            padding: 18px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header img {
            height: 60px;
        }

        .header-title {
            font-size: 28px;
            font-weight: bold;
            letter-spacing: 1px;
            text-align: center;
            flex: 1;
        }

        /* ===== MAIN ===== */
        .main {
            flex: 1;
            padding: 50px 20px;
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


        /* ===== PROFILE BOX ===== */
        .box {
            background: white;
            padding: 35px;
            max-width: 650px;
            margin: auto;
            border-radius: 14px;
            box-shadow: 0 12px 30px rgba(0,0,0,0.2);
        }

        h2 {
            color: #1a237e;
            margin-bottom: 25px;
        }

        p {
            font-size: 16px;
            margin: 8px 0;
        }

        h3 {
            margin-top: 25px;
            color: #0d47a1;
        }

        ul {
            margin-top: 10px;
            padding-left: 20px;
        }

        li {
            margin-bottom: 6px;
            font-size: 15px;
        }

        /* ===== FOOTER ===== */
        .footer {
            background: #0b0b0b;
            color: #e0e0e0;
            text-align: center;
            padding: 22px;
            font-size: 16px;
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

    <div class="box">
        <h2>Student Profile</h2>

        <p><b>Name:</b> <%= name %></p>
        <p><b>Email:</b> <%= email %></p>
        <p><b>Enrollment:</b> <%= enrollment %></p>
        <p><b>Department:</b> <%= departmentName %></p>
        <p><b>Year:</b> <%= year %></p>
        <p><b>Current Semester:</b> <%= currentSemester %></p>

        <h3>Current Semester Subjects</h3>
        <ul>
            <% if(subjects != null && !subjects.isEmpty()){
                   for(String sub : subjects){ %>
                <li><%= sub %></li>
            <%   }
               } else { %>
                <li>No subjects found</li>
            <% } %>
        </ul>
    </div>

</div>

<!-- FOOTER -->
<div class="footer">
    Developed by Dev Deepak Pathak
</div>

</body>
</html>
