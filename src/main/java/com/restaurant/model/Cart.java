package com.restaurant.model;
import java.util.*;

public class Cart {

    private List<CartItem> items = new ArrayList<>();
    private Integer restaurantId = null;

    public List<CartItem> getItems() { return items; }
    public Integer getRestaurantId() { return restaurantId; }
    public void setRestaurantId(Integer restaurantId) { this.restaurantId = restaurantId; }

    public void clearCart() {
        items.clear();
        restaurantId = null;
    }

    public void addItem(CartItem newItem) {
        if (restaurantId == null) restaurantId = newItem.getRestaurantId();

        for (CartItem item : items) {
            if (item.getId() == newItem.getId()) {
                item.setQuantity(item.getQuantity() + 1);
                return;
            }
        }

        items.add(newItem);
    }

    public void removeItem(int itemId) {
        items.removeIf(item -> item.getId() == itemId);
        if (items.isEmpty()) restaurantId = null;
    }

    public double getTotal() {
        double total = 0;
        for (CartItem item : items) total += item.getPrice() * item.getQuantity();
        return total;
    }

    public void increaseQuantity(int itemId) {
        for (CartItem item : items) {
            if (item.getId() == itemId) {
                item.setQuantity(item.getQuantity() + 1);
                break;
            }
        }
    }

    public void decreaseQuantity(int itemId) {
        for (CartItem item : items) {
            if (item.getId() == itemId && item.getQuantity() > 1) {
                item.setQuantity(item.getQuantity() - 1);
                break;
            }
        }
    }
}
