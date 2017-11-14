<%-- 
    Document   : listaalbumesgen
    Created on : 06/11/2017, 07:58:41 PM
    Author     : ninoh
--%>

<%@page import="webservices.DtLista"%>
<%@page import="webservices.DtAlbum"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%if (request.getSession().getAttribute("Usuario")!=null){%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%  List<DtAlbum> albumes = (List<DtAlbum>) session.getAttribute("Albumes"); 
          List<DtLista> listapd = (List<DtLista>) session.getAttribute("Listas");
          String nomGenero = (String) session.getAttribute("Genero");
        %>
        <div class="container">
            <h2 style="color: white; text-shadow: 0px 1px 4px white;">Género: <%= nomGenero %></h2>
            <h3 style="color: white; text-shadow: 0px 1px 4px white;">Álbumes</h3>
            <div class="row">
            <%for(DtAlbum alb: albumes){ %>
            <div class="col-xs-6 col-sm-4 col-md-4 col-lg-3" style="margin-bottom: 0px;padding-bottom: 5px; padding-right: 5px; padding-left: 5px;">
                <a href=# onclick="consultaalbum('<%=alb.getNombre()%>','<%=alb.getNombreArtista()%>')" >
                    <% if(alb.getRutaImagen() == null){ %>
                    <img src="../Imagenes/iconoMusica.jpg" alt="imagen" class="imagen-responsive img-rounded" title="Album" style="margin-bottom: 4px; margin-right: 2px;"><!--Cambiar por imagen del usuario-->
                    <%}else{%>
                    <img src="/EspotifyMovil/ServletGeneral?tipo=imagen&ruta=<%= alb.getRutaImagen() %>" alt="imagen" class="imagen-responsive img-rounded" title="Album" style="margin-bottom: 4px; margin-right: 2px;">
                    <%}%>

                    <h4  class="img-text" ><%=alb.getNombre()%></h4>
                </a>  
            </div>
            <%}%>
            </div>
                <br>
            <h3 style="color: white; text-shadow: 0px 1px 4px white;">Listas Por Defecto</h3>
            <div class="row">
            <%for(DtLista lpd: listapd){ %>
            <div class="col-xs-6 col-sm-4 col-md-4 col-lg-3" style="margin-bottom: 0px;padding-bottom: 5px; padding-right: 5px; padding-left: 5px;">
                <a href=# onclick="listarlistapd('<%= lpd.getNombre() %>');" >
                    <% if(lpd.getRutaImagen() == null){ %>
                    <img src="../Imagenes/IconoLista.png" alt="imagen" class="imagen-responsive img-rounded" title="Lista" style="margin-bottom: 4px; margin-right: 2px;">
                    <%}else{%>
                    <img src="/EspotifyMovil/ServletGeneral?tipo=imagen&ruta=<%= lpd.getRutaImagen() %>" alt="imagen" class="imagen-responsive img-rounded" title="Lista" style="margin-bottom: 4px; margin-right: 2px;">
                    <%}%>

                    <h4  class="img-text" > <%= lpd.getNombre() %> </h4>
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