<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Reset Password</title>
<style>
body { font-family: Poppins; background: #f9fafb; }
.container {
    width: 380px;
    margin: 120px auto;
    background: #fff;
    padding: 30px;
    border-radius: 10px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}
h2 { text-align: center; color: #333; }
input, button {
    width: 100%;
    padding: 12px;
    margin: 15px 0;
    border-radius: 6px;
    border: 1px solid #ccc;
}
button {
    background: #2196F3;
    color: white;
    border: none;
}
button:hover { background: #1976D2; }
</style>
</head>

<body>
<div class="container">
    <h2>Reset Password</h2>

    <form action="resetPassword" method="post">
        <input type="password" name="newpass" placeholder="New Password" required>
        <button type="submit">Update Password</button>
    </form>

</div>
</body>
</html>
