<%--
  Created by IntelliJ IDEA.
  User: AbdullayevAkbar
  Date: 06-Mar-25
  Time: 11:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.servletjspexample.model.User" %>
<%@ page import="com.example.servletjspexample.model.User" %>

<html>
<head>
    <title>Welcome to - Profile edit page</title>
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
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.1/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

    <style>
        .btn {
            display: inline-block;
            padding: 6px 12px;
            margin-bottom: 0;
            font-size: 14px;
            font-weight: 400;
            line-height: 1.42857143;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            -ms-touch-action: manipulation;
            touch-action: manipulation;
            cursor: pointer;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            background-image: none;
            border: 1px solid transparent;
            border-radius: 4px;
        }
        .btn {
            border-radius: 3px;
        }
        .btn-info.active, .btn-info.focus, .btn-info:active, .btn-info:focus, .btn-info:hover, .open>.dropdown-toggle.btn-info {
            color: #fff;
            background-color: #31b0d5;
            border-color: #269abc;
        }

    </style>
</head>
<body>

<%
    long id;

    Cookie[] cookies = request.getCookies();
    for (Cookie cookie : cookies) {
        if (cookie.getName().equals("id")) {
            id = Long.parseLong(cookie.getValue());
            break;
        }
    }
%>

<%
    User user = (User) request.getAttribute("user");
    String username  = "";
    String email= "";
    if (user != null) {
        username = user.getUserName();
        email = user.getEmail();
    }
%>
<c:forEach items="${users}" var="u">
<h1 class="title"></h1>

<h2 class="text">Profile edit page</h2>
<div class="section">
    Result module:
    <pre><%= request.getAttribute("output") != null ? request.getAttribute("output") : "" %></pre>
</div>
<a href="newAdminPage.jsp" class="back-home">Back to admin page
    <%
        Cookie[] cookiesForLogout = request.getCookies();
        for (Cookie cookie : cookiesForLogout) {
            if (cookie.getName().equals("id")) {
                cookie.setValue("");
                break;
            }
        }
    %>
</a>

    <div class="form-group">
        <form action="/ServletJspExample_war_exploded/edit-page" method="post"
              onsubmit="return confirm('Are you sure you want to change username?');">
            <input type="hidden" name="action" value="adminChangeUsername">
        <label for="usernameToChange">Change username</label>
        <input type="text" class="form-control" id="usernameToChange" name="usernameToChange" placeholder="test" value="<%= username %>" required>
            <button type="submit" class="btn btn-info">Change</button>
        </form>
    </div>



    <div class="form-group">
        <form action="/ServletJspExample_war_exploded/edit-page" method="post"
              onsubmit="return confirm('Are you sure you want to change email?');">
            <input type="hidden" name="action" value="adminChangeEmail">
        <label for="emailToChange">Change email</label>
        <input type="email" class="form-control" id="emailToChange" name="emailToChange" placeholder="name@example.com" value="<%= email %>" required>
            <button type="submit" class="btn btn-info">Change</button>
        </form>
    </div>
</body>
</html>