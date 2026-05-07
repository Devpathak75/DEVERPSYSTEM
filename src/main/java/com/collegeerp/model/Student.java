package com.collegeerp.model;

public class Student {

    private int id;
    private String name;
    private String email;
    private String password;

    // 🔥 ACADEMIC DETAILS
    private int year;          // 1,2,3,4
    private int departmentId;  // FK
    private String department; // department name

    // 🔥 IMPORTANT (LOGIN + OTP FLOW)
    private String enrollment;

    public Student() {}

    // ======================
    // GETTERS & SETTERS
    // ======================

    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    // ======================
    // YEAR & SEMESTER
    // ======================
    public int getYear() {
        return year;
    }
    public void setYear(int year) {
        this.year = year;
    }

    // 🔥 CURRENT SEMESTER AUTO
    public int getCurrentSemester() {
        return (year * 2) - 1;
    }

    // ======================
    // DEPARTMENT
    // ======================
    public int getDepartmentId() {
        return departmentId;
    }
    public void setDepartmentId(int departmentId) {
        this.departmentId = departmentId;
    }

    public String getDepartment() {
        return department;
    }
    public void setDepartment(String department) {
        this.department = department;
    }

    // ======================
    // ENROLLMENT (LOGIN KEY)
    // ======================
    public String getEnrollment() {
        return enrollment;
    }
    public void setEnrollment(String enrollment) {
        this.enrollment = enrollment;
    }
}
