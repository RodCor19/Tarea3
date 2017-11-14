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
        <link type="image/x-icon" rel="shortcut icon"  href="../Imagenes/espotifyIcono.ico">
        <title>Espotify</title>
    </head>
    <body>
        <% 
        HttpSession sesion = request.getSession();
        if (sesion.getAttribute("Usuario")!=null){
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
                    <a class="navbar-brand"  href="#" style="color: #00ff66;"> Bienvenido <%=dt.getNombre()+" "+dt.getApellido()%></a>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav">
                        <li><a id="btngeneros" href="#">Géneros</a></li>
                        <li><a id="btnartistas" href="#">Artistas</a></li> 
                        <li><a id="btnlistas" href="#">Listas de Reproducción</a></li> 
                        <li><a href="/EspotifyMovil/ServletGeneral?CerrarSesion=true">Cerrar sesión</a></li> 
                    </ul>
                </div>
                
            </div>
        </nav>
            <div class="container-fluid">
                <div id="listaArtGen" class="row text-center" style="padding-left: 5px; padding-right: 5px;">
                    <jsp:include page="listaArtistas.jsp" />  <%-- Importar la cabecera desde otro archivo .jsp --%>

                </div>
            </div>
        <script src="../Javascript/jquery.min.js"></script>
        <script src="../Bootstrap/js/bootstrap.min.js"></script>
        <script src="../Javascript/principal.js"></script>
        <%}
        else{%>
            <meta http-equiv="refresh" content="0; URL=/EspotifyMovil/ServletGeneral?Inicio=true">
        <%}%>
    </body>
</html>
