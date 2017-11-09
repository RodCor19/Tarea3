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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../Bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="../CSS/estilos.css">
    </head>
    <body>
        <%  List<DtGenero> generos = (List<DtGenero>) session.getAttribute("Generos"); %>
        <div class="container">
            <h2 style="color: white; text-shadow: 0px 1px 4px white;">Generos</h2>
            <div class="row">
            <%for(DtGenero gen: generos){ %>
            <div class="col-xs-6 col-md-4" style="margin-bottom: 10px;padding-bottom: 5px; padding-right: 5px; padding-left: 5px; height: 180px; width: 180px">
            <a href="#" onclick="listaalbumesg('<%=gen.getNombre() %>')">                
                <img src="../Imagenes/iconoGenero.jpg" alt="icono" class="img-responsive img-rounded" title="Genero" style="margin-bottom: 4px; margin-right: 2px; height: 180px; width: 180px"><!--Cambiar por imagen del usuario-->                    
                    <h4  class="img-text"  ><%=gen.getNombre() %></h4>                    
                </a>  
            </div>
            <%}%>
            </div>
        </div>
    <script src="../Javascript/principal.js"></script>
    </body>
</html>
