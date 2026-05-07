package com.collegeerp.dao;

import java.sql.*;
import java.util.*;
import com.collegeerp.model.Fees;

public class FeesDAO {

    // =================================================
    // ADMIN: FETCH STUDENTS WITH FEES (DEPARTMENT WISE)
    // =================================================
    public List<Object[]> getStudentsWithFeesByDepartment(int departmentId) {

        List<Object[]> list = new ArrayList<>();

        String sql =
            "SELECT s.id, s.name, s.email, d.name AS department, s.year, " +
            "IFNULL(f.amount, 0) AS amount, " +
            "IFNULL(f.status, 'Pending') AS status " +
            "FROM student s " +
            "JOIN department d ON s.department_id = d.id " +
            "LEFT JOIN fees f ON s.id = f.student_id " +
            "WHERE s.department_id=? " +
            "ORDER BY s.id";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, departmentId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Object[]{
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("department"),
                    rs.getInt("year"),
                    rs.getInt("amount"),
                    rs.getString("status")
                });
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =================================================
    // ADMIN: INSERT OR UPDATE FEES (NO DUPLICATES)
    // =================================================
    public void updateFees(int studentId, int amount, String status) {

        String checkSql =
            "SELECT id FROM fees WHERE student_id=?";

        String updateSql =
            "UPDATE fees SET amount=?, status=? WHERE student_id=?";

        String insertSql =
            "INSERT INTO fees(student_id, amount, status) VALUES (?,?,?)";

        try (Connection con = DBConnection.getConnection()) {

            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setInt(1, studentId);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                // ✅ UPDATE (already exists)
                PreparedStatement ps = con.prepareStatement(updateSql);
                ps.setInt(1, amount);
                ps.setString(2, status);
                ps.setInt(3, studentId);
                ps.executeUpdate();
            } else {
                // ✅ INSERT (first time)
                PreparedStatement ps = con.prepareStatement(insertSql);
                ps.setInt(1, studentId);
                ps.setInt(2, amount);
                ps.setString(3, status);
                ps.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =================================================
    // STUDENT: FETCH OWN FEES
    // =================================================
    public Fees getFeesByStudent(int studentId) {

        Fees fees = null;

        String sql =
            "SELECT amount, status FROM fees WHERE student_id=?";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                fees = new Fees();
                fees.setAmount(rs.getInt("amount"));
                fees.setStatus(rs.getString("status"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return fees;
    }
}
