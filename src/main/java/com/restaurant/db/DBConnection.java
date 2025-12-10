package com.restaurant.db;


import java.sql.Connection;
import java.sql.DriverManager;


public class DBConnection {
private static Connection con = null;


public static Connection getConnection() {
try {
if (con == null || con.isClosed()) {
Class.forName("com.mysql.cj.jdbc.Driver");
String url = "jdbc:mysql://localhost:3306/restaurantdb?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
String user = "username"; // change
String pass = "password"; // change
con = DriverManager.getConnection(url, user, pass);
}
} catch (Exception e) {
e.printStackTrace();
}
return con;
}
}