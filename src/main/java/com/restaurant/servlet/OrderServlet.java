package com.restaurant.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.restaurant.model.Cart;
import com.restaurant.model.CartItem;

import java.util.ArrayList;
import java.util.List;

@WebServlet("/placeOrder")
public class OrderServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    HttpSession session = request.getSession();
	    Cart cart = (Cart) session.getAttribute("cart");

	    if (cart == null || cart.getItems().isEmpty()) {
	        response.sendRedirect("cart.jsp");
	        return;
	    }

	    // ------------------ FIX IS HERE ------------------
	    List<CartItem> orderItems = new ArrayList<>(cart.getItems()); // COPY the list
	    double orderTotal = cart.getTotal();

	    session.setAttribute("orderItems", orderItems);
	    session.setAttribute("orderTotal", orderTotal);

	    // Clear cart safely
	    cart.clearCart();
	    // --------------------------------------------------

	    response.sendRedirect("order_success.jsp");
	}
}
