package com.collegeerp.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.collegeerp.dao.DBConnection;

@WebServlet("/sendOtp")
public class SendOtpServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)

            throws IOException {

        HttpSession session =
                request.getSession(true);

        // CLEAR OLD SESSION

        session.removeAttribute("email");
        session.removeAttribute("otp");
        session.removeAttribute("otpTime");

        // ROLE HANDLING

        String role =
                request.getParameter("role");

        if (role == null ||
            role.trim().isEmpty()) {

            role =
                (String) session.getAttribute("role");

        } else {

            session.setAttribute(
                    "role",
                    role);
        }

        // INVALID ROLE

        if (role == null) {

            response.sendRedirect(
                    "login.jsp?error=InvalidRole");

            return;
        }

        Connection con = null;

        PreparedStatement ps = null;

        ResultSet rs = null;

        try {

            String email = null;

            con = DBConnection.getConnection();

            // =========================
            // STUDENT LOGIN
            // =========================

            if ("student".equals(role)) {

                String enrollment =
                        request.getParameter(
                                "enrollment");

                String password =
                        request.getParameter(
                                "password");

                ps = con.prepareStatement(

                        "SELECT id, name, email, " +

                        "password, year, department_id " +

                        "FROM student WHERE enrollment=?"

                );

                ps.setString(1, enrollment);

                rs = ps.executeQuery();

                if (!rs.next()) {

                    response.sendRedirect(

                            "login.jsp?type=student&error=Enrollment not found"

                    );

                    return;
                }

                if (!rs.getString("password")
                        .equals(password)) {

                    response.sendRedirect(

                            "login.jsp?type=student&error=Wrong password"

                    );

                    return;
                }

                email =
                        rs.getString("email");

                session.setAttribute(
                        "studentId",
                        rs.getInt("id"));

                session.setAttribute(
                        "studentName",
                        rs.getString("name"));

                session.setAttribute(
                        "departmentId",
                        rs.getInt("department_id"));

                session.setAttribute(
                        "year",
                        rs.getInt("year"));

                session.setAttribute(
                        "email",
                        email);
            }

            // =========================
            // ADMIN LOGIN
            // =========================

            else if ("admin".equals(role)) {

                String emailInput =
                        request.getParameter("email");

                String password =
                        request.getParameter("password");

                ps = con.prepareStatement(

                        "SELECT email FROM admin " +

                        "WHERE email=? AND password=?"

                );

                ps.setString(1, emailInput);

                ps.setString(2, password);

                rs = ps.executeQuery();

                if (!rs.next()) {

                    response.sendRedirect(

                            "login.jsp?type=admin&error=Invalid credentials"

                    );

                    return;
                }

                email =
                        rs.getString("email");

                session.setAttribute(
                        "email",
                        email);
            }

            // =========================
            // FACULTY LOGIN
            // =========================

            else if ("faculty".equals(role)) {

                String emailInput =
                        request.getParameter("email");

                String password =
                        request.getParameter("password");

                ps = con.prepareStatement(

                        "SELECT email FROM faculty " +

                        "WHERE email=? AND password=?"

                );

                ps.setString(1, emailInput);

                ps.setString(2, password);

                rs = ps.executeQuery();

                if (!rs.next()) {

                    response.sendRedirect(

                            "login.jsp?type=faculty&error=Invalid credentials"

                    );

                    return;
                }

                email =
                        rs.getString("email");

                session.setAttribute(
                        "email",
                        email);
            }

            else {

                response.sendRedirect(
                        "login.jsp?error=InvalidRole");

                return;
            }

            // =========================
            // OTP GENERATION
            // =========================

            int otp =
                    new Random().nextInt(900000)
                    + 100000;

            session.setAttribute(
                    "otp",
                    otp);

            session.setAttribute(
                    "otpTime",
                    System.currentTimeMillis());

            // EMAILJS DATA

            request.setAttribute(
                    "email",
                    email);

            request.setAttribute(
                    "otp",
                    otp);

            request.setAttribute(
                    "sent",
                    "1");

            System.out.println(
                    "ROLE: " + role);

            System.out.println(
                    "OTP GENERATED FOR: " + email);

            System.out.println(
                    "OTP IS: " + otp);

            // FORWARD TO VERIFY PAGE

            RequestDispatcher rd =
                    request.getRequestDispatcher(
                            "verifyOtp.jsp");

            rd.forward(request, response);
        }

        catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "login.jsp?error=ServerError");
        }

        finally {

            try {

                if (rs != null)
                    rs.close();

            } catch (Exception ignored) {
            }

            try {

                if (ps != null)
                    ps.close();

            } catch (Exception ignored) {
            }

            try {

                if (con != null)
                    con.close();

            } catch (Exception ignored) {
            }
        }
    }
}
