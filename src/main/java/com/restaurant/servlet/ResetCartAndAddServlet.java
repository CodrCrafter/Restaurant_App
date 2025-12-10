package com.restaurant.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.restaurant.model.Cart;
import com.restaurant.model.CartItem;

@WebServlet("/resetCartAndAdd")
public class ResetCartAndAddServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart == null) cart = new Cart();

        // ⭐ Item stored temporarily before user confirmed reset
        CartItem pending = (CartItem) session.getAttribute("pendingItem");

        if (pending != null) {
            cart.clearCart();           // Clear old restaurant items
            cart.addItem(pending);      // Add new restaurant item
            session.removeAttribute("pendingItem");
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("cart.jsp");
    }
}
