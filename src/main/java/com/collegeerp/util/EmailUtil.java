package com.collegeerp.util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {

    public static boolean sendMail(String to, int otp) {

        final String from = "devinstituteoftechnologyandeng@gmail.com";
        final String password = "bpcnqabjpkrqmghu"; // APP PASSWORD

        Properties props = new Properties();

        // 🔥 REQUIRED PROPERTIES
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // 🔥 TIMEOUTS (IMPORTANT)
        props.put("mail.smtp.connectiontimeout", "10000");
        props.put("mail.smtp.timeout", "10000");

        Session session = Session.getInstance(props,
            new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(from, password);
                }
            });

        try {
            Message msg = new MimeMessage(session);

            msg.setFrom(new InternetAddress(from, "Devs Institute ERP"));
            msg.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(to));

            msg.setSubject("Your College ERP Login OTP");

            // 🔥 HTML MESSAGE (BETTER DELIVERY)
            msg.setContent(
                "<h2>College ERP Login</h2>" +
                "<p>Your OTP is:</p>" +
                "<h1 style='color:blue;'>" + otp + "</h1>" +
                "<p>This OTP is valid for 5 minutes.</p>",
                "text/html"
            );

            Transport.send(msg);

            System.out.println("✅ OTP MAIL SENT TO: " + to);
            return true;

        } catch (Exception e) {
            System.out.println("❌ MAIL FAILED FOR: " + to);
            e.printStackTrace();
            return false;
        }
    }
}
