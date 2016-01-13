/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.example.web;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.*;
import javax.naming.directory.*;
import java.util.Hashtable;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Loginservlet extends HttpServlet {

    //private static final long serialVersionUID = 1L;
    public String getName() {
        if (auth) {
            return atr.get("cn").toString().replace("cn: ", "");
        }
        return "Not authenticated";
    }

    public String getUsername() {
        if (auth) {
            return atr.get("uid").toString().replace("uid: ", "");
        }
        return "Not authenticated";
    }

    public String getMail() {
        if (auth) {
            return atr.get("mail").toString().replace("mail: ", "");
        }
        return "Not authenticated";
    }

    //DETAILS OF MY DATABASE
    private final static String db = "jdbc:mysql://localhost:3306/trade_db";
    private final static String dbUSER = "root";
    private final static String dbPSW = "thomi55aa99";

    public static boolean auth = false;
    private Attributes atr;
    private PreparedStatement pstmt;
    public static HttpSession session;

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    @Override
    public void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws IOException, ServletException {

        String user = "";
        String pass = "";
        String mes = "";

        //connect to my database
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(db, dbUSER, dbPSW);

            user = request.getParameter("username");
            pass = request.getParameter("pass");

            // Set up ldap environment
            Hashtable<String, String> env = new Hashtable<String, String>();
            env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
            env.put(Context.PROVIDER_URL, "ldap://ldap.uth.gr:389/");
            // Authenticate as S.User and password "mysecret"
            env.put(Context.SECURITY_PRINCIPAL, "uid=" + user + ", ou=People, dc=uth,dc=gr");
            env.put(Context.SECURITY_AUTHENTICATION, "simple");
            env.put(Context.SECURITY_CREDENTIALS, pass);

            DirContext ctx = new InitialDirContext(env);

            atr = ctx.getAttributes("uid=" + user + ", ou=People, dc=uth, dc=gr");
            auth = true;

            ctx.close();

        } catch (ClassNotFoundException | AuthenticationException ex) {
            //Logger.getLogger(Authservlet.class.getName()).log(Level.SEVERE, null, ex);
            auth = false;
            mes = "ClassNotFoundException";
        } catch (NamingException ex) {
            //Logger.getLogger(Authservlet.class.getName()).log(Level.SEVERE, null, ex);
            auth = false;
            mes = "NamingException";
        } catch (SQLException ex) {
            auth = false;
            mes = "SQLException";
        }

        
        out.println("<html><body>Auth: " + auth + "\n</body></html>");
        out.println("<html><body>Message: " + mes + "\n</body></html>");
        
        if (auth) {

            

            try {
                stmt = conn.createStatement();

                //db query for current user
                rs = stmt.executeQuery("SELECT * FROM profile WHERE username='" + user + "'");

                //HttpSession session;
                if (rs.next()) { //user exists in my db

                    out.println("<html><body>The user exists " + getName() + "\n</body></html>");

                    session = request.getSession();
                    session.setAttribute("user", user);
                    //setting session to expiry in 3 mins
                    session.setMaxInactiveInterval(3 * 60);
                    Cookie loginCookie = new Cookie("user", user);
                    loginCookie.setMaxAge(3 * 60);
                    response.addCookie(loginCookie);

                    RequestDispatcher view = request.getRequestDispatcher("home.jsp");

                    out.println("<html><body>User exists: " + user + "<br> </body></html>");
                    out.println("<html><body>User exists: " + getName() + "<br></body></html>");

                    view.forward(request, response);

                } else { //user doesnt exist-insert into my db

                    String mail = getMail();

                    out.println("<html><body>Insert the user " + user + "\n</body></html>");

                    session = request.getSession();
                    session.setAttribute("user", user);
                    //setting session to expiry in 3 mins
                    session.setMaxInactiveInterval(3 * 60);
                    Cookie loginCookie = new Cookie("user", user);
                    loginCookie.setMaxAge(3 * 60);
                    response.addCookie(loginCookie);

                    pstmt = conn.prepareStatement("INSERT INTO profile (username, email,address,phone,amount) VALUES (?,?,?,?,?)");
                    pstmt.setString(1, user);
                    // pstmt.setString(2, affil);
                    pstmt.setString(2, mail);
                    pstmt.setString(3, "");
                    pstmt.setString(4, "");
                    pstmt.setFloat(5, 0);
                    pstmt.executeUpdate();
                    pstmt.close();

                    RequestDispatcher view = request.getRequestDispatcher("home.jsp");
                    view.forward(request, response);

                }

            } catch (SQLException ex) {
                System.out.println("exception in sql");
                Logger.getLogger(Loginservlet.class.getName()).log(Level.SEVERE, null, ex);

            }
        } else {

            request.setAttribute("error", "Invalid Username or Password\n"
                    + "Please, try again!");
            RequestDispatcher view = request.getRequestDispatcher("index.jsp");
            view.forward(request, response);
        }
    }
}
