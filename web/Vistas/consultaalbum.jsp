<%-- 
    Document   : consultaalbum
    Created on : 04/11/2017, 12:46:08 AM
    Author     : Admin
--%>

<%@page import="java.util.Collections"%>
<%@page import="webservices.DtAlbum"%>
<%@page import="webservices.DtTema"%>
<%@page import="java.util.List"%>
<%@page import="webservices.DtArtista"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%DtArtista dt = (DtArtista) request.getSession().getAttribute("PerfilArt");
          DtAlbum dta = (DtAlbum)request.getSession().getAttribute("veralbum");
          List<String> generos = dta.getGeneros();
          List<DtTema> temas = dta.getTemas();
          Collections.reverse(temas);
        %>
        
    </head>
    <body>
        <h4 onclick="listaralbumes('<%=dt.getNickname()%>');clickear(this);" style="color: white; text-shadow: 0px 1px 4px white;"><%=dt.getNombre()+" "+dt.getApellido()%></h4>
        <% if(dta.getRutaImagen() == null){ %>
        <img src="../Imagenes/iconoMusica.jpg" alt="foto del usuario" class="img-responsive img-rounded" title="Album" style="margin: auto; display: block; width: 60%;"><!--Cambiar por imagen del album-->
        <%}else{%>
        <img src="/EspotifyMovil/ServletGeneral?tipo=imagen&ruta=<%= dta.getRutaImagen() %>" alt="foto del usuario" class="img-responsive img-rounded" title="Artista" style="margin: auto; display: block; width: 60%;">
        <%}%>
        <h4 style="color: white"><%=dta.getNombre()%></h4>
        <h4 style="color: white"><%=dta.getAnio()%></h4>
        <h4 style="color: white">Géneros:</h4>
        <%for (String gen: generos){%>
        <p style="color:white" onclick="clickear(this);">+<%=gen%></p>
        <%}%>
        <div id="mitabla">
            <div class="container">
            <h4 style="color: white">Temas</h4>           
            <div class="table-responsive"  style="border-style: none">
            <table class="table table-hover">
              <tbody>
                <%for (DtTema dtt:temas){%>
                <tr style="color:white;">
                  <td><%=dtt.getOrden()%>.</td>
                  <td><%=dtt.getNombre()%></td>
                  <td><%=dtt.getDuracion()%></td>
                  <%if (dtt.getDireccion()!=null){%>
                  <td><a href="http://<%=dtt.getDireccion()%>">Link externo</a></td>
                  <%}else{%>
                  <td>Descargar</td>
                  <%}%>
                </tr>
                <%}%>
              </tbody>
            </table>
            </div>
          </div>
        </div>
        <script src="../Javascript/principal.js"></script>
    </body>
</html>
