package com.restaurant.menu;

import java.sql.*;
import java.util.*;
import com.restaurant.db.DBConnection;
  // your DB connection class

public class MenuDAO {

    private Connection con;

    public MenuDAO() {
        con = DBConnection.getConnection();
    }

    // Fetch menu items by restaurant ID
    public List<MenuItem> getMenuByRestaurant(int rid) {

        List<MenuItem> list = new ArrayList<>();

        try {
            String sql = "SELECT * FROM menu WHERE restaurant_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, rid);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                MenuItem m = new MenuItem(
                    rs.getInt("id"),
                    rs.getInt("restaurant_id"),
                    rs.getString("item_name"),
                    rs.getDouble("price"),
                    rs.getString("image_url")
                );

                list.add(m);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
