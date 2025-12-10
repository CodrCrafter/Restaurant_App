package com.restaurant.test;

import java.sql.Connection;
import com.restaurant.db.DBConnection;

public class TestDB {
    public static void main(String[] args) {
        Connection con = DBConnection.getConnection();
        if(con != null) {
            System.out.println("DB Connected Successfully!");
        } else {
            System.out.println("DB Connection Failed!");
        }
    }
}
