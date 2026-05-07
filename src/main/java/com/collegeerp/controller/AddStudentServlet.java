package com.collegeerp.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.collegeerp.dao.DBConnection;

@WebServlet("/addStudent")
public class AddStudentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();

        // ===============================
        // 🔒 BASIC SAFETY VALIDATION
        // ===============================
        String name        = request.getParameter("name");
        String email       = request.getParameter("email");
        String password    = request.getParameter("password");
        String enrollment  = request.getParameter("enrollment");
        String deptStr     = request.getParameter("departmentId");
        String yearStr     = request.getParameter("year");

        if (name == null || email == null || password == null ||
            enrollment == null || deptStr == null || yearStr == null ||
            name.isEmpty() || email.isEmpty() || password.isEmpty() ||
            enrollment.isEmpty()) {

            response.sendRedirect("admin/addStudent.jsp?error=missing");
            return;
        }

        int departmentId;
        int year;

        try {
            departmentId = Integer.parseInt(deptStr);
            year = Integer.parseInt(yearStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("admin/addStudent.jsp?error=invalidData");
            return;
        }

        // ===============================
        // 🔥 DATABASE INSERT
        // ===============================
        try (Connection con = DBConnection.getConnection()) {

            String sql =
                "INSERT INTO student " +
                "(name, email, password, year, department_id, enrollment) " +
                "VALUES (?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setInt(4, year);
            ps.setInt(5, departmentId);
            ps.setString(6, enrollment);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                System.out.println("✅ Student added: " + name);

                // 🔥 SESSION BASED SUCCESS MESSAGE
                session.setAttribute(
                    "successMsg",
                    "Student \"" + name + "\" added successfully!"
                );

                response.sendRedirect("admin/addStudent.jsp");
                return;

            } else {
                response.sendRedirect("admin/addStudent.jsp?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();

            // 🔥 DUPLICATE EMAIL / ENROLLMENT FRIENDLY MESSAGE
            session.setAttribute(
                "successMsg",
                "❌ Student already exists with same email or enrollment"
            );

            response.sendRedirect("admin/addStudent.jsp");
        }
    }
}