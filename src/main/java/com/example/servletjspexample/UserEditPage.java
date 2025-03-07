package com.example.servletjspexample;

import com.example.servletjspexample.dao.UserDao;
import com.example.servletjspexample.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;
import java.util.List;


@WebServlet(name = "userEditPage", value = "/edit-page")
public class UserEditPage extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String result = "";
        UserDao userDao = new UserDao();
        long id = 0;
        String action = request.getParameter("action");

        if ("editUserProfile".equals(action)) {
            id = Long.parseLong(request.getParameter("userId"));
            User user = userDao.getUserById(id);
            request.setAttribute("user", user);
            Cookie cookie = new Cookie("id", request.getParameter("userId"));
            response.addCookie(cookie);
        } else if ("adminChangeUsername".equals(action)) {
            String usernameToChange = request.getParameter("usernameToChange");
            Cookie[] cookiesForUsernameChange = request.getCookies();
            for (Cookie cookie : cookiesForUsernameChange) {
                if (cookie.getName().equals("id")) {
                    id = Long.parseLong(cookie.getValue());
                    break;
                }
            }
            result = userDao.changeUsername(id, usernameToChange);
            request.setAttribute("output", result);
        } else if ("adminChangeEmail".equals(action)) {
            String emailToChange = request.getParameter("emailToChange");
            Cookie[] cookiesForEmailChange = request.getCookies();
            for (Cookie cookie : cookiesForEmailChange) {
                if (cookie.getName().equals("id")) {
                    id = Long.parseLong(cookie.getValue());
                    break;
                }
            }
            result = userDao.changeEmail(id, emailToChange);
            request.setAttribute("output", result);
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("profileEditPage.jsp");
        dispatcher.forward(request, response);
    }
}
