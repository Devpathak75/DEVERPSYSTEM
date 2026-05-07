package com.collegeerp.dao;

import java.sql.*;
import java.util.*;

import com.collegeerp.model.Student;

public class StudentDAO {

    // ======================================
    // ADD STUDENT (ADMIN) 🔥 WITH ENROLLMENT
    // ======================================
    public boolean addStudent(Student s) {

        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql =
                "INSERT INTO student(name, email, password, year, department_id, enrollment) " +
                "VALUES(?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, s.getName());
            ps.setString(2, s.getEmail());
            ps.setString(3, s.getPassword());
            ps.setInt(4, s.getYear());
            ps.setInt(5, s.getDepartmentId());
            ps.setString(6, s.getEnrollment());   // 🔥 IMPORTANT

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // ======================================
    // STUDENT LOGIN 🔥 ENROLLMENT + PASSWORD
    // ======================================
    public Student loginStudentByEnrollment(String enrollment, String password) {

        Student s = null;

        try {
            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT s.*, d.name AS department " +
                "FROM student s JOIN department d ON s.department_id = d.id " +
                "WHERE s.enrollment=? AND s.password=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, enrollment);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                s = new Student();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setEmail(rs.getString("email"));
                s.setEnrollment(rs.getString("enrollment"));
                s.setYear(rs.getInt("year"));
                s.setDepartment(rs.getString("department"));
                s.setDepartmentId(rs.getInt("department_id"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return s;
    }

    // ======================================
    // ADMIN: GET ALL STUDENTS
    // ======================================
    public List<Student> getAllStudents() {

        List<Student> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT s.id, s.name, s.email, s.enrollment, s.year, d.name AS department " +
                "FROM student s JOIN department d ON s.department_id = d.id";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Student s = new Student();
                s.setId(rs.getInt("id"));
                s.setName(rs.getString("name"));
                s.setEmail(rs.getString("email"));
                s.setEnrollment(rs.getString("enrollment"));
                s.setYear(rs.getInt("year"));
                s.setDepartment(rs.getString("department"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ======================================
    // ADMIN: STUDENTS WITH FEES
    // ======================================
    public List<Object[]> getAllStudentsWithFees() {

        List<Object[]> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT s.id, s.name, s.email, s.enrollment, d.name AS department, s.year, " +
                "IFNULL(f.amount, 0) AS amount, " +
                "IFNULL(f.status, 'Pending') AS status " +
                "FROM student s " +
                "JOIN department d ON s.department_id = d.id " +
                "LEFT JOIN fees f ON s.id = f.student_id";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Object[] row = new Object[8];
                row[0] = rs.getInt("id");
                row[1] = rs.getString("name");
                row[2] = rs.getString("email");
                row[3] = rs.getString("enrollment");
                row[4] = rs.getString("department");
                row[5] = rs.getInt("year");
                row[6] = rs.getInt("amount");
                row[7] = rs.getString("status");

                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ======================================
    // 🔥 STUDENT PROFILE (FINAL)
    // ======================================
    public Object[] getStudentProfile(int studentId) {

        Object[] data = null;

        try {
            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT s.name, s.email, s.enrollment, s.year, d.name AS department, s.department_id " +
                "FROM student s JOIN department d ON s.department_id = d.id " +
                "WHERE s.id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                int year = rs.getInt("year");
                int semester = (year * 2) - 1;

                data = new Object[7];
                data[0] = rs.getString("name");
                data[1] = rs.getString("email");
                data[2] = rs.getString("enrollment");
                data[3] = rs.getString("department");
                data[4] = year;
                data[5] = semester;
                data[6] = rs.getInt("department_id");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return data;
    }

    // ======================================
    // 🔥 CURRENT SEMESTER SUBJECTS
    // ======================================
    public List<String> getCurrentSemesterSubjects(int departmentId, int semester) {

        List<String> subjects = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT name FROM subject " +
                "WHERE department_id=? AND semester=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, departmentId);
            ps.setInt(2, semester);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                subjects.add(rs.getString("name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return subjects;
    }
}
