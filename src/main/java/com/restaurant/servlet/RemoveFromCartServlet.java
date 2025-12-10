package com.restaurant.servlet;

import com.restaurant.model.Cart;
import com.restaurant.model.CartItem;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/removeCart")
public class RemoveFromCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // 1. **CRITICAL FIX:** Get the unique item ID, which is named "id" in cart.jsp
        String idParam = request.getParameter("id"); 

        if (idParam != null && !idParam.isEmpty()) {
            try {
                // Convert the item ID to an integer
                int itemIdToRemove = Integer.parseInt(idParam); 

                // Get cart from session
                HttpSession session = request.getSession();
                Cart cart = (Cart) session.getAttribute("cart");
                
                if (cart != null && cart.getItems() != null) {
                    
                    // 2. Safely remove the item by its unique ID
                    // Using Java 8's removeIf, which requires access to the cart's List<CartItem>
                    List<CartItem> items = cart.getItems();

                    // Remove the item where item.getId() matches the itemIdToRemove
                    boolean removed = items.removeIf(item -> item.getId() == itemIdToRemove);
                    
                    if (removed) {
                        System.out.println("Removed item ID: " + itemIdToRemove);
                    } else {
                        System.out.println("Item ID not found: " + itemIdToRemove);
                    }

                    // 3. Optional: If the cart is now empty, remove the restaurant ID lock
                    if (cart.getItems().isEmpty()) {
                        session.removeAttribute("restaurantId");
                    }
                }

            } catch (NumberFormatException e) {
                // Log the error if the provided ID is not a number
                System.err.println("Invalid item ID format received: " + idParam);
                e.printStackTrace();
            }
        }

        // 4. Redirect back to cart page to display the updated cart
        response.sendRedirect("cart.jsp");
    }
}