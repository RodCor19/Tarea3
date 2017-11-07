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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% List<DtAlbum> albumes = (List<DtAlbum>)session.getAttribute("Albumes");
           DtArtista dt = (DtArtista) request.getSession().getAttribute("PerfilArt");
        %>
    </head>
    <body>
        <div class="container">
            <h2 style="color: white; text-shadow: 0px 1px 4px white;"><%=dt.getNombre()+" "+dt.getApellido()%></h2>
            <h4 style="color: white; text-shadow: 0px 1px 4px white;">Albumes</h4>
            <div class="row">
            <%for(DtAlbum al: albumes){ %>
            <div class="col-xs-6 col-md-4" style="margin-bottom: 10px;padding-bottom: 5px; padding-right: 5px; padding-left: 5px; height: 180px; width: 180px">
                <a href=# onclick="consultaalbum('<%=al.getNombre()%>')">
                    <% if(al.getRutaImagen() == null){ %>
                    <img src="../Imagenes/iconoMusica.jpg" alt="foto del usuario" class="img-responsive img-rounded" title="Album" style="margin-bottom: 4px; margin-right: 2px; height: 180px; width: 180px"><!--Cambiar por imagen del album-->
                    <%}else{%>
                    <img src="/EspotifyMovil/ServletGeneral?tipo=imagen&ruta=<%= al.getRutaImagen() %>" alt="foto del usuario" class="img-responsive img-rounded" title="Artista" style="margin-bottom: 4px; margin-right: 2px; height: 180px; width: 180px">
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
