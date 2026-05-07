package com.collegeerp.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static Connection con = null;

    public static Connection getConnection() {

        try {

            Class.forName("org.postgresql.Driver");

            con = DriverManager.getConnection(
                "jdbc:postgresql://dpg-d7ua3nhpo60c73e9p280-a:5432/collegeerp",
                "collegeuser",
                "YOUR_PASSWORD_HERE"
            );

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}
