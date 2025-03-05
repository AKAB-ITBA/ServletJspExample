<%@ page import="java.util.List" %>
<%@ page import="com.example.servletjspexample.model.User" %>
<%@ page import="com.example.servletjspexample.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>


<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

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
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.1/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <style>

        element.style {
            border: none !important;
        }

        .btn-danger {
            color: #fff;
            background-color: #d9534f;
            border-color: #d43f3a;

        }

        .btn-danger:focus {
            outline: none !important;
            box-shadow: none !important;
            border: none !important;
        }

        a:focus {
            outline: none !important;
            border: none !important;
        }

        .btn {
            display: inline-block;
            padding: 6px 12px;
            margin-bottom: 0;
            font-size: 14px;
            font-weight: normal;
            line-height: 1.428571429;
            text-align: center;
            white-space: nowrap;
            vertical-align: middle;
            cursor: pointer;
            background-image: none;
            border: none !important;
            border-radius: 4px;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            -o-user-select: none;
            user-select: none;
            outline: none !important;
        }

        .fa {
            display: inline-block;
            font: normal normal normal 14px / 1 FontAwesome;
            font-size: inherit;
            text-rendering: auto;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .fa-trash:before {
            content: "\f1f8";
        }

    </style>

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
    </div>

        <%
    List<User> users = (List<User>) request.getAttribute("users");
    if (users != null && !users.isEmpty()) {
%>


    <div class="section">
        <table class="table">
            <caption>List of users</caption>
            <thead>
            <tr>
                <th scope="col">Id</th>
                <th scope="col">Username</th>
                <th scope="col">New Username</th>
                <th scope="col">Email</th>
                <th scope="col">Password</th>
                <th scope="col">Change Password</th>
                <th scope="col">Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${users}" var="u">
                <tr>
                    <td><c:out value="${u.getId()}"></c:out></td>
                    <td><c:out value="${u.getUserName()}"></c:out></td>
                    <td>
                        <div class="section">
                            <form action="/ServletJspExample_war_exploded/admin-page" method="post"
                                  onsubmit="return confirm('Are you sure you want to change username?');">
                                <input type="hidden" name="action" value="adminChangeUsername">
                                <input type="text" id="usernameToChange" placeholder="Enter new Username"
                                       name="usernameToChange" required>
                                <input type="hidden" name="idForUsernameChange" value="${u.getId()}">
                                <button type="submit" class="btn btn-danger">Change</button>

                            </form>
                        </div>
                    </td>
                    <td><c:out value="${u.getEmail()}"></c:out></td>
                    <td><c:out value="${u.getPassword()}"></c:out></td>
                    <td>
                        <form action="/ServletJspExample_war_exploded/admin-page" method="post"
                              onsubmit="return confirm('Are you sure you want to change password?');">
                            <input type="hidden" name="action" value="adminChangePassword">
                            <input type="text" id="passwordToChange" placeholder="Enter new Password"
                                   name="passwordToChange" required>
                            <input type="hidden" name="usernameToChange" value="${u.getUserName()}">
                            <button type="submit" class="btn btn-danger">Change</button>
                        </form>
                    </td>
                    <td>
                        <div class="section">
                            <form action="/ServletJspExample_war_exploded/admin-page" method="post"
                                  onclick="return confirm('Are you sure you want to delete this user?');">
                                <input type="hidden" name="action" value="deleteUserById">
                                <input type="hidden" name="userIdDel" value="${u.getId()}">
                                <button style="border: none"><a class="btn btn-danger" href="javascript:void(0);">
                                    <i class="fa fa-trash"></i>
                                </a></button>
                            </form>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
        <% } %>
</html>
