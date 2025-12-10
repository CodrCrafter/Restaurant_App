package com.restaurant.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.restaurant.db.DBConnection;
import com.restaurant.model.User;

public class UserDaoImpl {
    private Connection conn;

    public UserDaoImpl() {
        conn = DBConnection.getConnection();
    }

    // Register user
    public boolean registerUser(User user) {
        try {
            String sql = "INSERT INTO users(username, email, password) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean updatePassword(String email, String newPass) {
        boolean f = false;

        try {
            Connection con = DBConnection.getConnection();
            String sql = "UPDATE users SET password=? WHERE email=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, newPass);
            ps.setString(2, email);

            int i = ps.executeUpdate();
            if (i > 0) f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }
    
 // Check if username already exists
    public boolean usernameExists(String username) {
        try {
            String sql = "SELECT * FROM users WHERE username=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }



    // Validate login
    public User validateUser(String username, String password) {
        try {
            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
