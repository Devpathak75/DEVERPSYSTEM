package com.collegeerp.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/downloadAssignment")
public class DownloadAssignmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // =========================
        // 1️⃣ FILE NAME READ
        // =========================
        String fileName = request.getParameter("file");

        if (fileName == null || fileName.trim().isEmpty()) {
            response.getWriter().println("Invalid file name");
            return;
        }

        // =========================
        // 2️⃣ ASSIGNMENT FOLDER PATH
        // =========================
        String assignmentDir = getServletContext().getRealPath("/") + "assignments";
        File file = new File(assignmentDir, fileName);

        if (!file.exists()) {
            response.getWriter().println("File not found on server");
            return;
        }

        // =========================
        // 3️⃣ CONTENT TYPE (AUTO)
        // =========================
        String mimeType = getServletContext().getMimeType(file.getName());
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }

        response.setContentType(mimeType);
        response.setContentLengthLong(file.length());

        // =========================
        // 4️⃣ FORCE DOWNLOAD
        // =========================
        response.setHeader(
            "Content-Disposition",
            "attachment; filename=\"" + file.getName() + "\""
        );

        // =========================
        // 5️⃣ FILE STREAM
        // =========================
        FileInputStream fis = new FileInputStream(file);
        OutputStream os = response.getOutputStream();

        byte[] buffer = new byte[4096];
        int bytesRead;

        while ((bytesRead = fis.read(buffer)) != -1) {
            os.write(buffer, 0, bytesRead);
        }

        fis.close();
        os.flush();
        os.close();
    }
}
