package com.collegeerp.controller;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.collegeerp.dao.FeesDAO;

@WebServlet("/updateFees")
public class FeesServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int studentId = Integer.parseInt(request.getParameter("studentId"));
        int amount = Integer.parseInt(request.getParameter("amount"));
        String status = request.getParameter("status");

        // 🔥 departmentId safe handling
        String departmentId = request.getParameter("departmentId");

        FeesDAO dao = new FeesDAO();
        dao.updateFees(studentId, amount, status);

        // ✅ SAFE REDIRECT
        if (departmentId != null && !departmentId.equals("") && !departmentId.equals("null")) {
            response.sendRedirect(
                "admin/fees.jsp?departmentId=" + departmentId + "&success=1"
            );
        } else {
            response.sendRedirect("admin/fees.jsp?success=1");
        }
    }
}
