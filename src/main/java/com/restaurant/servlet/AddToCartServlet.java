package com.restaurant.servlet;

import com.restaurant.model.Cart;
import com.restaurant.model.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {

@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    // Get parameters safely
    String idStr = request.getParameter("id");
    String name = request.getParameter("name");
    String priceStr = request.getParameter("price");
    String ridStr = request.getParameter("restaurantId");

    // Validate parameters
    if (idStr == null || idStr.isEmpty() ||
        name == null || name.isEmpty() ||
        priceStr == null || priceStr.isEmpty() ||
        ridStr == null || ridStr.isEmpty()) {

        response.sendRedirect("menu.jsp?error=missing_parameters");
        return;
    }

    // Parse numeric values
    int itemId = Integer.parseInt(idStr);
    double price = Double.parseDouble(priceStr);
    int restaurantId = Integer.parseInt(ridStr);

    HttpSession session = request.getSession();
    Cart cart = (Cart) session.getAttribute("cart");

    if (cart == null) {
        cart = new Cart();
    }

    Integer existingRestaurantId = cart.getRestaurantId();

    // If cart contains items from another restaurant → ask confirmation
    if (existingRestaurantId != null && !existingRestaurantId.equals(restaurantId)) {
        session.setAttribute("pendingItem", new CartItem(itemId, name, restaurantId, price, 1));
        response.sendRedirect("confirmReset.jsp");
        return;
    }

    // Add item to cart
    cart.addItem(new CartItem(itemId, name, restaurantId, price, 1));
    session.setAttribute("cart", cart);

    response.sendRedirect("cart.jsp");
}


}

