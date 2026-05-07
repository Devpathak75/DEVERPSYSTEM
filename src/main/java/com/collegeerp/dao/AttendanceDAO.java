package com.collegeerp.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.collegeerp.model.Attendance;

public class AttendanceDAO {

    // =====================================
    // ADMIN: GET STUDENTS BY DEPARTMENT + YEAR
    // =====================================
    public List<Object[]> getStudentsForAttendance(int departmentId, int year) {

        List<Object[]> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT id, name, enrollment " +
                "FROM student " +
                "WHERE department_id=? AND year=? " +
                "ORDER BY name"
            );

            ps.setInt(1, departmentId);
            ps.setInt(2, year);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Object[]{
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("enrollment")
                });
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =====================================
    // GET SUBJECTS BY DEPARTMENT + SEMESTER
    // =====================================
    public List<Object[]> getSubjectsByDepartmentAndSemester(int departmentId, int semester) {

        List<Object[]> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT id, name FROM subject " +
                "WHERE department_id=? AND semester=? " +
                "ORDER BY name"
            );

            ps.setInt(1, departmentId);
            ps.setInt(2, semester);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Object[]{
                    rs.getInt("id"),
                    rs.getString("name")
                });
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =====================================
    // 🔥 GET NEXT LECTURE NUMBER (SAME DAY)
    // =====================================
    public int getNextLectureNo(int studentId, int subjectId, Date date) {

        int nextLecture = 1;

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT MAX(lecture_no) FROM attendance " +
                "WHERE student_id=? AND subject_id=? AND date=?"
            );

            ps.setInt(1, studentId);
            ps.setInt(2, subjectId);
            ps.setDate(3, date);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int max = rs.getInt(1);
                if (max > 0) {
                    nextLecture = max + 1;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return nextLecture;
    }

    // =====================================
    // ADMIN: MARK ATTENDANCE (PER LECTURE)
    // =====================================
    public void markAttendance(
            int studentId,
            int subjectId,
            Date date,
            int lectureNo,
            String status) {

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO attendance " +
                "(student_id, subject_id, date, lecture_no, status) " +
                "VALUES (?,?,?,?,?)"
            );

            ps.setInt(1, studentId);
            ps.setInt(2, subjectId);
            ps.setDate(3, date);
            ps.setInt(4, lectureNo);
            ps.setString(5, status);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =====================================
    // STUDENT: VIEW OWN ATTENDANCE
    // =====================================
    public List<Attendance> getAttendanceByStudent(int studentId) {

        List<Attendance> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT sub.name, a.date, a.lecture_no, a.status " +
                "FROM attendance a " +
                "JOIN subject sub ON a.subject_id=sub.id " +
                "WHERE a.student_id=? " +
                "ORDER BY a.date DESC, a.lecture_no DESC"
            );

            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Attendance a = new Attendance();
                a.setSubject(rs.getString(1));
                a.setDate(rs.getDate(2));
                a.setLectureNo(rs.getInt(3));
                a.setStatus(rs.getString(4));
                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}