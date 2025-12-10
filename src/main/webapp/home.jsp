<%@ page import="java.util.*, com.restaurant.dao.impl.*, com.restaurant.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home - Food Delivery App</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700;800&display=swap" rel="stylesheet">

<style>

    /* ----------- Global Styling ----------- */
    body {
        margin: 0;
        padding: 0;
        font-family: 'Poppins', sans-serif;
        /* Reverted to a neutral, very light gray to create separation and a clean look */
        background: #f8f8f8; 
    }

    /* ----------- HERO SECTION WITH VIDEO ----------- */
    .hero {
        width: 100%;
        height: 280px;
        position: relative;
        overflow: hidden;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .hero video {
        position: absolute;
        top: 50%;
        left: 50%;
        min-width: 100%;
        min-height: 100%;
        width: auto;
        height: auto;
        transform: translate(-50%, -50%);
        object-fit: cover;
        /* Kept the contrast filter to make the text pop */
        filter: brightness(0.65) saturate(1.1); 
        z-index: 1;
    }

    .headline {
        position: relative;
        font-size: 36px;
        font-weight: 800;
        color: white;
        text-align: center;
        z-index: 2;
        letter-spacing: 1px;
        padding: 0 15px;
        text-shadow: 0 2px 8px rgba(0, 0, 0, 0.7); 
    }

    /* ----------- Content Section ----------- */
    .content {
        width: 90%;
        max-width: 1200px;
        margin: auto;
        margin-top: 30px;
    }
    
    /* ------------------------------------------------------------------- */
    /* NOTE: The .add-btn CSS block is still removed, as requested earlier. */
    /* ------------------------------------------------------------------- */

    /* Restaurant Grid */
    .container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
        gap: 25px;
        margin-bottom: 40px;
    }

    /* Cards - White for a clean, professional look against the light gray body */
    .card {
        background: #ffffff; 
        padding: 15px;
        border-radius: 14px;
        text-decoration: none;
        color: black;
        /* Soft box shadow */
        box-shadow: 0 6px 20px rgba(0,0,0,0.12);
        transition: transform 0.25s ease, box-shadow 0.25s ease;
        display: flex;
        flex-direction: column;
    }

    .card:hover {
        transform: translateY(-7px);
        box-shadow: 0 10px 30px rgba(0,0,0,0.15);
    }

    .card img {
        width: 100%;
        height: 160px;
        border-radius: 12px;
        object-fit: cover;
    }

    .card h3 {
        margin: 12px 0 6px;
        font-size: 20px;
        font-weight: 700;
    }

    .card p {
        margin: 5px 0;
        color: #555;
        font-size: 14px;
        flex-grow: 1;
    }

    .rating {
        display: inline-block;
        background: #38a169; 
        padding: 7px 14px;
        border-radius: 20px;
        margin-top: 10px;
        font-weight: bold;
        color: white;
    }

    .empty-msg {
        text-align: center;
        color: #777; 
        font-size: 18px;
        margin-top: 30px;
        grid-column: 1 / -1;
    }

</style>

</head>

<body>

<%
    // Prevent access without login
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect("login.jsp?error=AccessDenied");
        return;
    }
%>

<div class="hero">
<video width="100%" autoplay muted loop>
   <source src="videos/mixkit-vegetables-into-the-pan-in-slow-motion-49231-hd-ready.mp4" type="video/mp4">
   Your browser does not support the video tag.
</video>

    <div class="headline">Discover The Best Restaurants Near You 🍽️</div>
</div>

<div class="content">

    <%-- The "+ Add Restaurant" link was removed in a previous step --%>

    <%
        // Instantiating the DAO object to fetch data
        RestaurantDaoImpl dao = new RestaurantDaoImpl();
        List<Restaurant> list = dao.getAllRestaurants();
    %>

    <div class="container">

        <% if (list != null && !list.isEmpty()) { %>

            <% for (Restaurant r : list) { %>

                <a href="menu?rid=<%= r.getId() %>" class="card">
                    <img src="<%= r.getImageUrl() %>" alt="<%= r.getName() %>">
                    <h3><%= r.getName() %></h3>
                    <p><%= r.getAddress() %></p>
                    <div class="rating">⭐ <%= String.format("%.1f", r.getRating()) %></div>
                </a>

            <% } %>

        <% } else { %>

            <div class="empty-msg">No Restaurants Added Yet</div>

        <% } %>

    </div>

</div>

</body>
</html>