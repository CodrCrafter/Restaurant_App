<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login | Restaurant</title>

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

    .login-card {
        width: 380px;
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(15px);
        padding: 35px;
        border-radius: 20px;
        box-shadow: 0 8px 30px rgba(0,0,0,0.4);
        border: 1px solid rgba(255, 255, 255, 0.2);
        text-align: center;
        animation: fadeIn 1s ease;
    }

    /* Beautiful headline */
    .title {
        font-size: 30px;
        font-weight: 600;
        background: linear-gradient(45deg,#ffae00,#ff4b2b,#ff0099);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        margin-bottom: 8px;
        letter-spacing: 1px;
        animation: glow 2s infinite alternate;
    }

    /* Icon */
    .login-icon {
        font-size: 55px;
        margin-bottom: 10px;
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
        margin-bottom: 15px;
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
        margin-top: 15px;
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

<div class="login-card">

   <div class="login-icon">
    <i class="fa fa-lock"></i>
</div>


    <div class="title">Welcome Back</div>
    <div class="subtitle">Login to continue your food journey</div>

<% String error = (String) request.getAttribute("error"); %>
<% if (error != null) { %>
    <p style="color:red; text-align:center;"><%= error %></p>
<% } %>

    <form action="login" method="post">

        <div class="input-box">
            <input type="text" name="username" placeholder="Enter Username" required>
        </div>

        <div class="input-box">
            <input type="password" name="password" placeholder="Enter Password" required>
        </div>

        <button type="submit" class="btn">Login</button>
    </form>

    <div class="links">
        Don't have an account? <a href="signup.jsp">Sign Up</a><br><br>
        <a href="forgotPassword.jsp">Forgot Password?</a>
    </div>
</div>

</body>
</html>

