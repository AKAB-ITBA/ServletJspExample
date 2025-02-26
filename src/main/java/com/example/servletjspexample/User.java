package com.example.servletjspexample;

public class User {
    private final String email;
    private final String login;
    private final String pass;

    public User(String email, String login, String pass) {
        this.email = email;
        this.login = login;
        this.pass = pass;
    }

    @Override
    public String toString() {
        return this.email + ", " + this.login + ", " + this.pass + "\n";
    }
}
