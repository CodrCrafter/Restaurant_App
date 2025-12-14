<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    // Check if user is logged in
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Get order details from session
    String email = (String) session.getAttribute("orderEmail");
    String paymentMethod = (String) session.getAttribute("paymentMethod");
    String orderId = (String) session.getAttribute("orderId");   // ✅ FIXED
    java.util.Date orderTime = (java.util.Date) session.getAttribute("orderTime");

    // Format order time
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
    String formattedTime = orderTime != null ? sdf.format(orderTime) : "Just now";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed! | Foodie Delight</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        :root {
            --primary: #FF6B35;
            --primary-dark: #E55A2B;
            --secondary: #00C2A2;
            --dark: #1A1A2E;
            --light: #F8F9FA;
            --gray: #6C757D;
            --success: #27ae60;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light);
            color: var(--dark);
            text-align: center;
        }

        .container {
            max-width: 800px;
            margin: auto;
            padding: 40px 20px;
        }

        .success-card {
            background: white;
            border-radius: 20px;
            padding: 50px 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .success-icon {
            width: 100px;
            height: 100px;
            background: var(--success);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 30px;
            font-size: 50px;
        }

        h1 {
            color: var(--success);
            margin-bottom: 20px;
        }

        .subtitle {
            color: var(--gray);
            margin-bottom: 30px;
        }

        .order-id {
            font-size: 26px;
            font-weight: bold;
            color: var(--primary);
            margin-bottom: 25px;
        }

        .order-details {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 25px;
            text-align: left;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            font-weight: bold;
        }

        .detail-value {
            color: var(--primary);
        }

        .delivery-info {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            border-radius: 15px;
            padding: 25px;
            margin: 30px 0;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }

        .action-btn {
            padding: 14px 30px;
            border-radius: 30px;
            text-decoration: none;
            color: white;
            font-weight: bold;
        }

        .home-btn {
            background: var(--secondary);
        }

        .orders-btn {
            background: var(--primary);
        }

        .email-note {
            margin-top: 25px;
            color: var(--gray);
            font-size: 14px;
        }
    </style>
</head>

<body>
<div class="container">
    <div class="success-card">

        <div class="success-icon">
            <i class="fas fa-check"></i>
        </div>

        <h1>Order Confirmed! 🎉</h1>
        <p class="subtitle">Thank you for your order. We are preparing your food!</p>

        <div class="order-id">Order #<%= orderId %></div>

        <div class="order-details">
            <div class="detail-row">
                <span class="detail-label">Order Date & Time</span>
                <span class="detail-value"><%= formattedTime %></span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Email</span>
                <span class="detail-value"><%= email %></span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Payment Method</span>
                <span class="detail-value">
                    <%= "cod".equals(paymentMethod) ? "Cash on Delivery" :
                       "online".equals(paymentMethod) ? "Online Payment" : paymentMethod %>
                </span>
            </div>

            <div class="detail-row">
                <span class="detail-label">Status</span>
                <span class="detail-value" style="color: var(--success);">Confirmed</span>
            </div>
        </div>

        <div class="delivery-info">
            <h2>🚴 Delivery in 30–40 minutes</h2>
        </div>

        <div class="action-buttons">
            <a href="home" class="action-btn home-btn">
                <i class="fas fa-home"></i> Home
            </a>

            <a href="MyOrders.jsp" class="action-btn orders-btn">
                <i class="fas fa-list"></i> My Orders
            </a>
        </div>

        <div class="email-note">
            📧 Confirmation sent to <b><%= email %></b>
        </div>

    </div>
</div>
</body>
</html>
