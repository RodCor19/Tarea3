<%-- 
    Document   : listaGeneros
    Created on : 02/11/2017, 07:00:23 PM
    Author     : Admin
--%>

<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@page import="webservices.DtGenero"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%if (request.getSession().getAttribute("Usuario")!=null){%>
<html>
<!--    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../Bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="../CSS/estilos.css">
    </head>
    <body>-->
        <%  List<DtGenero> generos = (List<DtGenero>) session.getAttribute("Generos"); %>
        <!--<div class="container">-->
            <h2 style="color: white; text-shadow: 0px 1px 4px white;">Generos</h2>
            <!--<div class="row">-->
            <%for(DtGenero gen: generos){ %>
            <div class="col-xs-6 col-sm-4 col-md-4 col-lg-3" style="margin-bottom: 0px;padding-bottom: 5px; padding-right: 5px; padding-left: 5px;">
            <a href="#" onclick="listaalbumesg('<%=gen.getNombre() %>')">                
                <%String nomgen = gen.getNombre();
                if (nomgen.equals("Rock") || nomgen.equals("Pop") || nomgen.equals("Clásica") || nomgen.equals("Balada") || nomgen.equals("Disco") || nomgen.equals("Rock Clásico") || nomgen.equals("Electropop")){%>
                    <img src="/EspotifyMovil/Imagenes/<%=nomgen%>.jpg" alt="foto del genero" class="imagen-responsive img-rounded" title="Generos" style="margin-bottom: 4px; margin-right: 2px;"><!--Cambiar por imagen del usuario-->
                <%}else{%>
                    <img src="/EspotifyMovil/Imagenes/iconoGenero.jpg" alt="foto del genero" class="imagen-responsive img-rounded" title="Generos" style="margin-bottom: 4px; margin-right: 2px;" ><!--Cambiar por imagen del usuario-->
                <%}%>
                <!--<img src="../Imagenes/iconoGenero.jpg" alt="icono" class="img-responsive img-rounded" title="Genero" style="margin-bottom: 4px; margin-right: 2px; height: 180px; width: 180px">Cambiar por imagen del usuario-->                    
                    <h4  class="img-text"  ><%=gen.getNombre() %></h4>                    
                </a>  
            </div>
            <%}%>
<!--            </div>
        </div>
    <script src="../Javascript/principal.js"></script>
    </body>-->
</html>
<%}else{%>
<script>alert("Acceso Denegado");</script>
<meta http-equiv="refresh" content="0; URL=/EspotifyMovil/Vistas/IniciarSesion.jsp">
<%}%>