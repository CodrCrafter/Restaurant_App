package com.restaurant.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.restaurant.dao.impl.UserDaoImpl;

@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("email");
        String newPass = req.getParameter("newpass");

        UserDaoImpl dao = new UserDaoImpl();
        boolean updated = dao.updatePassword(email, newPass);

        if (updated) {
            resp.sendRedirect("login.jsp");
        } else {
            resp.getWriter().println("Password update failed.");
        }
    }
}
