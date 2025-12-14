<%@ page language="java" contentType="text/html; charset=ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
<title>Verify OTP</title>
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
    background: #4CAF50;
    border: none;
    color: white;
    font-size: 16px;
    border-radius: 6px;
    cursor: pointer;
}
button:hover {
    background: #45a049;
}
a {
    text-decoration: none;
    color: #ff5722;
}
</style>
</head>

<body>
<div class="container">
    <h2>Verify OTP</h2>

   <form action="<%=request.getContextPath()%>/verifyOtp" method="post">
    <input type="text" name="otp" placeholder="Enter 6-digit OTP" required>
    <button type="submit">Verify</button>
</form>


<p style="text-align:center;">
    <a href="forgotPassword.jsp">Resend OTP</a>
</p>

</div>
</body>
</html>
