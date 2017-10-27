<%-- 
    Document   : Iniciarsesion
    Created on : 24/10/2017, 01:24:08 PM
    Author     : stephiRM
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="../Bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="../CSS/Estilos.css">
        <link type="image/x-icon" rel="shortcut icon"  href="/EspotifyWeb/Imagenes/espotifyIcono.ico">
        <title>Espotify: Iniciar sesión</title>
    </head>
    <body>
          <center>
            <div class="container">
                <div class="row">
                    <div class="btn-group-vertical col-sm-2">
                    
                    </div>
                    <div class="col-sm-8 text-left">
                        <center><h1>Iniciar sesión</h1></center>
                        <ul class="list-group">
                            <form id="iniciar" action="../ServletGeneral" method="post">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                    <input type="text" class="form-control" name="Join" placeholder="Nickname o correo"><br>
                                </div>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                    <input id="pass" type="password" class="form-control" name="Contrasenia" placeholder="Contraseña">
                                </div>
                            <%
                                HttpSession sesion = request.getSession();
                                if (sesion.getAttribute("error") != null) {
                            %>
                            <label> <%=sesion.getAttribute("error")%></label><br>
                            <%}%>
                             <br class="x"><input type="checkbox" value="Recordarme" id="recordar" name="recordarme"> Recordarme
                            <br class="x"><center><input type="submit" value="Iniciar sesión" id="boton" /></center>
                            </form>
                        </ul>
                        <br>
                    </div>
                    <div class="col-sm-2">
                   
                    </div>
                </div>
            </div>
        </center>
        <script src="../Javascript/jquery.min.js"></script>
        <script src="../Javascript/sha1.js"></script>
        <Script src="../Javascript/encriptacion.js"></script>
        <script src="../Bootstrap/js/bootstrap.min.js"></script>
    </body>
</html>
