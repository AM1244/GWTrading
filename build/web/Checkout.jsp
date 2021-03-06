<%-- 
    Document   : Checkout
    Created on : 8 Ιαν 2016, 7:26:56 μμ
    Author     : thomi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
                   url="jdbc:mysql://localhost/trade_db"
                   user="root"  password="thomi55aa99"/>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="../../favicon.ico">
        <title>Checkout</title>
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
                        <h1> Thank you for shopping,<%=userName%>! </h1>

                        <sql:query var="res" dataSource="${snapshot}" maxRows="1" >
                            SELECT amount 
                            FROM profile
                            WHERE username="<%=userName%>"

                        </sql:query>
                        <c:set var="returnRes" scope="request" value="${res.rows[0]}"/>
                        
                        <p>Total amount : ${returnRes.amount} euros</p><br>

                        <sql:update var="result" dataSource="${snapshot}">
                            UPDATE profile
                            SET amount=0
                            WHERE username="<%=userName%>"
                        </sql:update>
                        <a href="home.jsp" class="btn btn-primary btn-lg active" role="button">Home</a>
                        <div class="mastfoot">
                            <div class="inner">
                                <p>Green World Trading-Contributor:<a href="https://github.com/AM1244" target="_blank">Lyka Thomai</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <p class="text-right"><a href="home.jsp" class="btn btn-primary btn-lg active" role="button">Home</a></p>
    </body>
</html>
