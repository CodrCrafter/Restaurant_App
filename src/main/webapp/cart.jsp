<%@ page import="com.restaurant.model.Cart, com.restaurant.model.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    Cart cart = (Cart) session.getAttribute("cart");

    Integer restaurantId = null;
    if (cart != null && !cart.getItems().isEmpty()) {
        restaurantId = cart.getItems().get(0).getRestaurantId();
    } else {
        Object ridObj = session.getAttribute("restaurantId");
        if (ridObj != null) {
            try { restaurantId = Integer.parseInt(ridObj.toString()); } catch (Exception ignored) {}
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Cart 🛒</title>
<style>
    /* Reset and Basic Setup */
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f4f9;
        color: #333;
        margin: 0;
        padding: 20px;
    }

    .container {
        max-width: 900px;
        margin: 0 auto;
        padding: 30px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    h2 {
        text-align: center;
        color: #e74c3c; /* Primary brand color */
        margin-bottom: 30px;
        font-size: 2em;
    }

    /* Table Styling */
    table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        margin-bottom: 30px;
        overflow: hidden; /* To keep border-radius on table */
        border: 1px solid #ddd;
        border-radius: 8px;
    }

    th, td {
        padding: 15px;
        text-align: left;
    }

    th {
        background-color: #e74c3c;
        color: white;
        text-transform: uppercase;
        font-size: 0.9em;
        letter-spacing: 0.5px;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    tr:hover:not(:first-child) {
        background-color: #f0f0f0;
    }
    
    td {
        border-bottom: 1px solid #eee;
        vertical-align: middle;
    }
    
    tr:last-child td {
        border-bottom: none;
    }

    /* Quantity and Action Buttons */
    .qty-btn, .remove-btn {
        padding: 5px 10px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-weight: bold;
        transition: background-color 0.2s;
        font-size: 1em;
        line-height: 1; /* Aligns text better */
    }

    .qty-btn {
        background-color: #3498db; /* Blue for quantity */
        color: white;
        margin: 0 5px;
    }

    .qty-btn:hover {
        background-color: #2980b9;
    }
    
    td > form {
        display: inline-block !important; /* Override inline style in JSP */
    }

    .remove-btn {
        background-color: #f1c40f; /* Yellow for remove */
        color: #333;
        margin-left: 10px;
        padding: 8px 15px;
    }

    .remove-btn:hover {
        background-color: #f39c12;
    }

    /* Total and Footer */
    .total {
        font-size: 1.8em;
        font-weight: bold;
        text-align: right;
        margin-top: 20px;
        padding: 15px;
        border-top: 2px solid #ddd;
        color: #e74c3c;
    }
    
    /* Call to Action Buttons */
    .add-more-btn, .checkout-btn {
        display: inline-block;
        padding: 12px 25px;
        margin-top: 20px;
        text-decoration: none;
        border-radius: 5px;
        font-weight: bold;
        transition: transform 0.2s, box-shadow 0.2s;
        text-align: center;
    }

    .add-more-btn {
        background-color: #34495e; /* Darker color for secondary action */
        color: white;
        margin-right: 15px;
    }
    
    .checkout-btn {
        background-color: #2ecc71; /* Green for primary action */
        color: white;
    }

    .add-more-btn:hover, .checkout-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }
    
    /* Empty Cart Message */
    .empty {
        text-align: center;
        padding: 50px;
        font-size: 1.5em;
        color: #7f8c8d;
        border: 2px dashed #bdc3c7;
        border-radius: 8px;
        margin-bottom: 30px;
    }
</style>
</head>
<body>
<div class="container">
<h2>Your Cart 🛒</h2>

<%
if (cart == null || cart.getItems().isEmpty()) {
%>
<div class="empty">Your cart is empty. Time to add some delicious food! 😋</div>
<%
} else {
    double total = 0;
    // Note: The loop below correctly calculates total without displaying items yet.
    for (CartItem item : cart.getItems()) total += item.getPrice() * item.getQuantity();
%>
<table>
<thead>
    <tr>
        <th>Name</th>
        <th>Restaurant ID</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Action</th>
    </tr>
</thead>
<tbody>
<%
for (CartItem item : cart.getItems()) {
%>
<tr>
    <td><%= item.getName() %></td>
    <td><%= item.getRestaurantId() %></td>
    <td>₹ <%= String.format("%.2f", item.getPrice()) %></td>
    <td>
        <form action="updateQuantity" method="post" class="quantity-form">
            <input type="hidden" name="id" value="<%= item.getId() %>">
            <input type="hidden" name="action" value="dec">
            <button class="qty-btn" type="submit">−</button>
        </form>

        <span><%= item.getQuantity() %></span>

        <form action="updateQuantity" method="post" class="quantity-form">
            <input type="hidden" name="id" value="<%= item.getId() %>">
            <input type="hidden" name="action" value="inc">
            <button class="qty-btn" type="submit">+</button>
        </form>
    </td>
   <td>
        <form action="removeCart" method="post" class="remove-form"> 
            <input type="hidden" name="id" value="<%= item.getId() %>">
            <button class="remove-btn" type="submit">Remove</button>
        </form>
    </td>
</tr>
<% } %>
</tbody>
</table>

<div class="total">Total: ₹ <%= String.format("%.2f", total) %></div>

<div style="text-align: right; padding-top: 10px;">
    <% if (restaurantId != null) { %>
    <a href="restaurantMenu?rid=<%= restaurantId %>" class="add-more-btn">Add More Items</a>
    <% } else { %>
    <a href="restaurants.jsp" class="add-more-btn">Add More Items</a>
    <% } %>

    <a href="checkout.jsp" class="checkout-btn">Proceed to Checkout</a>
</div>
<% } %>
</div>
</body>
</html>