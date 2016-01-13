/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.example.web;

import static com.example.web.Loginservlet.session;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.imageio.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author thomi
 */
@WebServlet("/UploadServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB

public class UploadServlet extends HttpServlet {
    // database connection settings
    private String dbURL = "jdbc:mysql://localhost:3306/trade_db";
    private String dbUser = "root";
    private String dbPass = "thomi55aa99";

    
    
    private static final String SAVE_DIR = "uploadFiles";
    private static final String LOG_DIR = "log";
    // String OS = "Ubuntu";

    String OS = System.getProperty("os.name");
    
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        
        String type = request.getParameter("type");
        float quantity = Float.parseFloat(request.getParameter("quantity"));
        float price = Float.parseFloat(request.getParameter("price"));
        String description = request.getParameter("description");
        //READ PHOTO
        // gets absolute path of the web application
        
        String appPath = request.getServletContext().getRealPath("");
        
        // constructs path of the directory to save uploaded file
        String savePath = appPath + File.separator +  SAVE_DIR;
        System.out.println("savePath: " + savePath);
        System.out.println("appPath: " + appPath);
        // creates the save directory if it does not exists
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdir();
        }
        String filePos = null;
        Part part=request.getPart("file");
        //for (Part part : request.getParts()) {
            filePos = extractFileName(part);
            System.out.println("filePos: " + filePos);
            part.write(savePath + File.separator + filePos);
        //}

        //get image position in the web filesystem
        if (filePos != null) {
            filePos = extractFileName(savePath) + "/" + filePos;
        }
    //Finish reading
        
        Object user;
        user = session.getAttribute("user");
        String user2 = user.toString();
        //Insert product in DB
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
            statement.setString(4,filePos);
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
            //getServletContext().getRequestDispatcher("/message.jsp").include(request, response);
            
            RequestDispatcher view = request.getRequestDispatcher("message.jsp");
            view.forward(request, response);

           
        }
    }
    
    
    
    
    
    
    
    
    private String extractFileName(String path) {

        String folder = null;
        if (path != null) {

            int i = path.lastIndexOf(File.separator);

            folder = path.substring(i + 1, path.length());

            System.out.println("folder: " + folder);
            return folder;
        }
        return null;
    }

    /**
     * Extracts file name from HTTP header content-disposition
     */
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
