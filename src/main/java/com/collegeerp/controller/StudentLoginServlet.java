package com.collegeerp.controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.collegeerp.dao.DBConnection;

@WebServlet("/studentLogin")
public class StudentLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // 🔥 KILL ANY OLD SESSION (admin / faculty)
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT id, department_id, email FROM student WHERE email=? AND password=?"
            );

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                // ✅ CREATE FRESH SESSION
                HttpSession session = request.getSession(true);

                // 🔒 LOCK STUDENT DATA
                session.setAttribute("studentId", rs.getInt("id"));
                session.setAttribute("departmentId", rs.getInt("department_id"));
                session.setAttribute("email", rs.getString("email")); // 🔥 VERY IMPORTANT
                session.setAttribute("role", "student");

                response.sendRedirect("student/dashboard.jsp");
            } else {
                response.sendRedirect("login.jsp?type=student&error=student");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=ServerError");
        }
    }
}