<%-- 
    Document   : DisplayItems
    Created on : 28 Δεκ 2015, 10:27:26 μμ
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
        <title>Display Products</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
        <!-- Custom styles for this template -->
        <link href="css/dashboard.css" rel="stylesheet">
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
        <sql:query var="returnRes"  dataSource="${snapshot}">      
            SELECT * FROM products as s 
            <c:choose>
                <c:when test="${param.select_type != 'alls'}">
                    WHERE s.type= ? <sql:param value="${param.select_type}"  /> AND s.nameProd<>"<%=userName%>"
                </c:when>
                <c:otherwise>
                    WHERE s.type IS NOT NULL AND s.nameProd<>"<%=userName%>"
                </c:otherwise>            
            </c:choose>
        </sql:query>

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




            <h1>Welcome,<%=userName%>!</h1><br>





            <c:forEach var="row" items="${returnRes.rows}">
                <div class="col-md-4">
                    <form action="cart.do" method="POST" >
                        <c:set var="flag"  value="${1}"/>
                        <br>
                        <img src=${row.photo} width="90px" height="75px"><br>
                        <strong>Details:</strong> <br>
                        <strong>Type:</strong><span>${row.type}     <strong>Quantity</strong>${row.quantity}</span><br>

                        <strong>Price:</strong>${row.price}         <strong>Name of Producer: </strong>${row.nameProd}</span> <br>                        
                        <strong>Description:</strong>${row.description} <br>
                        <strong>Quantity you want to buy:</strong>
                        <input type="number" name="quantityBuyer"  step="0.5" min="0"  size="20" placeholder="quantity" required  /><br>

                        <button  type="submit" name="chkItem"class="btn btn-primary" value=${row.id}>Add to Cart</button><br>

                    </form>
                </div>
            </c:forEach>

            <br>




            <c:choose>
                <c:when test="${flag!=1}">
                    <td><strong>Nothing found. Try again </strong></td><br>
                    <a href="home.jsp" class="btn btn-primary btn-lg active" role="button">Home</a><br>
                </c:when>  
            </c:choose>

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
