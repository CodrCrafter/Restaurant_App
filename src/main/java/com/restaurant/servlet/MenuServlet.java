package com.restaurant.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.restaurant.db.DBConnection;
import com.restaurant.model.Menu;

@WebServlet("/restaurantMenu")
public class MenuServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String rid = request.getParameter("rid");

        if (rid == null || rid.trim().isEmpty()) {
            response.getWriter().println("Invalid restaurant ID");
            return;
        }

        int restaurantId = Integer.parseInt(rid);

        try {
            Connection conn = DBConnection.getConnection();

            String query = "SELECT * FROM menu WHERE restaurant_id = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, restaurantId);

            ResultSet rs = ps.executeQuery();

            List<Menu> menuList = new ArrayList<>();

            while (rs.next()) {
                Menu menu = new Menu();
                menu.setId(rs.getInt("id"));
                menu.setRestaurantId(rs.getInt("restaurant_id"));
                menu.setItemName(rs.getString("item_name"));
                menu.setPrice(rs.getDouble("price"));
                menu.setImageUrl(rs.getString("image_url"));
                menuList.add(menu);
            }

            request.setAttribute("restaurantId", restaurantId);
            request.setAttribute("menuList", menuList);

            request.getRequestDispatcher("menu.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("ERROR: " + e.getMessage());
        }
    }
}
