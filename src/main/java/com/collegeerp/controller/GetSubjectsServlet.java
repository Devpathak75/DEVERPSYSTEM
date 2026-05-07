package com.collegeerp.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.collegeerp.dao.DBConnection;

@WebServlet("/getSubjects")
public class GetSubjectsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String deptStr = request.getParameter("deptId");
        String semStr  = request.getParameter("semester");

        // ===============================
        // 1️⃣ BASIC SAFETY CHECK
        // ===============================
        if (deptStr == null || semStr == null ||
            deptStr.isEmpty() || semStr.isEmpty()) {

            out.println("<select>");
            out.println("<option>-- Select Department & Year First --</option>");
            out.println("</select>");
            return;
        }

        int departmentId;
        int semester;

        try {
            departmentId = Integer.parseInt(deptStr);
            semester     = Integer.parseInt(semStr);
        } catch (NumberFormatException e) {

            out.println("<select>");
            out.println("<option>Invalid selection</option>");
            out.println("</select>");
            return;
        }

        // ===============================
        // 2️⃣ FETCH SUBJECTS FROM DB
        // ===============================
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                "SELECT id, name FROM subject " +
                "WHERE department_id = ? AND semester = ? " +
                "ORDER BY name"
             )) {

            ps.setInt(1, departmentId);
            ps.setInt(2, semester);

            ResultSet rs = ps.executeQuery();

            // ✅ IMPORTANT: NO onchange / NO reload
            out.println(
                "<select name='subjectId' id='subjectId' required>"
            );

            out.println("<option value=''>-- Select Subject --</option>");

            boolean hasData = false;

            while (rs.next()) {
                hasData = true;
                out.println(
                    "<option value='" + rs.getInt("id") + "'>" +
                    rs.getString("name") +
                    "</option>"
                );
            }

            if (!hasData) {
                out.println(
                    "<option value=''>No subjects available</option>"
                );
            }

            out.println("</select>");

        } catch (Exception e) {
            e.printStackTrace();

            out.println("<select>");
            out.println("<option>Error loading subjects</option>");
            out.println("</select>");
        }
    }
}