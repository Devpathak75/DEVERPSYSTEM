package com.collegeerp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // ===============================
        // BASIC SAFETY
        // ===============================
        if (email == null || password == null ||
            email.isEmpty() || password.isEmpty()) {

            response.sendRedirect("login.jsp?type=admin&error=missing");
            return;
        }

        // ===============================
        // ADMIN LOGIN CHECK
        // (temporary hardcoded – DB later)
        // ===============================
        if (email.equals("devinstituteoftechnologyandeng@gmail.com")
                && password.equals("admin123")) {

            // ✅ CREATE / REUSE SESSION
            HttpSession session = request.getSession(false);

            // ✅ LOCK ROLE IN SESSION
            session.setAttribute("role", "admin");
            session.setAttribute("email", email);

            // ✅ PASS DATA TO sendOtp (STUDENT STYLE)
            request.setAttribute("role", "admin");
            request.setAttribute("email", email);
            request.setAttribute("password", password);

            // 🔥 FORWARD (NOT REDIRECT)
            request.getRequestDispatcher("sendOtp")
                   .forward(request, response);
            return;

        } else {
            response.sendRedirect("login.jsp?type=admin&error=invalid");
        }
    }
}