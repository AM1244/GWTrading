<%-- 
    Document   : index
    Created on : 11 Ιαν 2016, 10:49:47 μμ
    Author     : thomi
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
    
    <meta name="keywords" content="html5, css3, form, switch, animation, :target, pseudo-class" />
    <meta name="author" content="Codrops" />
    <link rel="shortcut icon" href="../favicon.ico"> 
    <link rel="stylesheet" type="text/css" href="css/demo.css" />
    <link rel="stylesheet" type="text/css" href="css/style3.css" />
    <link rel="stylesheet" type="text/css" href="css/animate-custom.css" />

    <title>User- Login</title>


</head>
<body>




    <% String error=(String)request.getAttribute("error");
        if (error != null) { %>
        <div><%=error%>
        <%
           }
    %>



    <div class="container">
        <header>
            <h1>WELCOME<span> TO GREEN WORLD TRADING</span></h1>

        </header>
        <section>				
            <div id="container_demo" >
                <!-- hidden anchor to stop jump http://www.css3create.com/Astuce-Empecher-le-scroll-avec-l-utilisation-de-target#wrap4  -->

                <div id="wrapper">
                    <div id="login" class="animate form">
                        <form method="post" action="login.do" class="form-signin">
                            <h1>Log in</h1> 
                            <p> 
                                <label for="username" class="uname" data-icon="u" > Your username </label>
                                <input id="username" name="username" required="required" type="text" placeholder="myusername or mymail@mail.com"/>
                            </p>
                            <p> 
                                <label for="password" class="youpasswd" data-icon="p"> Your password </label>
                                <input id="password" name="pass" required="required" type="password" placeholder="eg. X8df!90EO" /> 
                            </p>

                            <p class="login button"> 
                                <input type="submit" value="Login" /> 
                            </p>

                        </form>
                    </div>




                </div>
            </div>  
        </section>
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
