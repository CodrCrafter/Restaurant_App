<%@ page import="java.util.List, com.restaurant.model.CartItem" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    List<CartItem> orderItems = (List<CartItem>) session.getAttribute("orderItems");
    Double orderTotal = (Double) session.getAttribute("orderTotal");

    if (orderItems == null || orderItems.isEmpty()) {
        response.sendRedirect("home.jsp"); // If someone reloads success page
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>Order Placed Successfully</title>
<style>
    body { font-family: Arial; background: #f4f4f8; margin:0; padding:40px; }
    .box {
        width: 600px; margin: auto; background: #fff; padding: 30px;
        border-radius: 10px; box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        text-align:center;
    }
    h2 { color:#27ae60; margin-bottom:20px; }
    .item { border-bottom:1px solid #ddd; padding:10px 0; display:flex; justify-content:space-between; }
    .total { font-size: 1.5rem; font-weight:bold; margin-top:20px; color:#e74c3c; }
    .home-btn {
        display:inline-block; margin-top:25px; padding:12px 25px;
        background:#3498db; color:white; text-decoration:none; font-weight:bold; border-radius:6px;
    }
    .home-btn:hover { background:#2980b9; }
</style>
</head>
<body>

<div class="box">
    <h2>Thank you! Your order has been placed ✅</h2>

    <% for (CartItem item : orderItems) { %>
    <div class="item">
        <span><%= item.getName() %> (x<%= item.getQuantity() %>)</span>
        <span>₹ <%= String.format("%.2f", item.getPrice() * item.getQuantity()) %></span>
    </div>
    <% } %>

    <div class="total">Total: ₹ <%= String.format("%.2f", orderTotal) %></div>

    <a href="home.jsp" class="home-btn">Back to Restaurants</a>
</div>

<%
    // Remove order summary from session after displaying
    session.removeAttribute("orderItems");
    session.removeAttribute("orderTotal");
%>

</body>
</html>
