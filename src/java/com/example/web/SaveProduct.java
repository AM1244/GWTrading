/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.example.web;

import java.io.IOException;
import java.io.InputStream;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.Part;

import static com.example.web.Loginservlet.session;

/**
 *
 * @author thomi
 */
@WebServlet("/SaveProduct")
@MultipartConfig(maxFileSize = 16177215) // upload file's size up to 16MB
public class SaveProduct extends HttpServlet {

    // database connection settings
    private String dbURL = "jdbc:mysql://localhost:3306/trade_db";
    private String dbUser = "root";
    private String dbPass = "thomi55aa99";

    @Override
    public void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        // gets values of text fields
        String type = request.getParameter("type");
        float quantity = Float.parseFloat(request.getParameter("quantity"));
        float price = Float.parseFloat(request.getParameter("price"));
        InputStream inputStream = null; // input stream of the upload file

        // obtains the upload file part in this multipart request
        Part filePart = request.getPart("photo");
        if (filePart != null) {
            // prints out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());

            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        }

        String description = request.getParameter("description");

        Object user;
        user = session.getAttribute("user");
        String user2 = user.toString();

        Connection conn = null; // connection to the database
        String message = null;  // message will be sent back to client

        try {
            // connects to the database
            DriverManager.registerDriver(new com.mysql.jdbc.Driver());
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);

            // constructs SQL statement
            String sql = "INSERT INTO products (type,quantity,price,photo,description,nameProd) values ( ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, type);
            statement.setFloat(2, quantity);
            statement.setFloat(3, price);

            // fetches input stream of the upload file for the blob column
            if (inputStream != null) {
                // fetches input stream of the upload file for the blob column
                statement.setBinaryStream(4, inputStream,filePart.getSize());
            }

            statement.setString(5, description);
            statement.setString(6, user2);

            // sends the statement to the database server
            int row = statement.executeUpdate();
            if (row > 0) {
                message = "File uploaded and saved into database";

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

            // HttpSession session = request.getSession();
            //   String user = request.getParameter("user");
            // out.println("<html><body>Name: " + user + "\n</body></html>");
        }
    }
}
