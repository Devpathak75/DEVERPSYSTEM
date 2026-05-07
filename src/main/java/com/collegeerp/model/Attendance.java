package com.collegeerp.model;

import java.sql.Date;

public class Attendance {

    private String subject;
    private Date date;
    private int lectureNo;   // ✅ NEW: lecture number
    private String status;

    // ===============================
    // GETTERS & SETTERS
    // ===============================

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    // ✅ NEW
    public int getLectureNo() {
        return lectureNo;
    }

    public void setLectureNo(int lectureNo) {
        this.lectureNo = lectureNo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}