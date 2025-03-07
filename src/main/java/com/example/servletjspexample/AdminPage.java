package com.example.servletjspexample;

import com.example.servletjspexample.dao.UserDao;
import com.example.servletjspexample.model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "adminPage", value = "/admin-page")
public class AdminPage extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String result = "";
        UserDao userDao = new UserDao();
        String username = "";

        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("username")) {
                username = cookie.getValue();
                break;
            }
        }
        request.setAttribute("usernameField", "Hi " + username);

        String action = request.getParameter("action");
        if ("getUsers".equals(action)) {
                List<User> users = userDao.getAllUsers();
                if (users.isEmpty()) {
                    request.setAttribute("output", "There is no any users on DB");
                } else {
                    request.setAttribute("users", users);
                }

        } else if ("deleteUserById".equals(action)) {
            long id = Long.parseLong(request.getParameter("userIdDel"));
            if (userDao.getUserById(id) !=null) {
                request.setAttribute("output", "There is no users with id - " + id);
            } else {
                userDao.deleteUserById(id);
                List<User> updatedUsers = userDao.getAllUsers();
                if (updatedUsers.isEmpty()) {
                    request.setAttribute("output", "There is no any users on DB");
                } else {
                    request.setAttribute("users", updatedUsers);
                }

            }
        } else if ("findUserById".equals(action)) {
            long id = Long.parseLong(request.getParameter("userId"));
            User user = userDao.getUserById(id);
            if (user !=null) {
                request.setAttribute("output", "There is no users with id - " + id);
            } else {
                request.setAttribute("users", user);
            }
        } else if ("confirmPasswordChange".equals(action)) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            if (newPassword.equals(confirmPassword)) {
                if (userDao.getPassByUsername(username).equals(currentPassword)) {
                    result = userDao.changePass(username, newPassword);
                    request.setAttribute("output", result);
                } else {
                    request.setAttribute("output", "Current password is wrong");
                }
            } else {
                request.setAttribute("output", "New password and confirmation password is not same");
            }
        } else if ("adminChangePassword".equals(action)) {
            String passwordToChange = request.getParameter("passwordToChange");
            String usernameToChange = request.getParameter("usernameToChange");
            result = userDao.changePass(usernameToChange, passwordToChange);
            request.setAttribute("output", result);

        } else if ("adminChangeUsername".equals(action)) {
            String usernameToChange = request.getParameter("usernameToChange");
            long id = Long.parseLong(request.getParameter("idForUsernameChange"));
            result = userDao.changeUsername(id, usernameToChange);
            request.setAttribute("output", result);
        } else if ("searchUser".equals(action)) {
            String users = request.getParameter("usernameToSearch");
            List<User> usersFromSearch = userDao.searchUser(users);

           if (!usersFromSearch.isEmpty()) {
               request.setAttribute("users", usersFromSearch);
            }
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("newAdminPage.jsp");
        dispatcher.forward(request, response);
    }
}

