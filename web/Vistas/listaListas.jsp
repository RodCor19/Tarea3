<%-- 
    Document   : listaListas
    Created on : 08/11/2017, 02:40:36 AM
    Author     : ninoh
--%>

<%@page import="webservices.DtListaPD"%>
<%@page import="webservices.DtListaP"%>
<%@page import="webservices.DtCliente"%>
<%@page import="webservices.DtGenero"%>
<%@page import="webservices.DtLista"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../Bootstrap/css/bootstrap.css">
        <link rel="stylesheet" href="../CSS/estilos.css">
    </head>
    <body>
        <%   List<DtListaP> listas = (List<DtListaP>) session.getAttribute("Listas");   %>
        <div class="container">
            <h4 style="color: white; text-shadow: 0px 1px 4px white;">Listas Particulares</h4>
            <div class="row">
            <%for(DtLista lp: listas){ 
            if(lp instanceof DtListaP){
                DtListaP lpn = (DtListaP) lp;
            %>            
            <div class="col-xs-6 col-md-4" style="margin-bottom: 10px;padding-bottom: 5px; padding-right: 5px; padding-left: 5px; height: 180px; width: 180px">
                           <a href="#" onclick="listarlistap('<%= lpn.getUsuario() %>','<%= lp.getNombre() %>');">               
                    <% if (lp.getRutaImagen() == null) { %>
                    <img src="../Imagenes/IconoLista.png" alt="imagen" class="img-responsive img-rounded" title="Lista" style="margin-bottom: 4px; margin-right: 2px; height: 180px; width: 180px">
                    <%} else{%>
                    <img src="/EspotifyMovil/ServletGeneral?tipo=imagen&ruta=<%= lp.getRutaImagen() %>" alt="imagen" class="img-responsive img-rounded" title="Lista" style="margin-bottom: 4px; margin-right: 2px; height: 180px; width: 180px">
                    <%}%>
                    <h4  class="img-text"  ><%=lp.getNombre() %></h4>                    
                </a>  
            </div>
            <%}}%>
            </div>
            <br>
            <h4 style="color: white; text-shadow: 0px 1px 4px white;">Listas Por Defecto</h4>
            <div class="row">
            <%for(DtLista lpd: listas){
            if(lpd instanceof DtListaPD){    
            %>
            <div class="col-xs-6 col-md-4" style="margin-bottom: 10px;padding-bottom: 5px; padding-right: 5px; padding-left: 5px; height: 180px; width: 180px">
                          <a href=# onclick="listarlistapd('<%= lpd.getNombre() %>');">
                    <% if(lpd.getRutaImagen() == null){ %>
                    <img src="../Imagenes/IconoLista.png" alt="imagen" class="img-responsive img-rounded" title="Lista" style="margin-bottom: 4px; margin-right: 2px; height: 180px; width: 180px">
                    <%}else{%>
                    <img src="/EspotifyMovil/ServletGeneral?tipo=imagen&ruta=<%= lpd.getRutaImagen() %>" alt="imagen" class="img-responsive img-rounded" title="Lista" style="margin-bottom: 4px; margin-right: 2px; height: 180px; width: 180px">
                    <%}%>

                    <h4  class="img-text" > <%= lpd.getNombre() %> </h4>
                </a>  
            </div>
            <%}}%>
            </div>
        </div>
    <script src="../Javascript/principal.js"></script>
    </body>
</html>
