package com.restaurant.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.restaurant.dao.RestaurantDao;
import com.restaurant.db.DBConnection;
import com.restaurant.model.Restaurant;

public class RestaurantDaoImpl implements RestaurantDao {

    private Connection conn;

    public RestaurantDaoImpl() {
        conn = DBConnection.getConnection();
    }

    @Override
    public boolean addRestaurant(Restaurant r) {
        try {
            String query = "INSERT INTO restaurants(name, address, rating, image_url) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, r.getName());
            ps.setString(2, r.getAddress());
            ps.setFloat(3, r.getRating());
            ps.setString(4, r.getImageUrl());

            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> list = new ArrayList<>();
        try {
            String query = "SELECT id, name, address, rating, image_url FROM restaurants";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Restaurant r = new Restaurant();
                r.setId(rs.getInt("id"));
                r.setName(rs.getString("name"));
                r.setAddress(rs.getString("address"));
                r.setRating(rs.getFloat("rating"));
                r.setImageUrl(rs.getString("image_url"));
                list.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
