<%-- 
    Document   : listaArtistas
    Created on : 31/10/2017, 07:35:23 PM
    Author     : Admin
--%>

<%@page import="webservices.DtUsuario"%>
<%@page import="java.util.List"%>
<%@page import="webservices.DtArtista"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../Bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="../CSS/estilos.css">
    </head>
    <body>
        <%  List<DtUsuario> artistas = (List<DtUsuario>) session.getAttribute("Artistas"); %>
        <div class="container">
<div class="row">
    <%for(DtUsuario art: artistas){ %>
    <div class="col-xs-6 col-md-4" style="margin: 0px;padding-bottom: 5px; padding-right: 5px; padding-left: 5px">
        <a href="#"  >
            <img src="../Imagenes/iconoArtista.png" alt="foto del usuario" class="img-responsive img-rounded" title="Artista" style="margin-bottom: 4px; margin-right: 2px;"><!--Cambiar por imagen del usuario-->
            
            <!--<img src="/EspotifyWeb/Imagenes/iconoArtista.png" alt="foto del usuario" class="img-responsive imgAlbum" title="Artista">Cambiar por imagen del usuario-->
            <!--<h4 class="img-text" onmouseover="artSeleccionado(this, true)" onmouseout="artSeleccionado(this, false)"><%=art.getNombre()+" "+art.getApellido() %></h4>-->
            <h4 class="img-text" ><%=art.getNombre()+" "+art.getApellido() %></h4>
        </a>  
    </div>
    <%}%>
</div>
        </div>
    </body>
</html>
