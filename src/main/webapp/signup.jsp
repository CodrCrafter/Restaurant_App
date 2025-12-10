<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up | Restaurant</title>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');

    body {
        margin: 0;
        padding: 0;
        font-family: "Poppins", sans-serif;
        background: linear-gradient(135deg,#0f0f0f,#1a1a1a,#333);
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .signup-card {
        width: 400px;
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(15px);
        padding: 40px;
        border-radius: 20px;
        box-shadow: 0 8px 30px rgba(0,0,0,0.4);
        border: 1px solid rgba(255, 255, 255, 0.2);
        text-align: center;
        animation: fadeIn 1s ease;
    }

    /* Gradient headline */
    .title {
        font-size: 32px;
        font-weight: 600;
        background: linear-gradient(45deg,#ffae00,#ff4b2b,#ff0099);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        margin-bottom: 10px;
        letter-spacing: 1px;
        animation: glow 2s infinite alternate;
    }

    /* Icon */
    .signup-icon {
        font-size: 55px;
        margin-bottom: 12px;
        color: #ffae00;
        animation: pop 0.6s ease;
    }

    .subtitle {
        color: #ececec;
        font-size: 14px;
        margin-bottom: 25px;
        opacity: 0.8;
    }

    .input-box {
        width: 100%;
        margin-bottom: 18px;
    }

    .input-box input {
        width: 100%;
        padding: 14px;
        border-radius: 10px;
        border: none;
        outline: none;
        font-size: 15px;
        background: rgba(255,255,255,0.85);
    }

    .btn {
        width: 100%;
        padding: 14px;
        background: linear-gradient(135deg,#ff512f,#dd2476);
        color: white;
        border: none;
        border-radius: 12px;
        font-size: 17px;
        cursor: pointer;
        transition: 0.3s;
        font-weight: 500;
    }

    .btn:hover {
        transform: scale(1.03);
        background: linear-gradient(135deg,#dd2476,#ff512f);
    }

    .links {
        margin-top: 18px;
        font-size: 14px;
        color: #fff;
    }

    .links a {
        color: #ffdd99;
        text-decoration: none;
        font-weight: 500;
    }

    .links a:hover {
        text-decoration: underline;
    }

    @keyframes fadeIn {
        0% { opacity: 0; transform: translateY(20px); }
        100% { opacity: 1; transform: translateY(0); }
    }

    @keyframes pop {
        0% { transform: scale(0.5); opacity: 0; }
        100% { transform: scale(1); opacity: 1; }
    }

    @keyframes glow {
        from { text-shadow: 0 0 5px #ffae00; }
        to   { text-shadow: 0 0 18px #ff0099; }
    }

</style>
</head>

<body>
<% String errorMsg = (String) request.getAttribute("errorMsg"); %>
<% if (errorMsg != null) { %>
   <p style="color:red;"><%= errorMsg %></p>
<% } %>


<div class="signup-card">

    <div class="signup-icon">📝</div>

    <div class="title">Create Account</div>
    <div class="subtitle">Sign up to start your food journey</div>

    <form action="signup" method="post">

        <div class="input-box">
            <input type="text" name="username" placeholder="Username" required>
        </div>

        <div class="input-box">
            <input type="email" name="email" placeholder="Email ID" required>
        </div>

        <div class="input-box">
            <input type="password" name="password" placeholder="Password" required>
        </div>

        <button type="submit" class="btn">Create Account</button>
    </form>

    <div class="links">
        Already have an account? <a href="login.jsp">Login</a>
    </div>
</div>

</body>
</html>
