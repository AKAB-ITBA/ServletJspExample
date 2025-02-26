package com.example.servletjspexample.servlet;

import com.example.servletjspexample.dao.UserDao;
import com.example.servletjspexample.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "customerServlet", value = "/customers")
public class CustomerServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        UserDao userDao = new UserDao();
        List<User> users = userDao.getAllUsers();

        PrintWriter printWriter = response.getWriter();
        printWriter.print(users);
    }
}
