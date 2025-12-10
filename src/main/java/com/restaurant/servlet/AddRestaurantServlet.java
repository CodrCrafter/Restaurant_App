package com.restaurant.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.restaurant.dao.impl.RestaurantDaoImpl;
import com.restaurant.model.Restaurant;

public class AddRestaurantServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String address = req.getParameter("address");
        float rating = Float.parseFloat(req.getParameter("rating"));
        String imageUrl = req.getParameter("image");

        Restaurant r = new Restaurant(name, address, rating, imageUrl);

        RestaurantDaoImpl dao = new RestaurantDaoImpl();

        boolean added = dao.addRestaurant(r);

        if (added) {
            resp.sendRedirect("home.jsp");
        } else {
            resp.getWriter().println("Error adding restaurant");
        }
    }
}
