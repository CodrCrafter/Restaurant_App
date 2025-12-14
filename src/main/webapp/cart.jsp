<%@ page import="com.restaurant.model.Cart, com.restaurant.model.CartItem, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    Cart cart = (Cart) session.getAttribute("cart");
    Integer restaurantId = null;
    if (cart != null && !cart.getItems().isEmpty()) {
        restaurantId = cart.getRestaurantId();
    } else {
        Object ridObj = session.getAttribute("restaurantId");
        if (ridObj != null) {
            try { restaurantId = Integer.parseInt(ridObj.toString()); } catch (Exception ignored) {}
        }
    }
    
    // Get cart count
    Integer cartCount = (Integer) session.getAttribute("cartCount");
    if (cartCount == null) {
        cartCount = 0;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart 🛒 | Foodie Delight</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #FF6B35;
            --primary-dark: #E55A2B;
            --secondary: #00C2A2;
            --dark: #1A1A2E;
            --light: #F8F9FA;
            --gray: #6C757D;
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
            line-height: 1.6;
        }
        
        /* Header */
        .header {
            background: linear-gradient(90deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 20px 5%;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 24px;
            font-weight: 700;
            text-decoration: none;
            color: white;
        }
        
        .logo i {
            color: var(--secondary);
        }
        
        .back-btn {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 50px;
            cursor: pointer;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }
        
        .back-btn:hover {
            background: rgba(255, 255, 255, 0.3);
        }
        
        /* Container */
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .cart-title {
            font-size: 32px;
            margin-bottom: 30px;
            color: var(--dark);
            text-align: center;
        }
        
        /* Cart Items */
        .cart-items {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            overflow: hidden;
            margin-bottom: 30px;
        }
        
        .cart-header {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr 1fr;
            background: var(--primary);
            color: white;
            padding: 15px 20px;
            font-weight: 600;
        }
        
        .cart-item {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr 1fr;
            padding: 20px;
            border-bottom: 1px solid #eee;
            align-items: center;
        }
        
        .cart-item:last-child {
            border-bottom: none;
        }
        
        .item-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .item-image {
            width: 80px;
            height: 80px;
            border-radius: 10px;
            overflow: hidden;
        }
        
        .item-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .item-name {
            font-weight: 600;
            font-size: 16px;
        }
        
        .item-price {
            font-weight: 700;
            color: var(--primary);
        }
        
        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .qty-btn {
            width: 35px;
            height: 35px;
            border-radius: 50%;
            border: 2px solid var(--primary);
            background: white;
            color: var(--primary);
            font-weight: bold;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s;
        }
        
        .qty-btn:hover {
            background: var(--primary);
            color: white;
        }
        
        .quantity {
            font-weight: 600;
            min-width: 30px;
            text-align: center;
        }
        
        .remove-btn {
            background: #FF4444;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .remove-btn:hover {
            background: #CC0000;
        }
        
        /* Cart Summary */
        .cart-summary {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .summary-row.total {
            font-size: 24px;
            font-weight: 700;
            color: var(--primary);
            border-bottom: 2px solid var(--primary);
        }
        
        /* Buttons */
        .cart-buttons {
            display: flex;
            gap: 20px;
            margin-top: 30px;
            flex-wrap: wrap;
        }
        
        .cart-btn {
            flex: 1;
            padding: 15px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            text-decoration: none;
            min-width: 200px;
        }
        
        .continue-btn {
            background: var(--secondary);
            color: white;
        }
        
        .continue-btn:hover {
            background: #00A88A;
            transform: translateY(-2px);
        }
        
        .checkout-btn {
            background: var(--primary);
            color: white;
        }
        
        .checkout-btn:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
        }
        
        .clear-btn {
            background: #FF4444;
            color: white;
        }
        
        .clear-btn:hover {
            background: #CC0000;
            transform: translateY(-2px);
        }
        
        /* Empty Cart */
        .empty-cart {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }
        
        .empty-icon {
            font-size: 80px;
            color: var(--gray);
            margin-bottom: 20px;
            opacity: 0.5;
        }
        
        .empty-title {
            font-size: 28px;
            margin-bottom: 10px;
            color: var(--dark);
        }
        
        .empty-text {
            color: var(--gray);
            margin-bottom: 30px;
            max-width: 500px;
            margin: 0 auto 30px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .cart-header, .cart-item {
                grid-template-columns: 1fr 1fr;
                gap: 15px;
            }
            
            .item-info {
                grid-column: 1 / -1;
            }
            
            .cart-buttons {
                flex-direction: column;
            }
            
            .cart-btn {
                width: 100%;
            }
        }
        
        @media (max-width: 480px) {
            .cart-item {
                padding: 15px;
            }
            
            .item-image {
                width: 60px;
                height: 60px;
            }
            
            .cart-summary {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="header-content">
            <a href="home" class="logo">
                <i class="fas fa-utensils"></i>
                Foodie Delight
            </a>
            
            <button class="back-btn" onclick="goBack()">
                <i class="fas fa-arrow-left"></i>
                Back to Menu
            </button>
        </div>
    </header>
    
    <!-- Main Container -->
    <div class="container">
        <h1 class="cart-title">Your Shopping Cart 🛒</h1>
        
        <% if (cart == null || cart.isEmpty()) { %>
        
        <!-- Empty Cart -->
        <div class="empty-cart">
            <div class="empty-icon">
                <i class="fas fa-shopping-cart"></i>
            </div>
            <h2 class="empty-title">Your cart is empty</h2>
            <p class="empty-text">Looks like you haven't added any delicious food to your cart yet.</p>
            
            <div class="cart-buttons">
                <% if (restaurantId != null) { %>
                    <a href="restaurantMenu?rid=<%= restaurantId %>" class="cart-btn continue-btn">
                        <i class="fas fa-utensils"></i>
                        Continue Ordering
                    </a>
                <% } else { %>
                    <a href="home" class="cart-btn continue-btn">
                        <i class="fas fa-home"></i>
                        Browse Restaurants
                    </a>
                <% } %>
            </div>
        </div>
        
        <% } else { 
            double subtotal = 0;
            double tax = 0;
            double delivery = 40;
        %>
        
        <!-- Cart Items -->
        <div class="cart-items">
            <div class="cart-header">
                <div>Item</div>
                <div>Price</div>
                <div>Quantity</div>
                <div>Total</div>
                <div>Action</div>
            </div>
            
            <% for (CartItem item : cart.getItems()) { 
                subtotal += item.getTotalPrice();
            %>
            <div class="cart-item">
                <div class="item-info">
                    <div class="item-image">
                        <img src="<%= item.getImageUrl() != null ? item.getImageUrl() : "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500&auto=format" %>" 
                             alt="<%= item.getName() %>">
                    </div>
                    <div>
                        <div class="item-name"><%= item.getName() %></div>
                        <div style="color: var(--gray); font-size: 14px;">Restaurant ID: <%= item.getRestaurantId() %></div>
                    </div>
                </div>
                
                <div class="item-price">₹<%= String.format("%.2f", item.getPrice()) %></div>
                
                <div class="quantity-controls">
                    <form action="updateCart" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="decrease">
                        <input type="hidden" name="itemId" value="<%= item.getId() %>">
                        <button type="submit" class="qty-btn">-</button>
                    </form>
                    
                    <span class="quantity"><%= item.getQuantity() %></span>
                    
                    <form action="updateCart" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="increase">
                        <input type="hidden" name="itemId" value="<%= item.getId() %>">
                        <button type="submit" class="qty-btn">+</button>
                    </form>
                </div>
                
                <div class="item-price">₹<%= String.format("%.2f", item.getTotalPrice()) %></div>
                
                <div>
                    <form action="updateCart" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="itemId" value="<%= item.getId() %>">
                        <button type="submit" class="remove-btn">
                            <i class="fas fa-trash"></i> Remove
                        </button>
                    </form>
                </div>
            </div>
            <% } %>
        </div>
        
        <!-- Cart Summary -->
        <div class="cart-summary">
            <h2 style="margin-bottom: 20px; color: var(--dark);">Order Summary</h2>
            
            <div class="summary-row">
                <span>Subtotal</span>
                <span>₹<%= String.format("%.2f", subtotal) %></span>
            </div>
            
            <% tax = subtotal * 0.05; // 5% tax %>
            <div class="summary-row">
                <span>Tax (5%)</span>
                <span>₹<%= String.format("%.2f", tax) %></span>
            </div>
            
            <div class="summary-row">
                <span>Delivery Fee</span>
                <span>₹<%= String.format("%.2f", delivery) %></span>
            </div>
            
            <div class="summary-row total">
                <span>Total Amount</span>
                <span>₹<%= String.format("%.2f", subtotal + tax + delivery) %></span>
            </div>
            
            <!-- Cart Buttons -->
            <div class="cart-buttons">
                <% if (restaurantId != 0) { %>
                    <a href="restaurantMenu?rid=<%= restaurantId %>" class="cart-btn continue-btn">
                        <i class="fas fa-utensils"></i>
                        Add More Items
                    </a>
                <% } else { %>
                    <a href="home" class="cart-btn continue-btn">
                        <i class="fas fa-home"></i>
                        Browse Restaurants
                    </a>
                <% } %>
                
                <form action="updateCart" method="post" style="display: inline; flex: 1;">
                    <input type="hidden" name="action" value="clear">
                    <button type="submit" class="cart-btn clear-btn">
                        <i class="fas fa-trash"></i>
                        Clear Cart
                    </button>
                </form>
                
                <a href="checkout.jsp" class="cart-btn checkout-btn">
                    <i class="fas fa-credit-card"></i>
                    Proceed to Checkout
                </a>
            </div>
        </div>
        
        <% } %>
    </div>
    
    <script>
        function goBack() {
            <% if (restaurantId != null && restaurantId != 0) { %>
                window.location.href = "restaurantMenu?rid=<%= restaurantId %>";
            <% } else { %>
                window.location.href = "home";
            <% } %>
        }
        
        // Update cart count in header
        document.addEventListener('DOMContentLoaded', function() {
            const cartCount = <%= cartCount %>;
            if (cartCount > 0) {
                // Update any cart count indicators on page
                const countElements = document.querySelectorAll('.cart-count');
                countElements.forEach(el => {
                    el.textContent = cartCount;
                });
            }
        });
    </script>
</body>
</html>
