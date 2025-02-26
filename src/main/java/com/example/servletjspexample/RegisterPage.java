package com.example.servletjspexample;

import com.example.servletjspexample.dao.UserDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "registerPage", value = "/register-page")
public class RegisterPage extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        UserDao userDao = new UserDao();
        String result = "";
        String loginReg = request.getParameter("loginReg");
        String emailReg = request.getParameter("emailReg");
        String passwordReg = request.getParameter("passwordReg");
        long lastId = userDao.getLastId() + 1;

        if ("username".equals(userDao.isUserExist(emailReg, loginReg))) {
            result = "User with this username already exist";
        } else if ("email".equals(userDao.isUserExist(emailReg, loginReg))) {
            result = "User with this email already exist";
        } else if ("nothing".equals(userDao.isUserExist(emailReg, loginReg))){
            result = userDao.addUser(lastId, loginReg, emailReg, passwordReg);
        } else if ("email & username".equals(userDao.isUserExist(emailReg, loginReg))) {
            result = "User with this username & email already exist";
        } else  {
            result = "hi";
        }

        request.setAttribute("registerMessage", result);
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }
}
