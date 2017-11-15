<%-- 
    Document   : listaListas
    Created on : 08/11/2017, 02:40:36 AM
    Author     : ninoh
--%>

<%@page import="webservices.DtUsuario"%>
<%@page import="webservices.DtListaPD"%>
<%@page import="webservices.DtListaP"%>
<%@page import="webservices.DtCliente"%>
<%@page import="webservices.DtGenero"%>
<%@page import="webservices.DtLista"%>
<%@page import="java.util.List"%>
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
        <%   List<DtListaP> listas = (List<DtListaP>) session.getAttribute("Listas");
            DtUsuario dtu = (DtUsuario) request.getSession().getAttribute("Usuario");%>
        <div class="container">
            <h4 style="color: white; text-shadow: 0px 1px 4px white;">Listas Particulares</h4>
            <div class="row">
            <%for(DtLista lp: listas){
            if(lp instanceof DtListaP){
                DtListaP lpn = (DtListaP) lp;
                if (!lpn.isPrivada() || (lpn.isPrivada() && lpn.getUsuario().equals(dtu.getNickname()))){
            %>            
            <div class="col-xs-6 col-sm-4 col-md-4 col-lg-3" style="margin-bottom: 0px;padding-bottom: 5px; padding-right: 5px; padding-left: 5px;">
                <a onclick="listarlistap('<%= lpn.getUsuario() %>','<%= lp.getNombre() %>');" style="cursor: pointer">               
                    <% if (lp.getRutaImagen() == null) { %>
                    <img src="../Imagenes/IconoLista.png" alt="imagen" class="imagen-responsive img-rounded" title="Lista" style="margin-bottom: 4px; margin-right: 2px;">
                    <%} else{%>
                    <img src="/EspotifyMovil/ServletGeneral?tipo=imagen&ruta=<%= lp.getRutaImagen() %>" alt="imagen" class="imagen-responsive imagen-rounded" title="Lista" style="margin-bottom: 4px; margin-right: 2px;">
                    <%}%>
                    <h4  class="img-text"  ><%=lp.getNombre() %></h4>                    
                </a>  
            </div>
            <%}}}%>
            </div>
            <h4 style="color: white; text-shadow: 0px 1px 4px white; width: 100%; padding-top: 10px;">Listas Por Defecto</h4>
            <div class="row">
            <%for(DtLista lpd: listas){
            if(lpd instanceof DtListaPD){%>
            <div class="col-xs-6 col-sm-4 col-md-4 col-lg-3" style="margin-bottom: 0px;padding-bottom: 5px; padding-right: 5px; padding-left: 5px;">
                <a onclick="listarlistapd('<%= lpd.getNombre() %>');" style="cursor: pointer">
                    <% if(lpd.getRutaImagen() == null){ %>
                    <img src="../Imagenes/IconoLista.png" alt="imagen" class="imagen-responsive img-rounded" title="Lista" style="margin-bottom: 4px; margin-right: 2px;">
                    <%}else{%>
                    <img src="/EspotifyMovil/ServletGeneral?tipo=imagen&ruta=<%= lpd.getRutaImagen() %>" alt="imagen" class="imagen-responsive img-rounded" title="Lista" style="margin-bottom: 4px; margin-right: 2px;">
                    <%}%>

                    <h4  class="img-text" > <%= lpd.getNombre() %> </h4>
                </a>  
            </div>
            <%}}%>
            </div>
        </div>
    <!--<script src="../Javascript/principal.js"></script>
    </body>-->
</html>
<%}else{%>
<script>alert("Acceso Denegado");</script>
<meta http-equiv="refresh" content="0; URL=/EspotifyMovil/Vistas/IniciarSesion.jsp">
<%}%>