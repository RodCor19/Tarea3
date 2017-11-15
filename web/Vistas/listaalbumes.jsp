<%-- 
    Document   : listaalbumes
    Created on : 02/11/2017, 09:33:40 PM
    Author     : Admin
--%>

<%@page import="webservices.DtArtista"%>
<%@page import="webservices.DtAlbum"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%if (request.getSession().getAttribute("Usuario")!=null){%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% List<DtAlbum> albumes = (List<DtAlbum>)session.getAttribute("Albumes");
           DtArtista dt = (DtArtista) request.getSession().getAttribute("PerfilArt");
        %>
    </head>
    <body>
        <div class="container">
            <h2 style="color: white; text-shadow: 0px 1px 4px white; cursor: pointer"><%=dt.getNombre()+" "+dt.getApellido()%></h2>
            <h3 style="color: white; text-shadow: 0px 1px 4px white;">Álbumes</h3>
            <div class="row">
            <%for(DtAlbum al: albumes){ %>
            <div class="col-xs-6 col-sm-4 col-md-4 col-lg-3" style="margin-bottom: 0px;padding-bottom: 5px; padding-right: 5px; padding-left: 5px;">
                <a onclick="consultaalbum('<%=al.getNombre()%>','<%=al.getNombreArtista()%>')" style="cursor: pointer">
                    <% if(al.getRutaImagen() == null){ %>
                    <img src="../Imagenes/iconoMusica.jpg" alt="foto del usuario" class="imagen-responsive img-rounded" title="Album" style="margin-bottom: 4px; margin-right: 2px;"><!--Cambiar por imagen del album-->
                    <%}else{%>
                    <img src="/EspotifyMovil/ServletGeneral?tipo=imagen&ruta=<%= al.getRutaImagen() %>" alt="foto del usuario" class="imagen-responsive img-rounded" title="Artista" style="margin-bottom: 4px; margin-right: 2px;">
                    <%}%>
                    <!--<img src="/EspotifyWeb/Imagenes/iconoArtista.png" alt="foto del usuario" class="img-responsive imgAlbum" title="Artista">Cambiar por imagen del usuario-->
                    <!--<h4 class="img-text" onmouseover="artSeleccionado(this, true)" onmouseout="artSeleccionado(this, false)"></h4>-->
                    <h4 class="img-text"  ><%=al.getNombre()%></h4>
                </a>  
            </div>
            <%}%>
            </div>
        </div>
        <script src="../Javascript/principal.js"></script>
    </body>
</html>
<%}else{%>
<script>alert("Acceso Denegado");</script>
<meta http-equiv="refresh" content="0; URL=/EspotifyMovil/Vistas/IniciarSesion.jsp">
<%}%>