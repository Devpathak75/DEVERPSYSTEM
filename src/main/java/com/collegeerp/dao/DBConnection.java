package com.collegeerp.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static Connection con = null;

    public static Connection getConnection() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/college_erp",
                "root",
                "devpathak"
            );

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}
