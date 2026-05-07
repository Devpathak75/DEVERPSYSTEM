<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,com.collegeerp.dao.NoticeDAO,com.collegeerp.model.Notice" %>

<%
    String role = (String) session.getAttribute("role");
    if(role == null || !role.equals("admin")){
        response.sendRedirect("../login.jsp");
        return;
    }

    NoticeDAO dao = new NoticeDAO();
    List<Notice> list = dao.getAllNotices();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Notices - Admin Panel</title>
    <meta charset="UTF-8">

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
            height: 10px;
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

        /* ===== MAIN CONTENT ===== */
        .main {
            flex: 1;
            padding: 40px 60px;
        }

        .page-title {
            font-size: 24px;
            margin-bottom: 30px;
            color: #333;
        }

        /* ===== FORM BOX (CENTER FIX) ===== */
        .box {
            width: 520px;
            background: white;
            padding: 30px;
            border-radius: 14px;
            box-shadow: 0 12px 30px rgba(0,0,0,0.18);
            margin: 0 auto 40px auto;   /* 🔥 CENTER ALIGN */
        }

        .box h3 {
            margin-bottom: 18px;
            color: #1a237e;
            text-align: center;
        }

        label {
            font-weight: 600;
            font-size: 14px;
        }

        input, textarea {
            width: 100%;
            padding: 12px;
            margin: 8px 0 18px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        button {
            display: block;
            margin: auto;
            padding: 12px 26px;
            background: #1565c0;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
        }

        button:hover {
            background: #0d47a1;
        }

        /* ===== TABLE ===== */
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
            text-align: left;
        }

        td {
            padding: 14px;
            font-size: 14px;
            border-bottom: 1px solid #eee;
            vertical-align: top;
        }

        tr:hover {
            background: #f1f5ff;
        }

        .delete {
            color: #c62828;
            font-weight: bold;
            text-decoration: none;
        }

        .delete:hover {
            text-decoration: underline;
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

    <div class="top-gap"></div>

    <!-- HEADER -->
    <div class="header">
        <img src="../images/university.png">
        <div class="header-title">
            Devs Institute of Technology and Engineering
        </div>
        <img src="../images/college.png">
    </div>

    <!-- NAVBAR -->
    <div class="navbar">
        <a href="dashboard.jsp">← Back to Dashboard</a>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main">

        <div class="page-title">
            Manage Notices
        </div>

        <!-- CENTERED ADD NOTICE BOX -->
        <div class="box">
            <h3>Add New Notice</h3>

            <form action="../addNotice" method="post">
                <label>Title</label>
                <input type="text" name="title" required>

                <label>Message</label>
                <textarea name="message" rows="4" required></textarea>

                <button type="submit">Add Notice</button>
            </form>
        </div>

        <!-- NOTICE TABLE -->
        <table>
            <tr>
                <th>Title</th>
                <th>Message</th>
                <th>Date</th>
                <th>Action</th>
            </tr>

            <% for(Notice n : list){ %>
            <tr>
                <td><%= n.getTitle() %></td>
                <td><%= n.getMessage() %></td>
                <td><%= n.getDate() %></td>
                <td>
                    <a href="deleteNotice.jsp?id=<%= n.getId() %>" class="delete">
                        Delete
                    </a>
                </td>
            </tr>
            <% } %>
        </table>

    </div>

    <!-- FOOTER -->
    <div class="footer">
        Developed by Dev Deepak Pathak
    </div>

</body>
</html>
