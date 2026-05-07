package com.collegeerp.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.collegeerp.dao.AssignmentDAO;

@WebServlet("/deleteAssignment")
public class DeleteAssignmentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // ===============================
        // SAFE PARAMETER READ
        // ===============================
        String idStr      = request.getParameter("id");
        String deptStr    = request.getParameter("departmentId");
        String yearStr    = request.getParameter("year");
        String subjectStr = request.getParameter("subjectId");

        if (idStr == null || deptStr == null || yearStr == null || subjectStr == null ||
            idStr.isEmpty() || deptStr.isEmpty() || yearStr.isEmpty() || subjectStr.isEmpty()) {

            response.sendRedirect(
                request.getContextPath() + "/faculty/viewAssignments.jsp?error=missingParams"
            );
            return;
        }

        int assignmentId;
        try {
            assignmentId = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(
                request.getContextPath() + "/faculty/viewAssignments.jsp?error=invalidId"
            );
            return;
        }

        AssignmentDAO dao = new AssignmentDAO();

        // ===============================
        // 🔥 GET FILE NAME BEFORE DELETE
        // (DAO me method hona chahiye)
        // ===============================
        String fileName = dao.getFileNameById(assignmentId);

        // ===============================
        // DELETE FROM DATABASE
        // ===============================
        boolean deleted = dao.deleteAssignment(assignmentId);

        // ===============================
        // DELETE FILE FROM SERVER
        // ===============================
        if (deleted && fileName != null && !fileName.isEmpty()) {

            String uploadPath =
                getServletContext().getRealPath("/") + "assignments";

            File file = new File(uploadPath + File.separator + fileName);

            if (file.exists()) {
                file.delete();
            }
        }

        // ===============================
        // 🔁 REDIRECT BACK TO SAME PAGE
        // (FILTER PRESERVED)
        // ===============================
        if (deleted) {
            response.sendRedirect(
                request.getContextPath() +
                "/faculty/viewAssignments.jsp?deleted=1" +
                "&departmentId=" + deptStr +
                "&year=" + yearStr +
                "&subjectId=" + subjectStr
            );
        } else {
            response.sendRedirect(
                request.getContextPath() +
                "/faculty/viewAssignments.jsp?error=deleteFailed" +
                "&departmentId=" + deptStr +
                "&year=" + yearStr +
                "&subjectId=" + subjectStr
            );
        }
    }
}