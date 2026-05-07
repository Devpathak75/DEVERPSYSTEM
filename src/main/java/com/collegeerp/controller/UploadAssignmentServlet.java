package com.collegeerp.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.collegeerp.dao.DBConnection;

@WebServlet("/uploadAssignment")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1 MB
    maxFileSize = 1024 * 1024 * 10,        // 10 MB
    maxRequestSize = 1024 * 1024 * 20      // 20 MB
)
public class UploadAssignmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ===============================
        // 1️⃣ SAFE PARAMETER READ
        // ===============================
        String deptStr    = request.getParameter("departmentId");
        String yearStr    = request.getParameter("year");
        String subjectStr = request.getParameter("subjectId");

        if (deptStr == null || yearStr == null || subjectStr == null ||
            deptStr.isEmpty() || yearStr.isEmpty() || subjectStr.isEmpty()) {

            response.sendRedirect(
                request.getContextPath() +
                "/faculty/assignment.jsp?error=missingParams"
            );
            return;
        }

        int departmentId = Integer.parseInt(deptStr);
        int year         = Integer.parseInt(yearStr);
        int subjectId    = Integer.parseInt(subjectStr);

        // ===============================
        // 2️⃣ FILE READ
        // ===============================
        Part filePart = request.getPart("file");

        if (filePart == null || filePart.getSize() == 0) {
            response.sendRedirect(
                request.getContextPath() +
                "/faculty/assignment.jsp?error=nofile"
            );
            return;
        }

        String originalFileName = filePart.getSubmittedFileName();

        // 🔒 unique file name
        String fileName = System.currentTimeMillis() + "_" + originalFileName;

        // ===============================
        // 3️⃣ SAVE FILE ON SERVER
        // ===============================
        String uploadPath = getServletContext().getRealPath("/") + "assignments";
        File uploadDir = new File(uploadPath);

        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        filePart.write(uploadPath + File.separator + fileName);

        // ===============================
        // 4️⃣ SAVE RECORD IN DATABASE
        // ===============================
        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO assignment " +
                "(department_id, subject_id, file_name, upload_date) " +
                "VALUES (?,?,?,CURDATE())"
            );

            ps.setInt(1, departmentId);
            ps.setInt(2, subjectId);
            ps.setString(3, fileName);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // ===============================
        // 5️⃣ 🔥 REDIRECT WITH SAME FILTER
        // ===============================
        response.sendRedirect(
            request.getContextPath() +
            "/faculty/assignment.jsp?success=1" +
            "&departmentId=" + departmentId +
            "&year=" + year +
            "&subjectId=" + subjectId
        );
    }
}