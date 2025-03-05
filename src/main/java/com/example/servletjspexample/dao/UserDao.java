package com.example.servletjspexample.dao;

import com.example.servletjspexample.db.DatabaseConnection;
import com.example.servletjspexample.model.User;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class UserDao extends Database {

    public List<User> getAllUsers() {
        String sql = "select * from customers";
        List<User> users = new ArrayList<>();
        try (DatabaseConnection dbc = new DatabaseConnection()) {
            conn = dbc.getConnection();
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                User user = new User();
                user.setId(resultSet.getLong(1));
                user.setUserName(resultSet.getString(2));
                user.setEmail(resultSet.getString(3));
                user.setPassword(resultSet.getString(4));
                users.add(user);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {
            closeAll();
        }
        return users;
    }

    public String addUser(long id, String username, String email, String password) {
        String sql = "insert into customers (id, userName, email, password) values ( ?, ?, ?, ?)";
        try (DatabaseConnection dbc = new DatabaseConnection()) {
            conn = dbc.getConnection();
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setLong(1, id);
            preparedStatement.setString(2, username);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, password);
            preparedStatement.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {
            closeAll();
        }
        return "User with id - " + id + " added";
    }

    public List<User> getUserById(long id) {
        String sql = "select * from customers where id = " + id;
        List<User> users = new ArrayList<>();
        try (DatabaseConnection dbc = new DatabaseConnection()) {
            conn = dbc.getConnection();
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                User user = new User();
                user.setId(resultSet.getLong(1));
                user.setUserName(resultSet.getString(2));
                user.setEmail(resultSet.getString(3));
                user.setPassword(resultSet.getString(4));
                users.add(user);
                return users;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {
            closeAll();
        }
        return Collections.emptyList();
    }

    public String deleteUserById(long id) {
        String sql = "delete from customers WHERE  id =? ";
        try (DatabaseConnection dbc = new DatabaseConnection()) {
            conn = dbc.getConnection();
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setLong(1, id);
            preparedStatement.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {
            closeAll();
        }
        return "Customer with id - " + id + " deleted";
    }

    public String getPassByUsername(String username) {
        String sql = "select * from customers where username = ?";

        String password = null;
        try (DatabaseConnection dbc = new DatabaseConnection()) {
            conn = dbc.getConnection();
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                password = resultSet.getString(4);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {
            closeAll();
        }
        return password;
    }

    public long getLastId() {
        String sql = "select max(id) as max_id from customers";
        long id = 0;
        try (DatabaseConnection dbc = new DatabaseConnection()) {
            conn = dbc.getConnection();
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                id = resultSet.getLong("max_id");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {
            closeAll();
        }
        return id;
    }

    public String isUserExist(String email, String username) {
        String sql = "SELECT email, username FROM customers WHERE email = ? OR username = ?";
        String emailForFlag = "";
        String usernameForFlag = "";
        boolean isEmailExist = false;
        boolean isUsernameExist = false;
        String whatExist = "";
        try (DatabaseConnection dbc = new DatabaseConnection()) {
            conn = dbc.getConnection();
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, username);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String dbEmail = resultSet.getString("email");
                String dbUsername = resultSet.getString("username");

                if (dbEmail != null && dbEmail.equals(email)) {
                    isEmailExist = true;
                }
                if (dbUsername != null && dbUsername.equals(username)) {
                    isUsernameExist = true;
                }
            }

            if (isEmailExist && isUsernameExist) {
                return "email & username";
            } else if (isEmailExist) {
                return "email";
            } else if (isUsernameExist) {
                return "username";
            } else {
                return "nothing";
            }

        } catch (SQLException | IOException e) {
            throw new RuntimeException(e);
        } finally {
            closeAll();
        }

    }

    public String changePass(String username, String newPassword){
        String sql = "UPDATE customers SET password = ? WHERE  username =?";
        try (DatabaseConnection dbc = new DatabaseConnection()) {
            conn = dbc.getConnection();
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, newPassword);
            preparedStatement.setString(2, username);
            preparedStatement.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {
            closeAll();
        }
        return "Password successfully changed";
    }

    public String changeUsername(long id, String newUsername) {
        String sql = "UPDATE customers SET username = ? WHERE  id =?";
        try (DatabaseConnection dbc = new DatabaseConnection()) {
            conn = dbc.getConnection();
            PreparedStatement preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, newUsername);
            preparedStatement.setLong(2, id);
            preparedStatement.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {
            closeAll();
        }
        return "Password successfully changed";
    }

}