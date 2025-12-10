<%@ page import="java.util.*, com.restaurant.model.Menu" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Menu Items</title>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');

    /* ===== Background ===== */
    body {
        margin: 0;
        padding: 0;
        font-family: "Poppins", sans-serif;
        background: linear-gradient(135deg,#0f0f0f,#1a1a1a,#2a2a2a);
        min-height: 100vh;
    }

    /* ===== Header ===== */
    .header {
        text-align: center;
        padding: 25px 0;
        font-size: 32px;
        font-weight: 600;
        letter-spacing: 1px;

        background: linear-gradient(45deg,#ffae00,#ff0099);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;

        animation: glow 2s infinite alternate;
    }

    /* ===== Container ===== */
    .container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        padding: 20px;
    }

    /* ===== Card Design (Glass) ===== */
    .card {
        width: 260px;
        background: rgba(255, 255, 255, 0.08);
        backdrop-filter: blur(12px);
        padding: 18px;
        border-radius: 18px;
        margin: 18px;
        border: 1px solid rgba(255, 255, 255, 0.2);
        box-shadow: 0 8px 25px rgba(0,0,0,0.4);
        text-align: center;
        transition: 0.35s ease;
    }

    .card:hover {
        transform: scale(1.03);
        box-shadow: 0 12px 30px rgba(255, 0, 153, 0.35);
    }

    /* ===== Image ===== */
    .card-img {
        height: 160px;
        overflow: hidden;
        border-radius: 14px;
        margin-bottom: 12px;
    }

    .card-img img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    /* ===== Food Name ===== */
    h3 {
        margin: 10px 0 5px;
        font-size: 20px;
        color: #fff;
        font-weight: 500;
    }

    /* ===== Price ===== */
    .price {
        font-size: 18px;
        color: #00ff88;
        font-weight: bold;
        margin-bottom: 12px;
        text-shadow: 0 0 8px rgba(0,255,153,0.4);
    }

    /* ===== Add to Cart Button (Login Theme) ===== */
    .add-btn {
        width: 100%;
        padding: 12px;
        background: linear-gradient(90deg,#7b2ff7,#f107a3);
        color: white;
        border: none;
        border-radius: 12px;
        cursor: pointer;
        font-size: 16px;
        font-weight: 500;
        transition: 0.3s ease;
    }

    .add-btn:hover {
        background: linear-gradient(90deg,#f107a3,#7b2ff7);
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(123,47,247,0.4);
    }

    /* ===== Empty Message ===== */
    .empty {
        color: #fff;
        text-align: center;
        margin-top: 40px;
        font-size: 24px;
        opacity: 0.8;
    }

    /* ===== Animations ===== */
    @keyframes glow {
        from { text-shadow: 0 0 5px #ff0099; }
        to   { text-shadow: 0 0 18px #ffae00; }
    }

</style>

</head>
<body>

<div class="header">Menu Items</div>

<div class="container">

<%
    List<Menu> list = (List<Menu>) request.getAttribute("menuList");
    Integer restaurantId = (Integer) request.getAttribute("restaurantId");

    if (list == null || list.isEmpty()) {
%>

        <div class="empty">No Menu Items Available 😔</div>

<%
    } else {
        for (Menu m : list) {
%>

    <div class="card">

        <div class="card-img">
            <img src="<%= m.getImageUrl() %>"
                 onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'" />
        </div>

        <h3><%= m.getItemName() %></h3>
        <p class="price">₹ <%= m.getPrice() %></p>

        <!-- Add to Cart -->
        <form action="addToCart" method="post">
            <input type="hidden" name="id" value="<%= m.getId() %>">
            <input type="hidden" name="name" value="<%= m.getItemName() %>">
            <input type="hidden" name="price" value="<%= m.getPrice() %>">
            <input type="hidden" name="restaurantId" value="<%= m.getRestaurantId() %>">

            <button type="submit" class="add-btn">Add to Cart</button>
        </form>

    </div>

<%
        }
    }
%>

</div>

</body>
</html>
