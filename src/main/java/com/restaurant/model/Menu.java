package com.restaurant.model;

public class Menu {
    
    private int id;
    private int restaurantId;
    private String itemName;
    private double price;
    private String imageUrl;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getItemName() { return itemName; }
    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public double getPrice() { return price; }
    public void setPrice(double price) {
        this.price = price;
    }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
