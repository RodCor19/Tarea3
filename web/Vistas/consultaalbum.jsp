<%-- 
    Document   : consultaalbum
    Created on : 04/11/2017, 12:46:08 AM
    Author     : Admin
--%>

<%@page import="webservices.WSArtistas"%>
<%@page import="webservices.DtUsuario"%>
<%@page import="webservices.WSClientes"%>
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
        <%
          DtArtista dt = (DtArtista) request.getSession().getAttribute("PerfilArt");
          DtAlbum dta = (DtAlbum)request.getSession().getAttribute("veralbum");
          List<String> generos = dta.getGeneros();
          List<DtTema> temas = dta.getTemas();
          if (temas.get(0).getOrden()!=1){
            Collections.reverse(temas);
          }
          int x = 0;
          int indice = 0;
          WSClientes wscli = (WSClientes) session.getAttribute("WSClientes");
          DtUsuario dtu = (DtUsuario)session.getAttribute("Usuario");
          String nom = null;
        %>
        <style>
        @media (min-width: 992px) {
            #datosalbum {
                width:100%;
                margin-left: 300px;
            }
        }
        .table-hover tbody tr:hover td, .table-hover tbody tr:hover th {
            color: white;
            background-color: #3e3d3d;
            cursor: pointer;
        }
        </style>
    </head>
    <body>
        <div class="container-fluid" id="datosalbum">
        <h4 onclick="listaralbumes('<%=dt.getNickname()%>');clickear(this);" style="color: white; text-shadow: 0px 1px 4px white;"><%=dt.getNombre()+" "+dt.getApellido()%></h4>
        <% if(dta.getRutaImagen() == null){ %>
        <img src="../Imagenes/iconoMusica.jpg" alt="foto del usuario" class="img-responsive img-rounded" title="Album" style="margin: auto; display: block; width: 60%;"><!--Cambiar por imagen del album-->
        <%}else{%>
        <img src="/EspotifyMovil/ServletGeneral?tipo=imagen&ruta=<%= dta.getRutaImagen() %>" alt="foto del usuario" class="img-responsive img-rounded" title="Artista" style="margin: auto; display: block; width: 60%;">
        <%}%>
        <h4 style="color: white"><%=dta.getNombre()%></h4>
        <h4 style="color: white"><%=dta.getAnio()%></h4>
        <h4 style="color: white">Géneros:</h4>
        <p style="color:white" >
        <%for (String gen: generos){%>
        - <a style="color: #00ff66" onclick="listaalbumesg('<%=gen%>')" ><%=gen%> </a> 
        <%}%> </p>
        </div>
            <div class="container">
            <h4 style="color: white">Temas</h4>           
            <div id="mitabla">
            <div class="table-responsive"  style="border-style: none">
            <table class="table table-hover">
              <tbody>
                <%for (DtTema dtt:temas){
                   if (dtt.getArchivo()!=null){    
                       x++;%>
                 <tr id="<%=x%>" style="color:white;" >
                <%}else{%>
                   <tr  style="color:white;"><%}%>
                  <%if (dtt.getArchivo()!=null){%>
                  <td onclick="hola(this,'<%=dtt.getNomartista()%>','<%=dtt.getNomalbum()%>','<%=dtt.getNombre()%>')">
                    <img  src="../Imagenes/play.png" id="0" style="width: 25px">
                  </td>
                  <%}else{%>
                  <td>
                      <img class="hidden" src="../Imagenes/unavailable.png" style="width: 25px">
                      <a href="http://<%=dtt.getDireccion()%>" class="glyphicon glyphicon-new-window" onmouseup="nuevaReproduccion('<%= dtt.getNomartista() %>','<%= dtt.getNomalbum() %>', '<%= dtt.getNombre() %>');"></a>
                  </td>
                  <%}%>
                <%if (dtt.getArchivo()!=null){
                    nom = dtt.getNombre();
                    if (dtt.getNombre().length() > 27){
                        nom = dtt.getNombre().substring(0,27)+"...";
                    }%>
                    <td onclick="hola(this,'<%=dtt.getNomartista()%>','<%=dtt.getNomalbum()%>','<%=dtt.getNombre()%>')"><%=nom%></td>
                <%}else{
                    nom = dtt.getNombre();
                    if (dtt.getNombre().length() > 27){
                        nom = dtt.getNombre().substring(0,27)+"...";
                    }%>
                <td><%=nom%></td>
                <%}%>
                  <td><%=dtt.getDuracion()%></td>
                  <td>
                    <a class="glyphicon glyphicon-cog"  data-popover-content="#<%= indice %>" data-toggle="popover" data-trigger="focus"  tabindex="0"></a>
                    <%if (dtt.getArchivo()!=null && (wscli.suscripcionVigente(dtu.getNickname())) ){%>
                        <a class="glyphicon glyphicon-download-alt" href="/EspotifyMovil/ServletGeneral?descargar=<%= dtt.getArchivo()%>&tema=<%= dtt.getNombre() %>&album=<%= dtt.getNomalbum() %>&artista=<%= dtt.getNomartista() %>"></a>
                    <%}%>
                  </td>
                  
              <div  onchange="func(this)" class="hidden" id="<%=indice %>">
                    <div class="popover-heading">
                        Información
                    </div>
                    <div class="popover-body" >
                        <ul style="padding: 0px; margin: 0px;">
                            <%--<li class="list-group-item"><%=tem.getNombre()%></li>--%>
                            <li class="list-group-item" style="border-color: white; color: white; background-color: black; "><b>Orden: <br> <%=dtt.getOrden()%></b></li>
                            <li class="list-group-item" style="border-color: white; color: white; background-color: black;"><b >Reproducciones: <br><%=dtt.getCantReproduccion()%></b></li>
                            <li class="list-group-item" style="border-color: white; color: white; background-color: black;"><b>Descargas: <br><%=dtt.getCantDescarga()%></b></li>
                        </ul>
                    </div>
                </div>
                </tr>
                <%indice++;%>
                <%}%>
              </tbody>
            </table>
            </div>
            </div>
              <div id="divReproductor" >
                <% if (session.getAttribute("temasAReproducir") != null) { %>
                    <jsp:include page="reproductor.jsp" /> <%-- Importar codigo desde otro archivo .jsp --%>
                <%}%>
              </div>
          </div>
        <script>
            $(function(){
                $("[data-toggle=popover]").popover({
                    html : true,
                    placement: 'left',
                    content: function() {
                      var content = $(this).attr("data-popover-content");
                      return $(content).children(".popover-body").html();
                    }/*,
                    title: function() {
                      var title = $(this).attr("data-popover-content");
                      return $(title).children(".popover-heading").html();
                    }*/
                });
            });
        </script>
<!--        <script src="../Javascript/jquery.min.js"></script>
        <script src="../Javascript/principal.js"></script>-->
    </body>
</html>
