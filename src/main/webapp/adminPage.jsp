<%@ page import="java.util.List" %>
<%@ page import="com.example.servletjspexample.model.User" %>
<%@ page import="com.example.servletjspexample.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password Modal</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        .modal {
            display: none; /* Başlanğıcda gizlidir */
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fff;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 300px;
            text-align: center;
            border-radius: 10px;
        }

        .close-btn {
            background-color: red;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            margin-top: 10px;
        }

        .close-btn:hover {
            background-color: darkred;

        }

        .confirm-btn {
            background-color: red;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            margin-top: 10px;
        }

        .confirm-btn:hover {
            background-color: darkred;
        }

        .input-field {
            width: 80%;
            padding: 8px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .change-btn {
            background-color: blue;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            margin-top: 10px;
        }

        .change-btn:hover {
            background-color: darkblue;
        }
    </style>
</head>

<button onclick="openModal()" class="change-btn">Change password</button>

<div id="passwordModal" class="modal">
    <div class="modal-content">
        <h3>Change Password</h3>
        <form action="/ServletJspExample_war_exploded/admin-page" method="post">

            <input type="password" class="input-field" name="currentPassword" required>
            <input type="password" class="input-field" name="newPassword" required>
            <input type="password" class="input-field" name="confirmPassword" required>
            <input type="hidden" name="action" value="confirmPasswordChange" required>
            <button type="submit">Confirm</button>
            <button class="close-btn" onclick="closeModal()">Close</button>
        </form>
    </div>
</div>

<script>
    function openModal() {
        document.getElementById("passwordModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("passwordModal").style.display = "none";
    }

</script>

<link rel="stylesheet" href="webAppV1.css">
<title>Admin Page</title>

</head>
<body>

<h2 class="title">Admin Page</h2>

<div class="container">
    <div class="section">
        <form action="/ServletJspExample_war_exploded/admin-page" method="post">
            <input type="hidden" name="action" value="getUsers" required>
            <button type="submit">View all users</button>
            <div id="usernameField">
                <pre><%= request.getAttribute("usernameField") != null ? request.getAttribute("usernameField") : "" %></pre>
            </div>
        </form>
    </div>


    <div class="section">
        <form action="/ServletJspExample_war_exploded/admin-page" method="post">
            <input type="hidden" name="action" value="deleteUserById">
            <label for="userIdToDelete">Enter User ID to Delete:</label>
            <input type="text" id="userIdToDelete" name="userIdDel" required>
            <button type="submit">Delete user by ID</button>
        </form>
    </div>

    <div class="section">
        <form action="/ServletJspExample_war_exploded/admin-page" method="post">
            <input type="hidden" name="action" value="findUserById">
            <label for="userId">Enter User ID to Search:</label>
            <input type="text" id="userId" name="userId" required>
            <button type="submit">Search user by ID</button>
        </form>
    </div>

    <div class="section">
        Result module:
        <pre><%= request.getAttribute("output") != null ? request.getAttribute("output") : "" %></pre>
    </div>


    <%
        List<User> users = (List<User>) request.getAttribute("users");
        if (users != null && !users.isEmpty()) {
    %>

    <c:forEach items="${users}" var="u">
        <c:out value="${u}"></c:out>
        <br>
    </c:forEach>


    ${f:contains("sentence", "char")}



    <%--<div class="section">
        <table border="1">
            <thead>
            <tr>
                <th>ID</th>
                <th>UserName</th>
                <th>Email</th>
                <th>Password</th>
            </tr>
            </thead>
            <tbody>
            <% for (User user : users) { %>
            <tr>
                <td><%= user.getId() %>
                </td>
                <td><%= user.getUserName() %>
                </td>
                <td><%= user.getEmail() %>
                </td>
                <td><%= user.getPassword() %>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <% } %>--%>

    <div class="section">
        <table class="table table-sm">
            <thead>
            <tr>
                <th>ID</th>
                <th>UserName</th>
                <th>Email</th>
                <th>Password</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${users}" var="u">
            <tr>
                <td><c:out value="${u.getId()}"></c:out></td>
                <td><c:out value="${u.getUserName()}"></c:out></td>
                <td><c:out value="${u.getEmail()}"></c:out></td>
            </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <% } %>

</div>

<div class="back-to-home">
    <a href="index.jsp" class="back-home">Back to Home</a>
</div>

<footer>
    <p>&copy; 2025 AKAB Project</p>
</footer>

</body>
</html>