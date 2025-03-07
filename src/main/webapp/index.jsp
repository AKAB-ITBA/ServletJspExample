<%@ page import="java.io.PrintWriter" %>
<%@ page errorPage="error.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="webAppV1.css">
    <title>JSP - Project</title>
    <style>
        .container {
            display: flex;
            justify-content: space-around;
        }
        .form-container {
            width: 45%;
        }
        .message {
            margin-top: 10px;
            font-weight: bold;
            color: black;
        }
    </style>
</head>
<body>

<div class="text-style">
    <p class="text">Salam, Hesabda qeydiyyat və giriş üçün aşağıdakı hissələrə məlumatları daxil edin</p>
</div>

<div class="container">
    <div class="form-container">
        <h3 class="title">Qeydiyyat Forması</h3>
        <form action="/ServletJspExample_war_exploded/register-page" method="post">
            <label for="emailReg">Email:</label><br>
            <input type="text" id="emailReg" name="emailReg" placeholder="type email" required><br>

            <label for="loginReg">Login:</label><br>
            <input type="text" id="loginReg" name="loginReg" placeholder="type login" required><br>

            <label for="passwordReg">Password:</label><br>
            <input type="password" id="passwordReg" name="passwordReg" placeholder="type password" required><br>

            <input type="submit" value="Register">
        </form>

        <div class="message">
            <%= request.getAttribute("registerMessage") != null ? request.getAttribute("registerMessage") : "" %>
        </div>
    </div>

    <div class="form-container">
        <h3 class="title">Login</h3>
        <form action="/ServletJspExample_war_exploded/dashboard-page" method="post">
            <label for="loginSign">Login:</label><br>
            <input type="text" id="loginSign" name="loginSign" placeholder="type login" required><br>

            <label for="passwordSign">Password:</label><br>
            <input type="password" id="passwordSign" name="passwordSign" placeholder="type password" required><br>

            <input type="submit" value="Sign in">
        </form>

        <!-- Login mesajı -->
        <div class="message">
            <%= request.getAttribute("loginMessage") != null ? request.getAttribute("loginMessage") : "" %>
        </div>
    </div>
</div>

<footer>
    <p>&copy; 2025 AKAB Project</p>
</footer>

</body>
</html>
