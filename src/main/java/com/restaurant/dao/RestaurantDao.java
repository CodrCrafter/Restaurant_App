package com.restaurant.dao;

import java.util.List;
import com.restaurant.model.Restaurant;

public interface RestaurantDao {

    boolean addRestaurant(Restaurant restaurant);

    List<Restaurant> getAllRestaurants();
}
