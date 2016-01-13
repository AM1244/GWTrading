

<%-- 
    Document   : showProduct
    Created on : 28 Δεκ 2015, 7:46:06 μμ
    Author     : thomi
--%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
                   url="jdbc:mysql://localhost/trade_db"
                   user="root"  password="thomi55aa99"/>



<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="../../favicon.ico">
        <title>Home Page</title>

        <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
        <!-- Custom styles for this template -->
        <link href="css/cover.css" rel="stylesheet">
        <link href="css/sticky-footer.css" rel="stylesheet">
    </head>

    <body>
        <%
//allow access only if session exists
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
        %>


        <div class="site-wrapper">

            <div class="site-wrapper-inner">

                <div class="cover-container">
                    <div class="masthead clearfix">
                        <div class="inner">
                            <h3 class="masthead-brand">Green World Trading</h3>
                            <nav>
                                <ul class="nav masthead-nav">
                                    <li class="active"><a href="home.jsp">Home</a></li>
                                    <li><a href="profile.jsp">Profile</a></li>
                                    <li><a href="contact.jsp">Contact</a></li>
                                    
                                </ul>
                            </nav>
                        </div>
                    </div>

                    <div class="inner cover">
                        <h1 class="cover-heading">Welcome,<%=user%><br></h1>
                        <p class="lead">Start Shopping now <a href="QueryItems.jsp" class="btn btn-primary btn-lg active" role="button">Click here</a><br>
                            <br>
                            Sell your product <a href="putProduct.jsp" class="btn btn-primary btn-lg active" role="button">Click here</a><br>
                            <br>
                            Check your profile <a href="profile.jsp" class="btn btn-primary btn-lg active" role="button">Click here</a><br></p>
                        <br>
                        <form action="logout" method="post">

                            <button class="btn btn-default" type="submit" >Logout</button><br>
                        </form>

                        <div class="mastfoot">
                            <div class="inner">
                                <p>Green World Trading-Contributor:<a href="https://github.com/AM1244" target="_blank">Lyka Thomai</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap core JavaScript
================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
        <script src="../../dist/js/bootstrap.min.js"></script>
        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
    </body>
</html>


