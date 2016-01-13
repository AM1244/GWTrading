/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.example.web;

import static com.example.web.Loginservlet.session;

import java.io.IOException;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author thomi
 */
public class ShoppingCart extends HttpServlet {

    // database connection settings
    private String dbURL = "jdbc:mysql://localhost:3306/trade_db";
    private String dbUser = "root";
    private String dbPass = "thomi55aa99";

    public void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        String user = null;
        if (session.getAttribute("user") == null) {
            response.sendRedirect("index.jsp");
        } else {
            user = (String) session.getAttribute("user");
        }
        String userName = null;
        String sessionID = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("user")) {
                    userName = cookie.getValue();
                }
                if (cookie.getName().equals("JSESSIONID")) {
                    sessionID = cookie.getValue();
                }
            }
        }
        float currAmount = 0;
        float productPrice = 0;
        float totalAmount;
        float quantity;
        float remainingQuantity;
        float productQuantity = 0;

        //Get parameters from jsp
        int checkedItem = Integer.parseInt(request.getParameter("chkItem"));
        
        quantity = Float.parseFloat(request.getParameter("quantityBuyer"));
        

        Connection conn = null; // connection to the database
        String message = null;  // message will be sent back to client
        try {
            // connects to the database
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            //Find price of the selected product
            String sql = "SELECT price,quantity FROM products WHERE id='" + checkedItem + "'";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                productPrice = rs.getFloat("price");
                productQuantity = rs.getFloat("quantity");
            }
            rs.close();

            //Find current amount of user
            String sqlUser = "SELECT amount FROM profile WHERE username='" + user + "'";
            Statement stmtUser = conn.createStatement();
            ResultSet rsUser = stmtUser.executeQuery(sqlUser);
            if (rsUser.next()) {
                currAmount = rsUser.getFloat("amount");
            }
            rsUser.close();
            //Count total amount
            totalAmount = currAmount + (productPrice * quantity);
            message = "Total amount:" + totalAmount + "\n";

            //Update amount of user
            String sqlUpd = "UPDATE profile SET amount='" + totalAmount + "' WHERE username='" + user + "' ";
            Statement stmtUpd = conn.createStatement();
            int rsUpd = stmtUpd.executeUpdate(sqlUpd);

            //Update remaing quantity of checked product
            remainingQuantity = productQuantity - quantity;
            String sqlProd = "UPDATE products SET quantity='" + remainingQuantity + "' WHERE id='" + checkedItem + "' ";
            Statement stmtProd = conn.createStatement();
            int rsProd = stmtProd.executeUpdate(sqlProd);

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
            RequestDispatcher view = request.getRequestDispatcher("ShoppingCart.jsp");
            view.forward(request, response);
        }

    }
}
