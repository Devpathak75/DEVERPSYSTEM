<%
    String type = request.getParameter("type");
    if (type == null) type = "student";
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
    <title>
        <%= type.equals("admin") ? "Admin Login" :
            type.equals("faculty") ? "Faculty Login" :
            "Student Login" %>
    </title>

    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .top-gap { height: 8px; }

        .header {
            background: #1a237e;
            color: white;
            padding: 18px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header img { height: 60px; }

        .header-title {
            font-size: 28px;
            font-weight: bold;
            text-align: center;
            flex: 1;
        }

        .main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .box {
            width: 440px;
            background: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 12px 30px rgba(0,0,0,0.2);
            text-align: center;
        }

        input {
            width: 100%;
            padding: 12px;
            margin: 10px 0 18px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 15px;
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

        .error {
            color: red;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .footer {
            background: #0b0b0b;
            color: #e0e0e0;
            text-align: center;
            padding: 22px;
            font-size: 16px;
        }
    </style>
</head>

<body>

<div class="top-gap"></div>

<div class="header">
    <img src="images/university.png">
    <div class="header-title">Devs Institute of Technology and Engineering</div>
    <img src="images/college.png">
</div>

<div class="main">
    <div class="box">

        <h2>
            <%= type.equals("admin") ? "Admin Login" :
                type.equals("faculty") ? "Faculty Login" :
                "Student Login" %>
        </h2>

        <% if (error != null) { %>
            <div class="error"><%= error %></div>
        <% } %>

        <!-- =========================
             STUDENT LOGIN
        ========================== -->
        <% if (type.equals("student")) { %>

        <form action="sendOtp" method="post">
            <input type="hidden" name="role" value="student">

            <label>Enrollment Number</label>
            <input type="text" name="enrollment" required>

            <label>Password</label>
            <input type="password" name="password" required>

            <button type="submit">Send OTP</button>
        </form>

        <% } %>

        <!-- =========================
             ADMIN LOGIN
        ========================== -->
        <% if (type.equals("admin")) { %>

        <form action="adminLogin" method="post">
            <label>Email</label>
            <input type="email" name="email" required>

            <label>Password</label>
            <input type="password" name="password" required>

            <button type="submit">Send OTP</button>
        </form>

        <% } %>

        <!-- =========================
             FACULTY LOGIN
        ========================== -->
        <% if (type.equals("faculty")) { %>

        <form action="facultyLogin" method="post">
            <label>Email</label>
            <input type="email" name="email" required>

            <label>Password</label>
            <input type="password" name="password" required>

            <button type="submit">Send OTP</button>
        </form>

        <% } %>

    </div>
</div>

<div class="footer">
    Developed by Dev Deepak Pathak
</div>

</body>
</html>