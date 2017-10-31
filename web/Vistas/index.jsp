<%-- 
    Document   : index
    Created on : 25/10/2017, 06:50:36 PM
    Author     : stephiRM
--%>

<%@page import="webservices.DtUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="../Bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="../CSS/estilos.css">
        <link type="image/x-icon" rel="shortcut icon"  href="/EspotifyWeb/Imagenes/espotifyIcono.ico">
        <title>Espotify</title>
    </head>
    <body>
        <% 
        HttpSession sesion = request.getSession();
        DtUsuario dt = (DtUsuario) sesion.getAttribute("Usuario");
        %>
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span> 
                    </button>
                    <a class="navbar-brand" href="#" style="color: yellow;">Bienvenido <%=dt.getNombre()+" "+dt.getApellido()%></a>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav">
                        <li><a href="#">Géneros</a></li>
                        <li><a href="#">Artistas</a></li> 
                        <li><a href="#">Listas de Reproducción</a></li> 
                        <li><a href="/EspotifyMovil/ServletGeneral?CerrarSesion=true">Cerrar sesión</li> 
                    </ul>
                </div>
            </div>
        </nav>
                <div id="fondo">
                    
                </div>  
        <script src="../Javascript/jquery.min.js"></script>
        <script src="../Bootstrap/js/bootstrap.min.js"></script>
    </body>
</html>
