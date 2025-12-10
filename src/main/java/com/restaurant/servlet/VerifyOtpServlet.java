package com.restaurant.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/verifyOtp")
public class VerifyOtpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("otp") == null) {
            resp.getWriter().println("<h3>Session expired. Try again.</h3>");
            return;
        }

        int storedOtp = (int) session.getAttribute("otp");

        int enteredOtp = Integer.parseInt(req.getParameter("otp"));

        if (enteredOtp == storedOtp) {
            resp.sendRedirect("resetPassword.jsp");
        } else {
            resp.getWriter().println("<h3>Invalid OTP. Try Again.</h3>");
        }
    }
}
