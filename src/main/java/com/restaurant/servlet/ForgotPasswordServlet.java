package com.restaurant.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.restaurant.dao.UserDAO;
import com.restaurant.model.User;
import com.restaurant.util.EmailUtil;

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("forgot_password_form.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email cannot be empty.");
            request.getRequestDispatcher("forgot_password_form.jsp")
                   .forward(request, response);
            return;
        }

        User user = UserDAO.getUserByEmail(email);

        if (user != null) {

            // Generate OTP
            int otp = (int) (Math.random() * 900000) + 100000;

            // Save OTP in session
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("otpEmail", email);

            // Send Email
            EmailUtil.sendEmail(email, "OTP Verification", "Your OTP is: " + otp);

            // Forward (NO LEADING SLASH)
            request.getRequestDispatcher("verifyOtp.jsp")
                   .forward(request, response);
        } else {
            request.setAttribute("error", "Email not found!");
            request.getRequestDispatcher("forgot_password_form.jsp")
                   .forward(request, response);
        }
    }
}
