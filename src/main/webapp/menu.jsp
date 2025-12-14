<%@ page import="java.util.*, com.restaurant.model.Menu" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Menu Items | FoodHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* ===== VARIABLES ===== */
        :root {
            --primary: #FF6B35;
            --primary-dark: #E55A2B;
            --secondary: #2A9D8F;
            --dark: #1A1A2E;
            --darker: #0F0F1A;
            --light: #F8F9FA;
            --gray: #6C757D;
            --success: #28A745;
            --card-bg: rgba(255, 255, 255, 0.05);
        }

        /* ===== RESET & BASE ===== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--darker) 0%, var(--dark) 100%);
            color: var(--light);
            min-height: 100vh;
            line-height: 1.6;
        }

        /* ===== HEADER ===== */
        .header-container {
            background: linear-gradient(90deg, var(--primary) 0%, var(--primary-dark) 100%);
            padding: 1.5rem 2rem;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
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
            font-size: 1.8rem;
            font-weight: 700;
            color: white;
            text-decoration: none;
        }

        .logo i {
            font-size: 2rem;
        }

        .cart-icon {
            position: relative;
            font-size: 1.5rem;
            color: white;
            cursor: pointer;
            padding: 8px;
            transition: transform 0.3s;
        }

        .cart-icon:hover {
            transform: scale(1.1);
        }

        .cart-count {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--secondary);
            color: white;
            font-size: 0.7rem;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* ===== MENU CONTAINER ===== */
        .menu-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1.5rem;
        }

        .restaurant-info {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }

        .restaurant-title {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            color: white;
        }

        .restaurant-meta {
            display: flex;
            gap: 1.5rem;
            color: var(--gray);
            margin-bottom: 1rem;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .rating {
            color: #FFC107;
            font-weight: bold;
        }

        /* ===== MENU GRID ===== */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-top: 1rem;
        }

        /* ===== MENU CARD ===== */
        .menu-card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
        }

        .menu-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(255, 107, 53, 0.2);
            border-color: var(--primary);
        }

        .card-image {
            height: 200px;
            width: 100%;
            overflow: hidden;
        }

        .card-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }

        .menu-card:hover .card-image img {
            transform: scale(1.05);
        }

        .card-content {
            padding: 1.5rem;
        }

        .item-name {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .item-price {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--primary);
        }

        .item-description {
            color: #aaa;
            font-size: 0.9rem;
            margin-bottom: 1.2rem;
            line-height: 1.5;
        }

        /* ===== ADD TO CART BUTTON ===== */
        .add-to-cart-btn {
            width: 100%;
            padding: 0.8rem;
            background: linear-gradient(90deg, var(--primary) 0%, var(--primary-dark) 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .add-to-cart-btn:hover {
            background: linear-gradient(90deg, var(--primary-dark) 0%, var(--primary) 100%);
            transform: scale(1.02);
            box-shadow: 0 5px 15px rgba(255, 107, 53, 0.4);
        }

        .add-to-cart-btn i {
            font-size: 1.1rem;
        }

        /* ===== EMPTY STATE ===== */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            grid-column: 1 / -1;
        }

        .empty-icon {
            font-size: 4rem;
            color: var(--gray);
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .empty-state h3 {
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
            color: white;
        }

        .empty-state p {
            color: var(--gray);
            margin-bottom: 1.5rem;
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 1rem;
            }
            
            .menu-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            }
            
            .restaurant-meta {
                flex-wrap: wrap;
                gap: 1rem;
            }
        }

        @media (max-width: 480px) {
            .menu-grid {
                grid-template-columns: 1fr;
            }
            
            .restaurant-title {
                font-size: 1.5rem;
            }
            
            .menu-container {
                padding: 0 1rem;
            }
        }

        /* ===== LOADING ANIMATION ===== */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .menu-card {
            animation: fadeIn 0.5s ease-out;
        }
    </style>
</head>
<body>
    <!-- HEADER -->
    <header class="header-container">
        <div class="header-content">
            <a href="home.jsp" class="logo">
                <i class="fas fa-utensils"></i>
                <span>FoodHub</span>
            </a>
            
            <div class="cart-icon" onclick="viewCart()">
                <i class="fas fa-shopping-cart"></i>
                <span class="cart-count" id="cartCount">0</span>
            </div>
        </div>
    </header>

    <!-- MENU CONTENT -->
    <div class="menu-container">
        <!-- Restaurant Info -->
        <div class="restaurant-info">
            <h1 class="restaurant-title" id="restaurantName">Restaurant Menu</h1>
            <div class="restaurant-meta">
                <span class="meta-item">
                    <i class="fas fa-star rating"></i>
                    <span>4.5</span>
                </span>
                <span class="meta-item">
                    <i class="fas fa-clock"></i>
                    <span>20-30 min</span>
                </span>
                <span class="meta-item">
                    <i class="fas fa-rupee-sign"></i>
                    <span>₹300 for one</span>
                </span>
                <span class="meta-item">
                    <i class="fas fa-map-marker-alt"></i>
                    <span>Bangalore</span>
                </span>
            </div>
        </div>

        <!-- Menu Items Grid -->
        <div class="menu-grid">
            <%
                List<Menu> menuList = (List<Menu>) request.getAttribute("menuList");
                if (menuList == null || menuList.isEmpty()) {
            %>
                <div class="empty-state">
                    <div class="empty-icon">
                        <i class="fas fa-utensils"></i>
                    </div>
                    <h3>Menu Coming Soon!</h3>
                    <p>We're working on adding delicious items to our menu.</p>
                    <a href="home.jsp" class="add-to-cart-btn" style="max-width: 200px; margin: 0 auto;">
                        <i class="fas fa-arrow-left"></i> Back to Restaurants
                    </a>
                </div>
            <%
                } else {
                    for (Menu item : menuList) {
            %>
                <div class="menu-card">
                    <div class="card-image">
                        <img src="<%= item.getImageUrl() != null ? item.getImageUrl() : "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500&auto=format&fit=crop" %>" 
                             alt="<%= item.getItemName() %>"
                             onerror="this.src='https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500&auto=format&fit=crop'">
                    </div>
                    
                    <div class="card-content">
                        <div class="item-name">
                            <span><%= item.getItemName() %></span>
                            <span class="item-price">₹<%= String.format("%.0f", item.getPrice()) %></span>
                        </div>
                        
                        <p class="item-description">
                            <!-- You can add description field to your Menu model -->
                            Delicious and fresh preparation
                        </p>
                        
                        <!-- Add to Cart Form -->
<form action="addToCart" method="post">
    <input type="hidden" name="id" value="<%= item.getId() %>">
    <input type="hidden" name="name" value="<%= item.getItemName() %>">
    <input type="hidden" name="price" value="<%= item.getPrice() %>">
    <input type="hidden" name="restaurantId" value="<%= item.getRestaurantId() %>">
    <input type="hidden" name="imageUrl" value="<%= item.getImageUrl() %>">
    
    <button type="submit" class="add-to-cart-btn">
        <i class="fas fa-cart-plus"></i> Add to Cart
    </button>
</form>
                    </div>
                </div>
            <%
                    }
                }
            %>
        </div>
    </div>

    <!-- JavaScript -->
    <script>
        // Cart functionality
        let cartCount = 0;
        
        function addToCart(event) {
            event.preventDefault();
            
            // Get form data
            const form = event.target;
            const formData = new FormData(form);
            
            // Show animation/feedback
            const button = form.querySelector('button');
            const originalText = button.innerHTML;
            button.innerHTML = '<i class="fas fa-check"></i> Added!';
            button.style.background = 'linear-gradient(90deg, var(--secondary) 0%, #1E8E7C 100%)';
            
            // Send AJAX request
            fetch('addToCart', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                // Update cart count
                cartCount++;
                document.getElementById('cartCount').textContent = cartCount;
                
                // Reset button after 1.5 seconds
                setTimeout(() => {
                    button.innerHTML = originalText;
                    button.style.background = '';
                }, 1500);
            })
            .catch(error => {
                console.error('Error:', error);
                button.innerHTML = '<i class="fas fa-exclamation"></i> Error';
                setTimeout(() => {
                    button.innerHTML = originalText;
                }, 1500);
            });
        }
        
        function viewCart() {
            // Redirect to cart page
            window.location.href = 'cart.jsp';
        }
        
        // Initialize cart count from localStorage
        document.addEventListener('DOMContentLoaded', function() {
            const savedCart = localStorage.getItem('cartCount');
            if (savedCart) {
                cartCount = parseInt(savedCart);
                document.getElementById('cartCount').textContent = cartCount;
            }
            
            // Update restaurant info if available
            // You can fetch restaurant details using restaurantId
        });
    </script>
</body>
</html>
