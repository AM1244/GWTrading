<%-- 
    Document   : message
    Created on : 12 Ιαν 2016, 2:27:45 πμ
    Author     : thomi
--%>

<%-- 
    Document   : message
    Created on : 5 Ιαν 2016, 1:13:21 μμ
    Author     : thomi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Message</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
        <!-- Custom styles for this template -->
        <link href="css/cover.css" rel="stylesheet">
        <link href="css/sticky-footer.css" rel="stylesheet">
    </head>
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
                <!-- MAIN MENU
            ================================================== -->
                <div class="inner cover"> 
                    <h2>Hello , <%=user%>!</h2><br> 
                    <h3><%=request.getAttribute("Message")%></h3><br>

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


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>



</body>
</html>
</html>

