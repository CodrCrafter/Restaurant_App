package com.restaurant.servlet;

import java.io.IOException;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/sendOtp")
public class SendOtpServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");

        int otp = (int) (Math.random() * 900000) + 100000;

        HttpSession session = req.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("email", email);

        String host = "smtp.gmail.com";
        String from = "your mail";
        String pass = "yourpassword123";

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, pass);
            }
        });

        try {
            MimeMessage message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("Your OTP Code - Password Reset");
            message.setText("Your OTP is: " + otp);

            Transport.send(message);

            resp.sendRedirect("verifyOtp.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Error sending OTP. Check logs.");
        }
    }
}
