<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,com.collegeerp.dao.NoticeDAO,com.collegeerp.model.Notice" %>

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
    // FETCH NOTICES
    // ===============================
    NoticeDAO dao = new NoticeDAO();
    List<Notice> list = dao.getAllNotices();
%>

<!DOCTYPE html>
<html>
<head>
    <title>College Notices</title>
    <meta charset="UTF-8">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            height: 100vh;
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
            padding: 16px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header img {
            height: 48px;
        }

        .header-title {
            font-size: 26px;
            font-weight: bold;
            letter-spacing: 1px;
            flex: 1;
            text-align: center;
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

        /* ===== MAIN CONTENT ===== */
        .main {
            flex: 1;
            padding: 50px 70px;
        }

        .page-title {
            font-size: 24px;
            margin-bottom: 25px;
            color: #333;
        }

        /* ===== TABLE ===== */
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
            font-size: 15px;
        }

        td {
            padding: 14px;
            border-bottom: 1px solid #eee;
            font-size: 14px;
            vertical-align: top;
        }

        tr:hover {
            background: #f1f5ff;
        }

        .no-data {
            text-align: center;
            padding: 25px;
            color: #666;
        }

        /* ===== FOOTER ===== */
        .footer {
            background: #0b0b0b;
            color: #e0e0e0;
            text-align: center;
            padding: 20px;
            font-size: 15px;
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

        <div class="page-title">
            College Notices
        </div>

        <table>
            <tr>
                <th>Title</th>
                <th>Message</th>
                <th>Date</th>
            </tr>

            <%
                if(list == null || list.size() == 0){
            %>
                <tr>
                    <td colspan="3" class="no-data">
                        No notices available
                    </td>
                </tr>
            <%
                } else {
                    for(Notice n : list){
            %>
                <tr>
                    <td><%= n.getTitle() %></td>
                    <td><%= n.getMessage() %></td>
                    <td><%= n.getDate() %></td>
                </tr>
            <%
                    }
                }
            %>

        </table>

    </div>

    <!-- FOOTER -->
    <div class="footer">
        Developed by Dev Deepak Pathak
    </div>

</body>
</html>
