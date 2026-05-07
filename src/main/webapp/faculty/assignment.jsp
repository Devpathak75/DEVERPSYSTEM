<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("faculty")){
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Upload Assignment - Faculty</title>

<script>
function loadSubjects(){
    var deptId = document.getElementById("departmentId").value;
    var year   = document.getElementById("year").value;

    if(deptId === "" || year === ""){
        document.getElementById("subjectDiv").innerHTML =
            "<select><option>-- Select Department & Year First --</option></select>";
        return;
    }

    var semester = 0;
    if(year == 1) semester = 1;
    else if(year == 2) semester = 3;
    else if(year == 3) semester = 5;
    else if(year == 4) semester = 7;

    fetch("../getSubjects?deptId=" + deptId + "&semester=" + semester)
        .then(res => res.text())
        .then(data => document.getElementById("subjectDiv").innerHTML = data);
}
</script>

<style>
*{box-sizing:border-box}
body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background:#f4f6f9;
}

/* HEADER */
.header{
    background:#1a237e;
    color:white;
    padding:16px 30px;
    display:flex;
    align-items:center;
}
.header .title{
    flex:1;
    text-align:center;
    font-size:26px;
    font-weight:bold;
}
.header .logout a{
    color:#ff5252;
    text-decoration:none;
    font-weight:bold;
}

/* NAVBAR */
.navbar{
    background:#0d47a1;
    padding:12px 30px;
}
.navbar a{
    color:white;
    text-decoration:none;
    font-weight:bold;
}

/* MAIN */
.main{
    padding:40px 20px;
}

/* UPLOAD BOX */
.box{
    width:480px;
    margin:auto;
    background:white;
    padding:35px;
    border-radius:14px;
    box-shadow:0 12px 30px rgba(0,0,0,0.18);
}
.box h2{
    text-align:center;
    color:#1a237e;
    margin-bottom:25px;
}
label{font-weight:600}
select,input[type=file]{
    width:100%;
    padding:12px;
    margin:8px 0 18px;
    border-radius:6px;
    border:1px solid #ccc;
}
button{
    width:100%;
    padding:14px;
    background:#1565c0;
    color:white;
    border:none;
    border-radius:8px;
    font-size:16px;
    cursor:pointer;
}
button:hover{background:#0d47a1}

/* FOOTER */
.footer{
    background:#0b0b0b;
    color:#e0e0e0;
    text-align:center;
    padding:20px;
    margin-top:40px;
}
</style>
</head>

<body>

<!-- HEADER -->
<div class="header">
    <div class="title">Devs Institute of Technology and Engineering</div>
    </div>
</div>

<!-- NAV -->
<div class="navbar">
    <a href="dashboard.jsp">← Dashboard</a>
</div>

<div class="main">

<div class="box">

<% if(request.getParameter("success") != null){ %>
    <div style="color:green;font-weight:bold;text-align:center;margin-bottom:15px;">
        ✅ Assignment uploaded successfully
    </div>
<% } %>

<h2>Upload Assignment</h2>

<form action="../uploadAssignment" method="post" enctype="multipart/form-data">

<label>Department</label>
<select id="departmentId" name="departmentId" onchange="loadSubjects()" required>
<option value="">-- Select --</option>
<option value="1">AI & DS</option>
<option value="2">Computer</option>
<option value="3">Mechanical</option>
<option value="4">Civil</option>
</select>

<label>Year</label>
<select id="year" name="year" onchange="loadSubjects()" required>
<option value="">-- Select --</option>
<option value="1">1st Year</option>
<option value="2">2nd Year</option>
<option value="3">3rd Year</option>
<option value="4">Final Year</option>
</select>

<label>Subject</label>
<div id="subjectDiv">
<select name="subjectId" required>
<option value="">-- Select Subject --</option>
</select>
</div>

<label>Upload PDF</label>
<input type="file" name="file" accept="application/pdf" required>

<button type="submit">Upload Assignment</button>
</form>

</div>
</div>

<div class="footer">
    Developed by Dev Deepak Pathak
</div>

</body>
</html>