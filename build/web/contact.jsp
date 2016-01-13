<%-- 
    Document   : contact
    Created on : 8 Ιαν 2016, 11:20:32 μμ
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
        <title>Contact</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
        <!-- Bootstrap core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
        <!-- Custom styles for this template -->
        <link href="css/dashboard.css" rel="stylesheet">
        <link href="css/sticky-footer.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
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
        <div  class="text-center">     

            <br>
            <form action="home.jsp" class="contact">
    <fieldset class="contact-inner">
      <p class="contact-input">
        <input type="text" name="name" placeholder="Your Name…" autofocus>
      </p>

      <p class="contact-input">
        <label for="select" class="select">
          <select name="subject" id="select">
            <option value="" selected>Choose Subject…</option>
            <option value="1">I have a suggestion</option>
            <option value="1">I found a bug</option>
            <option value="1">Other</option>
          </select>
        </label>
      </p>

      <p class="contact-input">
        <textarea name="message" placeholder="Your Message…"></textarea>
      </p>

      <p class="contact-submit">
        <input type="submit" value="Send Message" >
      </p>
    </fieldset>
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

</html>
