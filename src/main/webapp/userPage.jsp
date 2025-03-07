<%@ page import="com.example.servletjspexample.dao.UserDao" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="webAppV1.css">
    <title>User page</title>
</head>
<body>

<%
    String username = "";

    Cookie[] cookies = request.getCookies();
    for (Cookie cookie : cookies) {
        if (cookie.getName().equals("username")) {
            username = cookie.getValue();
            break;
        }
    }
%>


<h1 class="title">Sadə user səhifəsinə xoş gəlmisiniz</h1>
<h1 class="title"></h1>

<h2 class="text">Welcome, <%=username%>
</h2>

<p class="text">You have limited access to the system.</p>
<a href="index.jsp" class="back-home">Log out
    <%
        Cookie[] cookiesForLogout = request.getCookies();
        for (Cookie cookie : cookiesForLogout) {
            if (cookie.getName().equals("username")) {
                cookie.setValue("");
                break;
            }
        }
    %>
</a>

<footer>
    <p>&copy; 2025 AKAB Project</p>
</footer>

</body>
</html>
