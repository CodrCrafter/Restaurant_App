<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.restaurant.model.CartItem" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirm Cart Reset</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            padding: 40px;
        }

        .box {
            width: 420px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
            text-align: center;
        }

        .btn {
            padding: 10px 20px;
            border-radius: 5px;
            margin: 10px;
            cursor: pointer;
            border: none;
            font-size: 15px;
        }

        .cancel-btn {
            background: #888;
            color: white;
        }

        .reset-btn {
            background: #ff4d4d;
            color: white;
        }
    </style>
</head>

<body>

<%
    CartItem pendingItem = (CartItem) session.getAttribute("pendingItem");
    if (pendingItem == null) {
%>
        <p style="color:red;">No item to add. Something went wrong.</p>
<%
        return;
    }
%>

<div class="box">
    <h2>Replace items in your cart?</h2>
    <p>Your cart contains items from another restaurant.</p>

    <p><b>New Item:</b> <%= pendingItem.getName() %></p>
    <p><b>Restaurant ID:</b> <%= pendingItem.getRestaurantId() %></p>

    <form action="cart.jsp">
        <button class="btn cancel-btn">Keep Old Items</button>
    </form>

    <form action="resetCartAndAdd" method="post">
        <input type="hidden" name="name" value="<%= pendingItem.getName() %>">
        <input type="hidden" name="price" value="<%= pendingItem.getPrice() %>">
        <input type="hidden" name="restaurantId" value="<%= pendingItem.getRestaurantId() %>">
        <button type="submit" class="btn reset-btn">
            Clear Cart & Add New Item
        </button>
    </form>
</div>

</body>
</html>
