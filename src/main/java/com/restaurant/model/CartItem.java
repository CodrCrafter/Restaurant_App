package com.restaurant.model;

public class CartItem {

    private int id;                // menu item ID
    private String name;
    private int restaurantId;
    private double price;
    private int quantity;

    public CartItem(int id, String name, int restaurantId, double price, int quantity) {
        this.id = id;
        this.name = name;
        this.restaurantId = restaurantId;
        this.price = price;
        this.quantity = quantity;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public int getRestaurantId() { return restaurantId; }
    public double getPrice() { return price; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
}
