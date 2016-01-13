<%-- 
    Document   : profile
    Created on : 4 Ιαν 2016, 6:13:01 μμ
    Author     : thomi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

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
        <title>Profile</title>

        <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
        <!-- Custom styles for this template -->
        <link href="css/dashboard.css" rel="stylesheet">
        <link href="css/sticky-footer.css" rel="stylesheet">

    </head>

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


    <sql:query var="result"  dataSource="${snapshot}" >      
        SELECT * from profile WHERE username="<%=user%>"
    </sql:query>

    <sql:query var="result_prod"  dataSource="${snapshot}" >      
        SELECT * from products WHERE nameProd="<%=user%>"
    </sql:query>

    <body>
        <!-- NAVBAR
    ================================================== -->

        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">

                    <a class="navbar-brand" href="#">Green World Trading</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right"> 
                        <li><a href="home.jsp">Home</a></li>
                        <li><a href="profile.jsp">Profile</a></li>
                        <li><a href="contact.jsp">Contact</a></li>
                    </ul>
                    <form class="navbar-form navbar-right">
                        <input type="text" class="form-control" placeholder="Search...">
                    </form>
                </div>
            </div>
        </nav>

        <!-- MAIN MENU
    ================================================== -->
        <div  class="text-center">     
            <h2>Hello , <%=user%>!</h2><br>
        </div>

        <div class="col-md-6">
            <h2> Personal Information: </h2><br>
            <c:forEach var="row" items="${result.rows}">
                <tr>
                <address>
                    <a href="mailto:#"><b>  Email: </b> <c:out value="${row.email}"/></a><br>
                    <b>  Address:</b><c:out value="${row.address}"/><br>
                    <abbr title="Phone"><b>Tel:</b></abbr><c:out value="${row.phone}"/><br>
                </address>
            </tr>
        </c:forEach>

    </div>
    <div class="col-md-6">
        <h2> Items you have for selling: </h2><br>
        <c:forEach var="row" items="${result_prod.rows}">
            <c:set var="flag"  value="${1}"/>
            <tr>
            <b>  Type:</b><c:out value="${row.type}"/><br>
            <b> Quantity:</b><c:out value="${row.quantity}"/><br>
            <b> Description:</b><c:out value="${row.description}"/><br>
            <a style="color: rgb(255, 255, 255);">
                <img src=${row.photo} width="90px" height="75px"><br>
            </a>
            <br>
            </tr>
        </c:forEach>

        <c:choose>
            <c:when test="${flag!=1}">
                <b><strong>Nothing found. Try again </strong></b><br>

            </c:when>  
        </c:choose>

    </div>
    <div  class="text-center"> 
        <h2>Update profile</h2>


        <form method="POST" action="profile.do" >

            <div class="form-group">

                <label for="exampleInputEmail1">Your address:</label><br>
                <div class="col-md-4"></div>
                <div class="col-md-4">                        
                    <input type="text" class="form-control" name="address" value="" />
                </div>
                <div class="col-md-4"></div><br>
            </div>

            <div class="form-group">
                <label >Your phone number:</label><br>
                <div class="col-md-4"></div>
                <div class="col-md-4">                        
                    <input type="text" class="form-control" name="phone" value="" />
                </div>
                <div class="col-md-4"></div><br>
            </div>
            <button type="submit" class="btn btn-default" >Update profile</button><br>

        </form>

        <form action="logout" method="post">

            <button class="btn btn-primary" type="submit" >Logout</button><br>
        </form>
    </div>

    <!-- Footer Menu -->
    <footer class="footer">
        <div class="container">
            <p class="text-muted">Green World Trading-Creator:<a href="https://github.com/AM1244" target="_blank">Lyka Thomai</a></p>
        </div>
    </footer>


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
