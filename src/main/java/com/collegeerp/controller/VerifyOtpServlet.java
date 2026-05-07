package com.collegeerp.controller;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/verifyOtp")
public class VerifyOtpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // 🔥 MOST IMPORTANT LINE
        // ❌ getSession(true)  -> WRONG
        // ✅ getSession(false) -> RIGHT
        HttpSession session = request.getSession(true);

        if (session == null) {
            response.sendRedirect("login.jsp?error=sessionExpired");
            return;
        }

        // ======================
        // OTP FETCH
        // ======================
        Integer sessionOtp = (Integer) session.getAttribute("otp");
        String enteredOtpStr = request.getParameter("otp");

        if (sessionOtp == null || enteredOtpStr == null || enteredOtpStr.isEmpty()) {
            response.sendRedirect("verifyOtp.jsp?error=Invalid session");
            return;
        }

        int enteredOtp;
        try {
            enteredOtp = Integer.parseInt(enteredOtpStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("verifyOtp.jsp?error=Invalid OTP format");
            return;
        }

        // ======================
        // OTP MATCH
        // ======================
        if (!sessionOtp.equals(enteredOtp)) {
            response.sendRedirect("verifyOtp.jsp?error=Wrong OTP");
            return;
        }

        // ======================
        // OTP SUCCESS
        // ======================
        session.removeAttribute("otp"); // one-time OTP

        String role = (String) session.getAttribute("role");

        if (role == null) {
            response.sendRedirect("login.jsp?error=sessionExpired");
            return;
        }

        // ======================
        // ROLE BASED REDIRECT
        // ======================
        if ("admin".equals(role)) {
            response.sendRedirect("admin/dashboard.jsp");
            return;
        }

        if ("faculty".equals(role)) {
            response.sendRedirect("faculty/dashboard.jsp");
            return;
        }

        if ("student".equals(role)) {
            response.sendRedirect("student/dashboard.jsp");
            return;
        }

        // ======================
        // FALLBACK
        // ======================
        response.sendRedirect("login.jsp");
    }
}