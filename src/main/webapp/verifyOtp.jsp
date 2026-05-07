<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // ===============================
    // SESSION SAFETY (VERY IMPORTANT)
    // ===============================
    HttpSession s = request.getSession(false);
    if (s == null) {
        response.sendRedirect("login.jsp?error=sessionExpired");
        return;
    }

    String sent   = request.getParameter("sent");
    String resent = request.getParameter("resent");
    String error  = request.getParameter("error");

    // 🔥 EMAIL SESSION SE LO
    String email = (String) s.getAttribute("email");

    // 🔒 RESEND CONTROL (ANTI MULTIPLE OTP)
    Long lastOtpTime = (Long) s.getAttribute("otpTime");
    long now = System.currentTimeMillis();

    boolean canResend = true;
    if (lastOtpTime != null && (now - lastOtpTime) < 30000) { // 30 sec
        canResend = false;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP</title>

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
            padding: 14px;
            margin: 15px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 16px;
            text-align: center;
            letter-spacing: 4px;
        }

        button {
            width: 100%;
            padding: 14px;
            margin-top: 12px;
            background: #1565c0;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover { background: #0d47a1; }

        .resend {
            background: #00695c;
        }

        .resend:hover { background: #004d40; }

        .resend:disabled {
            background: #9e9e9e;
            cursor: not-allowed;
        }

        .success {
            color: #2e7d32;
            font-weight: bold;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .error {
            color: red;
            font-weight: bold;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .info {
            color: #555;
            font-size: 13px;
            margin-top: 10px;
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

        <h2>Verify OTP</h2>

        <!-- ✅ SUCCESS MESSAGE -->
        <% if("1".equals(resent) && email != null){ %>
            <div class="success">
                OTP resent to <br>
                <span style="color:#0d47a1;"><%= email %></span>
            </div>
        <% } %>

        <% if("1".equals(sent) && email != null){ %>
            <div class="success">
                OTP sent to <br>
                <span style="color:#0d47a1;"><%= email %></span>
            </div>
        <% } %>

        <% if(error != null){ %>
            <div class="error">❌ <%= error %></div>
        <% } %>

        <!-- OTP FORM -->
        <form action="verifyOtp" method="post">
            <input type="text" name="otp" placeholder="Enter 6-digit OTP"
                   maxlength="6" required>
            <button type="submit">Verify OTP</button>
        </form>

        <!-- RESEND OTP -->
        <form action="resendOtp" method="post">
            <button type="submit" class="resend">
                Resend OTP
            </button>
        </form>
    </div>
</div>

<div class="footer">
    Developed by Dev Deepak Pathak
</div>

</body>
</html>