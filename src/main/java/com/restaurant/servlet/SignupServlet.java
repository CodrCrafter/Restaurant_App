package com.restaurant.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.restaurant.dao.impl.UserDaoImpl;
import com.restaurant.model.User;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDaoImpl dao = new UserDaoImpl();

        // 🔥 CHECK IF USERNAME EXISTS
        if (dao.usernameExists(username)) {
            request.setAttribute("errorMsg", "Username already taken. Try another!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);

        boolean success = dao.registerUser(user);

        if (success) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("errorMsg", "Signup failed. Try again!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}
