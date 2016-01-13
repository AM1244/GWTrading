
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.example.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import static com.example.web.Loginservlet.session;

/**
 *
 * @author thomi
 */
public class ProfileServlet extends HttpServlet {

    //DATABASE DETAILS
    private static String db = "jdbc:mysql://localhost:3306/trade_db";
    private static String dbUSER = "root";
    private static String dbPSW = "thomi55aa99";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    public void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {

        //connect to database
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(db, dbUSER, dbPSW);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Loginservlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Loginservlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        String foo = "";
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        //Find User
        Object user;
        user = session.getAttribute("user");
        String user2 = user.toString();
        String message = null;  // message will be sent back to client
        PreparedStatement statement;
        try {

            // connects to the database
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            conn = DriverManager.getConnection(db, dbUSER, dbPSW);

            if (address.equals(foo)) {
                statement = conn.prepareStatement("UPDATE profile SET  phone='" + phone + "' WHERE username='" + user2 + "' ");
            } else if (phone.equals(foo)) {
                statement = conn.prepareStatement("UPDATE profile SET address='" + address + "' WHERE username='" + user2 + "' ");

            } else {           
                statement = conn.prepareStatement("UPDATE profile SET address=?, phone=? WHERE username='" + user2 + "' ");
                statement.setString(1, address);
                statement.setString(2, phone);
            }
            int row = statement.executeUpdate();
            if (row > 0) {
                message = "Profile updated \n";

            }
        } catch (SQLException ex) {
            message = "ERROR: " + ex.getMessage();
            ex.printStackTrace();
        } finally {
            if (conn != null) {
                // closes the database connection
                try {
                    conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            // sets the message in request scope
            request.setAttribute("Message", message);

            // forwards to the message page
            getServletContext().getRequestDispatcher("/message.jsp").include(request, response);
        }
    }
}
