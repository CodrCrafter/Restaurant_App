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
    body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; margin:0; padding:40px; }
    .box {
        width: 600px; margin: auto; background: #fff; padding: 35px;
        border-radius: 15px; box-shadow: 0 5px 18px rgba(0,0,0,0.12);
    }
    h2 {
        text-align:center; color:#2ecc71; margin-bottom:25px;
        font-size: 26px; font-weight: bold;
    }
    .item {
        border-bottom:1px solid #eee; padding:12px 0;
        display:flex; justify-content:space-between;
        font-size: 17px;
    }
    .total {
        font-size: 22px; font-weight:bold; margin-top:25px;
        text-align:right; color:#e74c3c;
    }
    .payment-box {
        margin-top: 30px;
        padding: 20px;
        border-radius: 12px;
        background: #f9f9fb;
        border: 1px solid #ddd;
    }
    .payment-title {
        font-size: 20px;
        margin-bottom: 15px;
        font-weight: 600;
    }
    .radio-option {
        margin: 10px 0;
        font-size: 17px;
    }
    .place-btn {
        display:block; width:100%; margin-top:30px;
        padding:14px; background:#2ecc71; color:white;
        border:none; cursor:pointer;
        font-size:1.2rem; font-weight:bold; border-radius:8px;
    }
    .place-btn:hover { background:#27ae60; }
    .email-input {
        width: 100%; padding: 10px; margin-bottom: 15px;
        font-size: 16px; border-radius:6px; border:1px solid #ccc;
    }
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

    <!-- Payment Options -->
    <div class="payment-box">
        <div class="payment-title">Enter Email & Choose Payment Method</div>

        <form action="placeOrder" method="post">

            <input type="email" name="email" class="email-input" placeholder="Enter your email for order confirmation" required>

            <div class="radio-option">
                <input type="radio" name="paymentMethod" value="cod" checked>
                Cash on Delivery
            </div>

            <div class="radio-option">
                <input type="radio" name="paymentMethod" value="online">
                Online Payment
            </div>

            <button class="place-btn" type="submit">Place Order</button>
        </form>
    </div>

</div>

</body>
</html>
