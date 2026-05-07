package com.collegeerp.controller;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.collegeerp.dao.NoticeDAO;

@WebServlet("/addNotice")
public class NoticeServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String title = request.getParameter("title");
        String message = request.getParameter("message");

        NoticeDAO dao = new NoticeDAO();
        dao.addNotice(title, message);

        response.sendRedirect("admin/notice.jsp?success=1");
    }
}
