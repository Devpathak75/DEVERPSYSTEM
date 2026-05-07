package com.collegeerp.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/facultyLogin")
public class FacultyLoginServlet extends HttpServlet {

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

            response.sendRedirect("login.jsp?type=faculty&error=missing");
            return;
        }

        // ===============================
        // FACULTY LOGIN CHECK
        // (temporary hardcoded – DB later)
        // ===============================
        if (email.equals("faculty7169@gmail.com")
                && password.equals("faculty123")) {

            // ✅ CREATE / REUSE SESSION
            HttpSession session = request.getSession(false);

            // ✅ LOCK ROLE IN SESSION (VERY IMPORTANT)
            session.setAttribute("role", "faculty");
            session.setAttribute("email", email);

            // ✅ PASS DATA TO sendOtp (STUDENT STYLE)
            request.setAttribute("role", "faculty");
            request.setAttribute("email", email);
            request.setAttribute("password", password);

            // 🔥 FORWARD (NOT REDIRECT)
            request.getRequestDispatcher("sendOtp")
                   .forward(request, response);
            return;

        } else {
            response.sendRedirect("login.jsp?type=faculty&error=invalid");
        }
    }
}