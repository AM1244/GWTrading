<%-- 
    Document   : putProduct
    Created on : 12 Ιαν 2016, 2:24:50 πμ
    Author     : thomi
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>



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

        <title>Insert Product</title>
        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
        <!-- Custom styles for this template -->
        
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
            <br>
            <br>
        <div class="col-md-6" >
            <h2> Welcome,<%=userName%> <br>
                <small>Please enter your product's information : <br></small></h2>

            <form method="POST" action="product.do"  enctype="multipart/form-data" >

                <label for="exampleInputPassword1">Type :</label>
                <select name="type" class="form-control" >
                    <option>sugar</option>
                    <option>oil</option>
                    <option>vegetables-grocery</option>
                    <option>meat</option>
                    <option>herbs</option>
                    <option>fish</option>
                    <option>fruit</option>
                </select>
                <br>
                <div class="form-group">
                    <label for="exampleInputPassword1">How much quantity do you sell(in kilos):</label>
                    <input type="number" name="quantity" class="form-control" step="0.5" min="0"  size="20" placeholder="quantity"  /><br>
                </div>

                <div class="form-group">
                    <label for="exampleInputPassword1">How much do you sell it(in euros):</label>
                    <input type="number" name="price" class="form-control" step="0.5" min="0" size="20" placeholder="price" /><br>
                </div>

                <div class="form-group">
                    <label for="exampleInputFile">File input</label>
                    <input type="file" name="file"   /><br>
                </div>

                <div class="form-group">
                    <label for="exampleInputPassword1">Description of the product:</label>
                    <input type="text"  name="description" class="form-control" placeholder="description" height="80" width="200"/><br>
                </div>

                <button class="btn btn-primary" type="submit" >Save product   </button><br>

            </form>

            <form action="logout" method="post">

                <button class="btn btn-default" type="submit" >Logout</button><br>
            </form>


        </div>
        <!-- Footer Menu -->
        <footer class="footer">
            <div class="container">
                <p class="text-muted">Green World Trading-Contributor:<a href="https://github.com/AM1244" target="_blank">Lyka Thomai</a></p>
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

