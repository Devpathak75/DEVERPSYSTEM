package com.collegeerp.controller;

import java.io.IOException;
import java.util.Random;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.collegeerp.util.EmailUtil;

@WebServlet("/resendOtp")
public class ResendOtpServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("email");

        if (email == null) {
            response.sendRedirect("login.jsp?error=Session expired");
            return;
        }

        // 🔥 Generate NEW OTP
        int newOtp = new Random().nextInt(900000) + 100000;

        // overwrite old OTP
        session.setAttribute("otp", newOtp);

        // send mail
        EmailUtil.sendMail(email, newOtp);

        // redirect with flag
        response.sendRedirect("verifyOtp.jsp?resent=1");
    }
}
