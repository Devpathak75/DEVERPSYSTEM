package com.collegeerp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AssignmentDAO {

    // =====================================
    // STUDENT: GET ASSIGNMENTS
    // FILTER: DEPARTMENT + SEMESTER
    // =====================================
    public List<Object[]> getAssignmentsForStudent(int departmentId, int semester) {

        List<Object[]> list = new ArrayList<>();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            String sql =
                "SELECT sub.name AS subject_name, a.file_name, a.upload_date " +
                "FROM assignment a " +
                "JOIN subject sub ON a.subject_id = sub.id " +
                "WHERE a.department_id = ? " +
                "AND sub.semester = ? " +
                "ORDER BY a.upload_date DESC";

            ps = con.prepareStatement(sql);
            ps.setInt(1, departmentId);
            ps.setInt(2, semester);

            rs = ps.executeQuery();

            while (rs.next()) {
                Object[] row = new Object[3];
                row[0] = rs.getString("subject_name");
                row[1] = rs.getString("file_name");
                row[2] = rs.getDate("upload_date");
                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }

        return list;
    }

    // =====================================
    // Faculty: GET ASSIGNMENTS
    // FILTER: DEPARTMENT + SUBJECT
    // =====================================
    public List<Object[]> getAssignmentsForFaculty(int departmentId, int subjectId) {

        List<Object[]> list = new ArrayList<>();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            String sql =
                "SELECT a.id, sub.name, a.file_name, a.upload_date " +
                "FROM assignment a " +
                "JOIN subject sub ON a.subject_id = sub.id " +
                "WHERE a.department_id = ? AND a.subject_id = ? " +
                "ORDER BY a.upload_date DESC";

            ps = con.prepareStatement(sql);
            ps.setInt(1, departmentId);
            ps.setInt(2, subjectId);

            rs = ps.executeQuery();

            while (rs.next()) {
                Object[] row = new Object[4];
                row[0] = rs.getInt(1);     // assignment id
                row[1] = rs.getString(2);  // subject name
                row[2] = rs.getString(3);  // file name
                row[3] = rs.getDate(4);    // upload date
                list.add(row);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }

        return list;
    }

    // =====================================
    // 🔥 NEW: GET FILE NAME BY ASSIGNMENT ID
    // (SERVER FILE DELETE KE LIYE)
    // =====================================
    public String getFileNameById(int assignmentId) {

        String fileName = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "SELECT file_name FROM assignment WHERE id=?")) {

            ps.setInt(1, assignmentId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                fileName = rs.getString("file_name");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return fileName;
    }

    // =====================================
    // faculty: DELETE ASSIGNMENT (DB ONLY)
    // =====================================
    public boolean deleteAssignment(int assignmentId) {

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DBConnection.getConnection();

            String sql = "DELETE FROM assignment WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, assignmentId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }

        return false;
    }
}