<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // ===============================
    // SESSION SAFETY
    // ===============================

    HttpSession s = request.getSession(false);

    if (s == null) {

        response.sendRedirect(
            "login.jsp?error=sessionExpired"
        );

        return;
    }

    String sent =
            request.getParameter("sent");

    String resent =
            request.getParameter("resent");

    String error =
            request.getParameter("error");

    // ===============================
    // EMAIL FROM SESSION
    // ===============================

    String email =
            (String) s.getAttribute("email");

    // ===============================
    // OTP FROM SESSION
    // ===============================

    Object otpObj =
            s.getAttribute("otp");

    String otpValue = "";

    if (otpObj != null) {

        otpValue = otpObj.toString();
    }

    // ===============================
    // OTP MAIL SEND CONTROL
    // ===============================

    Boolean mailSent =
            (Boolean) s.getAttribute("mailSent");

    if (mailSent == null) {

        mailSent = false;
    }

    // ===============================
    // RESEND CONTROL
    // ===============================

    Long lastOtpTime =
            (Long) s.getAttribute("otpTime");

    long now =
            System.currentTimeMillis();

    boolean canResend = true;

    long remainingSeconds = 0;

    if (lastOtpTime != null &&
        (now - lastOtpTime) < 30000) {

        canResend = false;

        remainingSeconds =
            30 - ((now - lastOtpTime) / 1000);
    }
%>

<!DOCTYPE html>

<html>

<head>

    <title>Verify OTP</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {

            margin: 0;
            padding: 0;

            font-family: 'Segoe UI', sans-serif;

            background: #f4f6f9;

            height: 100vh;

            display: flex;

            flex-direction: column;
        }

        .top-gap {
            height: 8px;
        }

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

        button:hover {

            background: #0d47a1;
        }

        .resend {

            background: #00695c;
        }

        .resend:hover {

            background: #004d40;
        }

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

            margin-top: 12px;
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

    <div class="header-title">

        Devs Institute of Technology and Engineering

    </div>

    <img src="images/college.png">

</div>

<div class="main">

    <div class="box">

        <h2>Verify OTP</h2>

        <!-- OTP SENT MESSAGE -->

        <% if(email != null){ %>

            <div class="success">

                OTP sent to <br>

                <span style="color:#0d47a1;">

                    <%= email %>

                </span>

            </div>

        <% } %>

        <!-- RESENT MESSAGE -->

        <% if("1".equals(resent)){ %>

            <div class="success">

                New OTP sent successfully

            </div>

        <% } %>

        <!-- ERROR MESSAGE -->

        <% if(error != null){ %>

            <div class="error">

                ❌ <%= error %>

            </div>

        <% } %>

        <!-- VERIFY OTP FORM -->

        <form action="verifyOtp" method="post">

            <input
                type="text"
                name="otp"
                placeholder="Enter 6-digit OTP"
                maxlength="6"
                required
            >

            <button type="submit">

                Verify OTP

            </button>

        </form>

        <!-- RESEND OTP -->

        <form action="resendOtp" method="post">

            <button
                id="resendBtn"
                type="submit"
                class="resend"
                <%= !canResend ? "disabled" : "" %>
            >

                Resend OTP

            </button>

        </form>

        <!-- TIMER -->

        <% if(!canResend){ %>

            <div class="info">

                Resend available in
                <span id="timer">
                    <%= remainingSeconds %>
                </span>
                sec

            </div>

        <% } %>

    </div>

</div>

<div class="footer">

    Developed by Dev Deepak Pathak

</div>

<!-- ========================= -->
<!-- EMAILJS CDN -->
<!-- ========================= -->

<script src="https://cdn.jsdelivr.net/npm/@emailjs/browser@4/dist/email.min.js"></script>

<!-- ========================= -->
<!-- EMAILJS INIT -->
<!-- ========================= -->

<script>

(function () {

    emailjs.init({

        publicKey:
            "EV3nXq16r9wmdJ9Et"

    });

})();

</script>

<!-- ========================= -->
<!-- SEND OTP MAIL -->
<!-- ========================= -->

<script>

window.onload = function () {

    <% if(
        otpValue != null &&
        !otpValue.isEmpty() &&
        !mailSent
    ){ %>

    emailjs.send(

        "service_vfxqild",

        "template_2qhv29g",

        {

            to_email:
                "<%= email %>",

            otp:
                "<%= otpValue %>"

        }

    )

    .then(function(response) {

        console.log(
            "EMAIL SENT SUCCESSFULLY"
        );

        fetch("markMailSent.jsp");

    })

    .catch(function(error) {

        console.log(
            "EMAIL FAILED"
        );

        console.log(error);

        alert(
            "OTP email failed. Check browser console."
        );

    });

    <% } %>

};

</script>

<!-- ========================= -->
<!-- RESEND TIMER -->
<!-- ========================= -->

<script>

let timerElement =
    document.getElementById("timer");

let resendBtn =
    document.getElementById("resendBtn");

let seconds =
    <%= remainingSeconds %>;

if (timerElement) {

    let countdown = setInterval(function () {

        seconds--;

        timerElement.innerText = seconds;

        if (seconds <= 0) {

            clearInterval(countdown);

            resendBtn.disabled = false;

            timerElement.innerText = "0";
        }

    }, 1000);
}

</script>

</body>

</html>
