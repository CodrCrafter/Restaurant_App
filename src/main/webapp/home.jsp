<%@ page import="java.util.*, com.restaurant.dao.impl.RestaurantDaoImpl, com.restaurant.model.Restaurant" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Foodie Delight | Discover Restaurants</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #FF6B35;
            --primary-dark: #E55A2B;
            --secondary: #00C2A2;
            --dark: #1A1A2E;
            --light: #F8F9FA;
            --gray: #6C757D;
            --success: #38A169;
            --card-bg: #FFFFFF;
            --shadow: rgba(0, 0, 0, 0.08);
            --shadow-hover: rgba(0, 0, 0, 0.12);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--light);
            color: var(--dark);
            line-height: 1.6;
        }

        /* Modern Navigation */
        .navbar {
            position: fixed;
            top: 0;
            width: 100%;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 18px 5%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 20px var(--shadow);
            z-index: 1000;
            transition: all 0.3s ease;
        }

        .navbar.scrolled {
            padding: 12px 5%;
            background: rgba(255, 255, 255, 0.98);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 28px;
            font-weight: 800;
            color: var(--primary);
            font-family: 'Poppins', sans-serif;
        }

        .logo i {
            color: var(--secondary);
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .nav-links {
            display: flex;
            gap: 25px;
        }

        .nav-links a {
            text-decoration: none;
            color: var(--dark);
            font-weight: 600;
            font-size: 16px;
            padding: 8px 0;
            position: relative;
            transition: color 0.3s;
        }

        .nav-links a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary);
            transition: width 0.3s;
        }

        .nav-links a:hover::after {
            width: 100%;
        }

        .nav-links a:hover {
            color: var(--primary);
        }

        .nav-btn {
            padding: 10px 24px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(255, 107, 53, 0.3);
        }

        .btn-outline {
            border: 2px solid var(--primary);
            color: var(--primary);
            background: transparent;
        }

        .btn-outline:hover {
            background: var(--primary);
            color: white;
        }

        .search-container {
            position: relative;
            width: 300px;
        }

        .search-input {
            width: 100%;
            padding: 12px 20px 12px 45px;
            border-radius: 50px;
            border: 2px solid #E5E7EB;
            background: white;
            font-size: 15px;
            transition: all 0.3s;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(255, 107, 53, 0.1);
        }

        .search-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
        }

        /* Hero Carousel */
        .hero {
            margin-top: 80px;
            height: 500px;
            position: relative;
            overflow: hidden;
            border-radius: 0 0 20px 20px;
        }

        .carousel {
            position: relative;
            height: 100%;
            width: 100%;
        }

        .carousel-slide {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            transition: opacity 1s ease-in-out;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .carousel-slide.active {
            opacity: 1;
        }

        .carousel-slide img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            filter: brightness(0.7);
        }

        .slide-content {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 40px 5% 60px;
            background: linear-gradient(transparent, rgba(0, 0, 0, 0.8));
            color: white;
        }

        .slide-title {
            font-size: 42px;
            font-weight: 800;
            margin-bottom: 10px;
            font-family: 'Poppins', sans-serif;
        }

        .slide-subtitle {
            font-size: 18px;
            max-width: 600px;
            opacity: 0.9;
        }

        .carousel-indicators {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            gap: 10px;
        }

        .indicator {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.5);
            cursor: pointer;
            transition: all 0.3s;
        }

        .indicator.active {
            background: white;
            transform: scale(1.2);
        }

        .carousel-nav {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(0, 0, 0, 0.5);
            color: white;
            border: none;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 20px;
        }

        .carousel-nav:hover {
            background: rgba(0, 0, 0, 0.7);
        }

        .prev {
            left: 20px;
        }

        .next {
            right: 20px;
        }

        /* Main Content */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 60px 0 30px;
        }

        .section-title {
            font-size: 32px;
            font-weight: 800;
            color: var(--dark);
            font-family: 'Poppins', sans-serif;
        }

        .filter-options {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 10px 20px;
            border-radius: 50px;
            border: 2px solid #E5E7EB;
            background: white;
            color: var(--dark);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .filter-btn:hover, .filter-btn.active {
            border-color: var(--primary);
            background: var(--primary);
            color: white;
        }

        /* Restaurant Cards Grid */
        .restaurant-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
            margin-bottom: 60px;
        }

        .restaurant-card {
            background: var(--card-bg);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 6px 20px var(--shadow);
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .restaurant-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px var(--shadow-hover);
        }

        .card-badge {
            position: absolute;
            top: 15px;
            left: 15px;
            background: var(--primary);
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            z-index: 2;
        }

        .card-image {
            height: 180px;
            width: 100%;
            object-fit: cover;
            transition: transform 0.5s;
        }

        .restaurant-card:hover .card-image {
            transform: scale(1.05);
        }

        .card-content {
            padding: 20px;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 10px;
        }

        .card-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 5px;
        }

        .card-category {
            color: var(--gray);
            font-size: 14px;
            margin-bottom: 10px;
        }

        .card-rating {
            background: var(--success);
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #E5E7EB;
        }

        .card-price {
            font-weight: 700;
            color: var(--primary);
        }

        .card-time {
            color: var(--gray);
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        /* Features Section */
        .features {
            background: white;
            padding: 60px 0;
            border-radius: 20px;
            margin: 60px 0;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 30px;
        }

        .feature-card {
            text-align: center;
            padding: 30px 20px;
            border-radius: 15px;
            transition: all 0.3s;
        }

        .feature-card:hover {
            background: var(--light);
            transform: translateY(-5px);
        }

        .feature-icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 28px;
        }

        .feature-title {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 10px;
            color: var(--dark);
        }

        .feature-desc {
            color: var(--gray);
        }

        /* Footer */
        .footer {
            background: var(--dark);
            color: white;
            padding: 60px 0 30px;
            margin-top: 60px;
        }

        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 40px;
            margin-bottom: 40px;
        }

        .footer-logo {
            font-size: 28px;
            font-weight: 800;
            margin-bottom: 15px;
            color: white;
            font-family: 'Poppins', sans-serif;
        }

        .footer-desc {
            color: rgba(255, 255, 255, 0.7);
            margin-bottom: 20px;
        }

        .social-icons {
            display: flex;
            gap: 15px;
        }

        .social-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-decoration: none;
            transition: all 0.3s;
        }

        .social-icon:hover {
            background: var(--primary);
            transform: translateY(-3px);
        }

        .footer-title {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 20px;
            color: white;
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: 10px;
        }

        .footer-links a {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-links a:hover {
            color: var(--primary);
        }

        .copyright {
            text-align: center;
            padding-top: 30px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.5);
            font-size: 14px;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .hero {
                height: 400px;
            }
            
            .slide-title {
                font-size: 36px;
            }
            
            .search-container {
                width: 250px;
            }
        }

        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 15px;
                padding: 15px 5%;
            }
            
            .nav-right {
                width: 100%;
                justify-content: space-between;
            }
            
            .search-container {
                width: 100%;
                order: -1;
            }
            
            .nav-links {
                display: none;
            }
            
            .hero {
                height: 350px;
                margin-top: 120px;
            }
            
            .slide-title {
                font-size: 28px;
            }
            
            .section-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
        }

        @media (max-width: 576px) {
            .restaurant-grid {
                grid-template-columns: 1fr;
            }
            
            .carousel-nav {
                width: 40px;
                height: 40px;
            }
            
            .slide-title {
                font-size: 24px;
            }
            
            .slide-subtitle {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
    <%-- COMMENTED OUT: Home page accessible without login --%>
    <%--
    <%
        if (session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp?error=AccessDenied");
            return;
        }
    %>
    --%>

    <!-- Modern Navigation -->
    <nav class="navbar" id="navbar">
        <div class="logo">
            <i class="fas fa-utensils"></i>
            Foodie Delight
        </div>
        
        <div class="nav-right">
            <div class="search-container">
                <i class="fas fa-search search-icon"></i>
                <form action="search" method="get">
                    <input type="text" class="search-input" name="query" placeholder="Search restaurants, cuisines, dishes..." required>
                </form>
            </div>
            
            <div class="nav-links">
                <a href="home">Home</a>
                <% if (session.getAttribute("loggedInUser") != null) { %>
                    <a href="myOrders">My Orders</a>
                <% } %>
            </div>
            
            <% if (session.getAttribute("loggedInUser") != null) { %>
                <!-- Show logout for logged in users -->
                <span style="color: var(--primary); font-weight: 600; margin-right: 10px;">
                    <i class="fas fa-user"></i> <%= session.getAttribute("loggedInUser") %>
                </span>
                <a href="logout.jsp" class="nav-btn btn-outline">
                    <i class="fas fa-sign-out-alt"></i>
                    Logout
                </a>
            <% } else { %>
                <!-- Show login/signup for guests -->
                <a href="login.jsp" class="nav-btn btn-outline" style="margin-right: 10px;">
                    <i class="fas fa-sign-in-alt"></i>
                    Login
                </a>
                <a href="signup.jsp" class="nav-btn btn-primary">
                    <i class="fas fa-user-plus"></i>
                    Sign Up
                </a>
            <% } %>
        </div>
    </nav>

    <!-- Hero Carousel -->
    <div class="hero">
        <div class="carousel">
            <!-- Slide 1 - Updated image -->
            <div class="carousel-slide active">
                <img src="https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80" alt="Luxury Restaurant">
                <div class="slide-content">
                    <h1 class="slide-title">Discover Culinary Excellence</h1>
                    <p class="slide-subtitle">From fine dining to street food, explore the best restaurants in your city</p>
                </div>
            </div>
            
            <!-- Slide 2 - Updated image -->
            <div class="carousel-slide">
                <img src="https://images.unsplash.com/photo-1555939594-58d7cb561ad1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2067&q=80" alt="Delicious Food">
                <div class="slide-content">
                    <h1 class="slide-title">Taste the Extraordinary</h1>
                    <p class="slide-subtitle">Fresh ingredients, master chefs, and unforgettable flavors await you</p>
                </div>
            </div>
            
            <!-- Slide 3 - Updated image -->
            <div class="carousel-slide">
                <img src="https://images.unsplash.com/photo-1571066811602-716837d681de?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2044&q=80" alt="Fast Delivery">
                <div class="slide-content">
                    <h1 class="slide-title">Fast & Reliable Delivery</h1>
                    <p class="slide-subtitle">Hot food delivered to your door in 30 minutes or less</p>
                </div>
            </div>
            
            <!-- Slide 4 - Updated image -->
            <div class="carousel-slide">
                <img src="https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2081&q=80" alt="Gourmet Dishes">
                <div class="slide-content">
                    <h1 class="slide-title">Exclusive Offers Daily</h1>
                    <p class="slide-subtitle">Enjoy discounts up to 50% on your favorite restaurants</p>
                </div>
            </div>
            
            <button class="carousel-nav prev" onclick="changeSlide(-1)">
                <i class="fas fa-chevron-left"></i>
            </button>
            <button class="carousel-nav next" onclick="changeSlide(1)">
                <i class="fas fa-chevron-right"></i>
            </button>
            
            <div class="carousel-indicators">
                <div class="indicator active" onclick="goToSlide(0)"></div>
                <div class="indicator" onclick="goToSlide(1)"></div>
                <div class="indicator" onclick="goToSlide(2)"></div>
                <div class="indicator" onclick="goToSlide(3)"></div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <div class="section-header">
            <h2 class="section-title">Top Restaurants Near You</h2>
            <div>
                <span style="color: var(--primary); font-weight: 600;">
                    <i class="fas fa-map-marker-alt"></i>
                    Bangalore
                </span>
            </div>
        </div>
        
        <!-- Filter Options -->
        <div class="filter-options">
            <button class="filter-btn active" onclick="filterRestaurants('all')">All</button>
            <button class="filter-btn" onclick="filterRestaurants('rating')">Top Rated</button>
            <button class="filter-btn" onclick="filterRestaurants('fast')">Fast Delivery</button>
            <button class="filter-btn" onclick="filterRestaurants('veg')">Pure Veg</button>
            <button class="filter-btn" onclick="filterRestaurants('discount')">Offers</button>
        </div>

        <!-- Restaurant Cards -->
        <div class="restaurant-grid" id="restaurantGrid">
            <%
                // Get restaurants from request attribute (set by HomeServlet)
                List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
                
                // If no restaurants in request attribute, try to fetch from DAO directly
                if (restaurants == null || restaurants.isEmpty()) {
                    RestaurantDaoImpl dao = new RestaurantDaoImpl();
                    restaurants = dao.getAllRestaurants();
                }
                
                String[] badges = {"Top Rated", "Fast Delivery", "30% OFF", "Pure Veg", "New", "Trending"};
                
                if (restaurants != null && !restaurants.isEmpty()) {
                    int i = 0;
                    for (Restaurant restaurant : restaurants) {
                        int badgeIndex = i % badges.length;
                        
                        // Create variables for data attributes
                        String category = (restaurant.getName().toLowerCase().contains("spice") || 
                                         restaurant.getCuisine().toLowerCase().contains("north indian")) ? "veg" : "all";
                        String delivery = (restaurant.getDeliveryTime().contains("15") || 
                                         restaurant.getDeliveryTime().contains("20")) ? "fast" : "normal";
                        
                        // Determine menu link based on login status
                        String menuLink;
                        if (session.getAttribute("loggedInUser") != null) {
                            menuLink = "restaurantMenu?rid=" + restaurant.getId();
                        } else {
                            menuLink = "login.jsp?redirect=restaurantMenu&rid=" + restaurant.getId();
                        }
                        
                        // Set badge based on restaurant rating
                        String badge = badges[badgeIndex];
                        if (restaurant.getRating() >= 4.5) {
                            badge = "Top Rated";
                        } else if (restaurant.getDeliveryTime().contains("15") || restaurant.getDeliveryTime().contains("20")) {
                            badge = "Fast Delivery";
                        }
            %>
            <a href="<%= menuLink %>" class="restaurant-card" data-category="<%= category %>" 
               data-rating="<%= restaurant.getRating() %>" data-delivery="<%= delivery %>">
                <div class="card-badge"><%= badge %></div>
                <img src="<%= restaurant.getImageUrl() != null ? restaurant.getImageUrl() : "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=500&auto=format&fit=crop" %>" 
                     alt="<%= restaurant.getName() %>" 
                     class="card-image"
                     onerror="this.src='https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=500&auto=format&fit=crop'">
                <div class="card-content">
                    <div class="card-header">
                        <div>
                            <h3 class="card-title"><%= restaurant.getName() %></h3>
                            <p class="card-category"><%= restaurant.getCuisine() %></p>
                        </div>
                        <div class="card-rating">
                            <i class="fas fa-star"></i>
                            <%= String.format("%.1f", restaurant.getRating()) %>
                        </div>
                    </div>
                    <p><%= restaurant.getLocation() %></p>
                    <div class="card-footer">
                        <div class="card-price">
                            <%= restaurant.getPriceRange() %>
                        </div>
                        <div class="card-time">
                            <i class="fas fa-clock"></i>
                            <%= restaurant.getDeliveryTime() %>
                        </div>
                    </div>
                </div>
            </a>
            <% 
                        i++;
                    }
                } else { 
            %>
            <div style="grid-column: 1 / -1; text-align: center; padding: 60px 20px;">
                <i class="fas fa-utensils" style="font-size: 60px; color: var(--gray); margin-bottom: 20px;"></i>
                <h3 style="color: var(--dark); margin-bottom: 10px;">No Restaurants Found</h3>
                <p style="color: var(--gray); max-width: 500px; margin: 0 auto;">We're working on adding restaurants in your area. Check back soon!</p>
            </div>
            <% } %>
        </div>
        
        <!-- Features Section -->
        <div class="features">
            <h2 class="section-title" style="text-align: center; margin-bottom: 50px;">Why Choose Foodie Delight?</h2>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-bolt"></i>
                    </div>
                    <h3 class="feature-title">Lightning Fast Delivery</h3>
                    <p class="feature-desc">Get your food delivered in 30 minutes or less with our optimized delivery network</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3 class="feature-title">Safe & Secure</h3>
                    <p class="feature-desc">Contactless delivery and strict hygiene protocols for your safety</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-tags"></i>
                    </div>
                    <h3 class="feature-title">Best Offers</h3>
                    <p class="feature-desc">Exclusive discounts and cashback offers on every order</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-star"></i>
                    </div>
                    <h3 class="feature-title">Curated Restaurants</h3>
                    <p class="feature-desc">Only the highest-rated restaurants with quality verified food</p>
                </div>
            </div>
        </div>
    </div>
    
    
    
    
    <div class="cart-icon" onclick="viewCart()">
    <i class="fas fa-shopping-cart"></i>
    <% 
        Integer cartCount = (Integer) session.getAttribute("cartCount");
        if (cartCount != null && cartCount > 0) {
    %>
        <span class="cart-count"><%= cartCount %></span>
    <% } else { %>
        <span class="cart-count" style="display: none;">0</span>
    <% } %>
</div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div>
                    <div class="footer-logo">Foodie Delight</div>
                    <p class="footer-desc">Discover the best food & drinks in Bangalore. Order online for quick delivery to your doorstep.</p>
                    <div class="social-icons">
                        <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
                
                <div>
                    <h3 class="footer-title">Quick Links</h3>
                    <ul class="footer-links">
                        <li><a href="home">Home</a></li>
                        <% if (session.getAttribute("loggedInUser") != null) { %>
                            <li><a href="myOrders">My Orders</a></li>
                        <% } %>
                        <li><a href="offers.jsp">Offers</a></li>
                        <li><a href="help.jsp">Help & Support</a></li>
                    </ul>
                </div>
                
                <div>
                    <h3 class="footer-title">Popular Cities</h3>
                    <ul class="footer-links">
                        <li><a href="#">Bangalore</a></li>
                        <li><a href="#">Mumbai</a></li>
                        <li><a href="#">Delhi</a></li>
                        <li><a href="#">Chennai</a></li>
                        <li><a href="#">Hyderabad</a></li>
                    </ul>
                </div>
                
                <div>
                    <h3 class="footer-title">Contact Us</h3>
                    <ul class="footer-links">
                        <li><i class="fas fa-phone"></i> +91 9876543210</li>
                        <li><i class="fas fa-envelope"></i> support@foodiedelight.com</li>
                        <li><i class="fas fa-map-marker-alt"></i> Bangalore, India</li>
                    </ul>
                </div>
            </div>
            
            <div class="copyright">
                <p>&copy; 2023 Foodie Delight. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        // Carousel functionality
        let currentSlide = 0;
        const slides = document.querySelectorAll('.carousel-slide');
        const indicators = document.querySelectorAll('.indicator');
        const totalSlides = slides.length;
        let slideInterval;

        function showSlide(n) {
            slides[currentSlide].classList.remove('active');
            indicators[currentSlide].classList.remove('active');
            
            currentSlide = (n + totalSlides) % totalSlides;
            
            slides[currentSlide].classList.add('active');
            indicators[currentSlide].classList.add('active');
        }

        function changeSlide(n) {
            showSlide(currentSlide + n);
            resetInterval();
        }

        function goToSlide(n) {
            showSlide(n);
            resetInterval();
        }

        function resetInterval() {
            clearInterval(slideInterval);
            slideInterval = setInterval(function() { changeSlide(1); }, 5000);
        }

        // Auto slide every 5 seconds
        slideInterval = setInterval(function() { changeSlide(1); }, 5000);

        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.getElementById('navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });

        // Restaurant filtering functionality
        function filterRestaurants(filter) {
            const cards = document.querySelectorAll('.restaurant-card');
            const filterBtns = document.querySelectorAll('.filter-btn');
            
            // Update active button
            filterBtns.forEach(function(btn) {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');
            
            // Filter cards
            cards.forEach(function(card) {
                let showCard = false;
                
                switch(filter) {
                    case 'all':
                        showCard = true;
                        break;
                    case 'rating':
                        const rating = parseFloat(card.getAttribute('data-rating'));
                        showCard = rating >= 4.0;
                        break;
                    case 'fast':
                        const delivery = card.getAttribute('data-delivery');
                        showCard = delivery === 'fast';
                        break;
                    case 'veg':
                        const category = card.getAttribute('data-category');
                        showCard = category === 'veg';
                        break;
                    case 'discount':
                        const badgeText = card.querySelector('.card-badge').textContent;
                        showCard = badgeText.includes('OFF') || badgeText.includes('%');
                        break;
                }
                
                if (showCard) {
                    card.style.display = 'block';
                    setTimeout(function() {
                        card.style.opacity = '1';
                        card.style.transform = 'translateY(0)';
                    }, 10);
                } else {
                    card.style.opacity = '0';
                    card.style.transform = 'translateY(20px)';
                    setTimeout(function() {
                        card.style.display = 'none';
                    }, 300);
                }
            });
        }

        // Add hover effect to cards
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.restaurant-card');
            
            cards.forEach(function(card) {
                card.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-10px)';
                });
                
                card.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });
            
            // Initialize with all cards visible
            filterRestaurants('all');
        });

        // Search form submission
        document.querySelector('.search-input').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                this.form.submit();
            }
        });
    </script>
</body>
</html>
