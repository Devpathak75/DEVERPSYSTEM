package com.collegeerp.dao;

import java.sql.*;
import java.util.*;

import com.collegeerp.model.Notice;

public class NoticeDAO {

    // ADD NOTICE
    public void addNotice(String title, String message) {

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO notice(title, message, notice_date) VALUES(?,?,CURDATE())");

            ps.setString(1, title);
            ps.setString(2, message);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // GET ALL NOTICES
    public List<Notice> getAllNotices() {

        List<Notice> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM notice ORDER BY id DESC");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Notice n = new Notice();
                n.setId(rs.getInt("id"));
                n.setTitle(rs.getString("title"));
                n.setMessage(rs.getString("message"));
                n.setDate(rs.getDate("notice_date"));

                list.add(n);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // DELETE NOTICE
    public void deleteNotice(int id) {

        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "DELETE FROM notice WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
