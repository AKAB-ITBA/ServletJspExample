package com.example.servletjspexample;

import com.example.servletjspexample.dao.UserDao;
import com.example.servletjspexample.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "dashboardPage", value = "/dashboard-page")
public class LoginPage extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String loginSign = request.getParameter("loginSign");
        String passwordSign = request.getParameter("passwordSign");
        UserDao userDao = new UserDao();
        String passFromDB = userDao.getPassByUsername(loginSign);

        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            Cookie[] cookiesForLogout = request.getCookies();
            if (cookiesForLogout != null) {
                for (Cookie cookie : cookiesForLogout) {
                    if (cookie.getName().equals("username")) {
                        cookie.setValue("");
                        cookie.setMaxAge(0);
                        response.addCookie(cookie);
                        break;
                    }
                }
            }
        }
        if (passFromDB == null) {
            request.setAttribute("loginMessage", "User not found");
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        } else if (passFromDB.equals(passwordSign)) {
            if ("admin".equalsIgnoreCase(loginSign)) {
                Cookie cookie = new Cookie("username", loginSign);
                response.addCookie(cookie);
                response.sendRedirect("newAdminPage.jsp");
            } else {
                Cookie cookie = new Cookie("username", loginSign);
                response.addCookie(cookie);

                RequestDispatcher dispatcher = request.getRequestDispatcher("userPage.jsp");
                dispatcher.forward(request, response);
            }
        } else if (!passFromDB.equals(passwordSign)) {
            request.setAttribute("loginMessage", "Wrong password");
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        }
    }
}