package com.collegeerp.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.collegeerp.dao.AttendanceDAO;

@WebServlet("/markAttendance")
public class AttendanceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        AttendanceDAO dao = new AttendanceDAO();

        // ===============================
        // SAFE PARAMETER READ
        // ===============================
        String subjectStr = request.getParameter("subjectId");
        String deptStr    = request.getParameter("departmentId");

        if (subjectStr == null || deptStr == null ||
            subjectStr.isEmpty() || deptStr.isEmpty()) {
            response.sendRedirect("faculty/attendance.jsp?error=missingParams");
            return;
        }

        int subjectId;
        int departmentId;

        try {
            subjectId = Integer.parseInt(subjectStr);
            departmentId = Integer.parseInt(deptStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("faculty/attendance.jsp?error=invalidParams");
            return;
        }

        // ===============================
        // CURRENT DATE (java.sql.Date)
        // ===============================
        Date today = new Date(System.currentTimeMillis());

        // ===============================
        // ALL STUDENT IDS (FROM JSP)
        // ===============================
        String[] studentIds = request.getParameterValues("studentIds");

        if (studentIds != null && studentIds.length > 0) {

            for (String sid : studentIds) {

                int studentId;

                try {
                    studentId = Integer.parseInt(sid);
                } catch (NumberFormatException e) {
                    continue; // skip invalid id safely
                }

                // ===============================
                // READ RADIO BUTTON VALUE
                // name = status_<studentId>
                // ===============================
                String status = request.getParameter("status_" + studentId);

                if (status == null || status.isEmpty()) {
                    status = "Absent";
                }

                // ===============================
                // GET NEXT LECTURE NUMBER
                // ===============================
                int lectureNo = dao.getNextLectureNo(
                        studentId,
                        subjectId,
                        today
                );

                // ===============================
                // INSERT ATTENDANCE (PER LECTURE)
                // ===============================
                dao.markAttendance(
                        studentId,
                        subjectId,
                        today,
                        lectureNo,
                        status
                );
            }
        }

        // ===============================
        // REDIRECT WITH SUCCESS
        // ===============================
        response.sendRedirect(
                request.getContextPath() +
                "/faculty/attendance.jsp?success=1&departmentId=" + departmentId
        );
               
    }
}