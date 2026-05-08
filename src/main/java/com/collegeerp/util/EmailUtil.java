package com.collegeerp.util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {

    public static boolean sendMail(String to, int otp) {

        final String from =
            "aa9229001@smtp-brevo.com";

        final String password =
            "xsmtpsib-19755b1557b3ab84368725f412692722d7f0372ec987fa57909e1b3131b92f74-G0DwlHvIHAzZga19";

        Properties props = new Properties();

        // BREVO SMTP SETTINGS

        props.put("mail.smtp.auth",
                "true");

        props.put("mail.smtp.starttls.enable",
                "true");

        props.put("mail.smtp.host",
                "smtp-relay.brevo.com");

        props.put("mail.smtp.port",
                "587");

        props.put("mail.smtp.ssl.protocols",
                "TLSv1.2");

        // TIMEOUTS

        props.put("mail.smtp.connectiontimeout",
                "10000");

        props.put("mail.smtp.timeout",
                "10000");

        Session session = Session.getInstance(
            props,

            new Authenticator() {

                protected PasswordAuthentication
                getPasswordAuthentication() {

                    return new PasswordAuthentication(
                        from,
                        password
                    );
                }
            }
        );

        try {

            Message msg = new MimeMessage(session);

            msg.setFrom(
                new InternetAddress(
                    from,
                    "Devs Institute ERP"
                )
            );

            msg.setRecipients(
                Message.RecipientType.TO,

                InternetAddress.parse(to)
            );

            msg.setSubject(
                "Your College ERP Login OTP"
            );

            msg.setContent(

                "<h2>College ERP Login</h2>" +

                "<p>Your OTP is:</p>" +

                "<h1 style='color:blue;'>" +

                otp +

                "</h1>" +

                "<p>This OTP is valid for 5 minutes.</p>",

                "text/html"
            );

            Transport.send(msg);

            System.out.println(
                "OTP MAIL SENT TO: " + to
            );

            return true;

        } catch (Exception e) {

            System.out.println(
                "MAIL FAILED FOR: " + to
            );

            e.printStackTrace();

            return false;
        }
    }
}
