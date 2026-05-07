<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,com.collegeerp.dao.AssignmentDAO" %>

<%
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("faculty")){
        response.sendRedirect("../login.jsp");
        return;
    }

    String deptStr    = request.getParameter("departmentId");
    String yearStr    = request.getParameter("year");
    String subjectStr = request.getParameter("subjectId");

    List<Object[]> list = null;

    if(deptStr != null && yearStr != null && subjectStr != null &&
       !deptStr.isEmpty() && !yearStr.isEmpty() && !subjectStr.isEmpty()) {

        AssignmentDAO dao = new AssignmentDAO();
        list = dao.getAssignmentsForFaculty(
            Integer.parseInt(deptStr),
            Integer.parseInt(subjectStr)
        );
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>View Uploaded Assignments</title>

<script>
function loadSubjects(){
    var dept = document.getElementById("departmentId").value;
    var year = document.getElementById("year").value;

    if(dept === "" || year === ""){
        document.getElementById("subjectDiv").innerHTML =
            "<select><option>Select Department & Year</option></select>";
        return;
    }

    var sem = 0;
    if(year==1) sem=1;
    else if(year==2) sem=3;
    else if(year==3) sem=5;
    else if(year==4) sem=7;

    fetch("../getSubjects?deptId="+dept+"&semester="+sem)
        .then(res=>res.text())
        .then(data=>document.getElementById("subjectDiv").innerHTML=data);
}

function reload(){
    var d=document.getElementById("departmentId").value;
    var y=document.getElementById("year").value;
    var s=document.getElementById("subjectId").value;

    if(d && y && s){
        location="viewAssignments.jsp?departmentId="+d+"&year="+y+"&subjectId="+s;
    }
}
</script>

<style>
body{font-family:'Segoe UI';background:#f4f6f9;margin:0}
.header{
    background:#1a237e;
    color:white;
    padding:15px 30px;
    display:flex;
    align-items:center;
}
.header h2{
    flex:1;
    text-align:center;
    margin:0;
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


/* FOOTER */
.footer{
    background:#0b0b0b;
    color:#e0e0e0;
    text-align:center;
    padding:20px;
    margin-top:125px;
}

.logout{color:#ff5252;text-decoration:none;font-weight:bold}
.box{width:90%;margin:30px auto;background:white;padding:25px;border-radius:12px}
select{padding:10px;width:220px;margin-right:15px}
button{padding:10px 18px}
table{width:100%;margin-top:25px;border-collapse:collapse}
th{background:#1a237e;color:white;padding:12px}
td{padding:12px;text-align:center;border-bottom:1px solid #eee}
</style>
</head>

<body>

<div class="header">
    <h2>Devs Institute of Technology and Engineering</h2>
</div>

<!-- NAV -->
<div class="navbar">
    <a href="dashboard.jsp">← Dashboard</a>
</div>


<div class="box">

<h2>View Uploaded Assignments</h2>

<% if("1".equals(request.getParameter("deleted"))){ %>
    <p style="color:green;font-weight:bold;">✅ Assignment deleted successfully</p>
<% } %>

<select id="departmentId" onchange="loadSubjects()">
<option value="">Department</option>
<option value="1" <%= "1".equals(deptStr)?"selected":"" %>>AI & DS</option>
<option value="2" <%= "2".equals(deptStr)?"selected":"" %>>Computer</option>
<option value="3" <%= "3".equals(deptStr)?"selected":"" %>>Mechanical</option>
<option value="4" <%= "4".equals(deptStr)?"selected":"" %>>Civil</option>
</select>

<select id="year" onchange="loadSubjects()">
<option value="">Year</option>
<option value="1" <%= "1".equals(yearStr)?"selected":"" %>>1st</option>
<option value="2" <%= "2".equals(yearStr)?"selected":"" %>>2nd</option>
<option value="3" <%= "3".equals(yearStr)?"selected":"" %>>3rd</option>
<option value="4" <%= "4".equals(yearStr)?"selected":"" %>>Final</option>
</select>

<div id="subjectDiv" style="display:inline;">
<select id="subjectId" onchange="reload()">
<option value="">Subject</option>
</select>
</div>

<button onclick="reload()">Load</button>

<% if(list != null){ %>

<table>
<tr>
<th>Subject</th>
<th>File</th>
<th>Date</th>
<th>Delete</th>
</tr>

<% if(list.isEmpty()){ %>
<tr><td colspan="4">No assignments found</td></tr>
<% } else {
for(Object[] r:list){ %>
<tr>
<td><%= r[1] %></td>
<td>
<a href="../assignments/<%= r[2] %>" target="_blank">
<%= r[2] %>
</a>
</td>
<td><%= r[3] %></td>
<td>
<a href="../deleteAssignment?id=<%= r[0] %>&departmentId=<%= deptStr %>&year=<%= yearStr %>&subjectId=<%= subjectStr %>"
onclick="return confirm('Delete assignment?')">❌</a>
</td>
</tr>
<% }} %>
</table>

<% } %>

</div>

<div class="footer">
    Developed by Dev Deepak Pathak
</div>

</body>
</html>