package com.example.servletjspexample;

import com.example.servletjspexample.dao.UserDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "dashboardPage", value = "/dashboard-pages")
public class LoginPage extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        PrintWriter printWriter = response.getWriter();
        String loginSign = request.getParameter("loginSign");
        String passwordSign = request.getParameter("passwordSign");
        UserDao userDao = new UserDao();
        String passFromDB = userDao.getPassByUsername(loginSign);


        if (passFromDB == null) {
            request.setAttribute("loginMessage", "User not found");
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        } else if (passFromDB.equals(passwordSign)) {
            if ("admin".equalsIgnoreCase(loginSign)) {
                Cookie cookie = new Cookie("username", loginSign);
                response.addCookie(cookie);
                /*RequestDispatcher dispatcher = request.getRequestDispatcher("adminPage.jsp");
                dispatcher.forward(request, response);*/
                response.sendRedirect("adminPage.jsp");
            } else {
                Cookie cookie = new Cookie("username", loginSign);
                response.addCookie(cookie);

                RequestDispatcher dispatcher = request.getRequestDispatcher("userPage.html");
                dispatcher.forward(request, response);
            }
        } else if (!passFromDB.equals(passwordSign)) {
            request.setAttribute("loginMessage", "Wrong password");
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        }
    }
}

