package com.collegeerp.util;

import java.util.Random;

public class OtpGenerator {

    public static String generateOtp() {
        Random r = new Random();
        int otp = 100000 + r.nextInt(900000); // 6 digit
        return String.valueOf(otp);
    }
}
