<%@ page import="com.restaurant.model.Cart, com.restaurant.model.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null || cart.getItems().isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }
    double total = cart.getTotal();
%>

<!DOCTYPE html>
<html>
<head>
<title>Checkout</title>
<style>
    body { font-family: Arial; background: #f4f4f8; margin:0; padding:40px; }
    .box {
        width: 600px; margin: auto; background: #fff; padding: 30px;
        border-radius: 10px; box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    }
    h2 { text-align:center; color:#27ae60; margin-bottom:20px; }
    .item { border-bottom:1px solid #ddd; padding:10px 0; display:flex; justify-content:space-between; }
    .total { font-size: 1.5rem; font-weight:bold; margin-top:20px; text-align:right; color:#e74c3c; }
    .place-btn {
        display:block; width:100%; margin-top:25px;
        padding:12px; background:#2ecc71; color:white;
        text-align:center; text-decoration:none;
        font-size:1.2rem; font-weight:bold; border-radius:6px;
    }
    .place-btn:hover { background:#27ae60; }
</style>
</head>
<body>

<div class="box">
    <h2>Order Summary</h2>

    <% for (CartItem item : cart.getItems()) { %>
    <div class="item">
        <span><%= item.getName() %> (x<%= item.getQuantity() %>)</span>
        <span>₹ <%= String.format("%.2f", item.getPrice() * item.getQuantity()) %></span>
    </div>
    <% } %>

    <div class="total">Total: ₹ <%= String.format("%.2f", total) %></div>

    <form action="placeOrder" method="post">
        <button class="place-btn" type="submit">Place Order</button>
    </form>
</div>

</body>
</html>
