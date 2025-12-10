<%@ page language="java" contentType="text/html; charset=ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
<title>Forgot Password</title>
<style>
body {
    margin: 0;
    font-family: 'Poppins', sans-serif;
    background: #f3f4f6;
}
.container {
    width: 380px;
    margin: 100px auto;
    background: white;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.1);
}
h2 {
    text-align: center;
    color: #333;
}
input {
    width: 100%;
    padding: 12px;
    margin: 15px 0;
    border: 1px solid #ccc;
    border-radius: 6px;
}
button {
    width: 100%;
    padding: 12px;
    background: #ff5722;
    border: none;
    color: white;
    font-size: 16px;
    border-radius: 6px;
    cursor: pointer;
}
button:hover {
    background: #e64a19;
}
a {
    color: #ff5722;
    text-decoration: none;
}
</style>
</head>

<body>
<div class="container">
    <h2>Forgot Password</h2>
    <p>Enter your registered email. We'll send a 6-digit OTP to reset your password.</p>

    <form action="sendOtp" method="post">
        <input type="email" name="email" placeholder="Enter your Email" required>
        <button type="submit">Send OTP</button>
    </form>

    <p style="text-align:center; margin-top:15px;">
        Remembered your password? <a href="login.jsp">Login</a>
    </p>
</div>
</body>
</html>
