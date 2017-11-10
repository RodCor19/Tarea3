<%-- 
    Document   : VerInfoLista2
    Created on : 08/11/2017, 05:24:34 PM
    Author     : ninoh
--%>

<%@page import="webservices.DtUsuario"%>
<%@page import="webservices.WSClientes"%>
<%@page import="webservices.DtListaP"%>
<%@page import="java.util.Collections"%>
<%@page import="webservices.DtTema"%>
<%@page import="java.util.List"%>
<%@page import="webservices.DtLista"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%DtLista dt = (DtLista) session.getAttribute("Lista2");
        DtListaP dtp = (DtListaP) dt;
        List<DtTema> temas = dtp.getTemas();
        WSClientes wscli = (WSClientes) session.getAttribute("WSClientes");
        DtUsuario dtu = (DtUsuario)session.getAttribute("Usuario");
        Collections.reverse(temas);
        int indice = 0;
        int x = 0;
        String nom;
        %>
    </head>
    <body>
        <h4 style="color: white; text-shadow: 0px 1px 4px white;"><%=dt.getNombre()%></h4>
        <% if(dtp.getRutaImagen() == null){ %>
        <img src="../Imagenes/IconoLista.png" alt="foto del usuario" class="img-responsive img-rounded" title="Album" style="margin: auto; display: block; width: 60%;"><!--Cambiar por imagen del album-->
        <%}else{%>
        <img src="/EspotifyMovil/ServletGeneral?tipo=imagen&ruta=<%= dtp.getRutaImagen() %>" alt="foto del usuario" class="img-responsive img-rounded" title="Artista" style="margin: auto; display: block; width: 60%;">
        <%}%>
        <h4 style="color: white"><%=request.getSession().getAttribute("nombrecreador")%></h4>
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
                            <li class="list-group-item" style="border-color: white; color: white; background-color: black;"><b >Reproducciones: <br><%=dtt.getCantReproduccion()%></b></li>
                            <li class="list-group-item"style="border-color: white; color: white; background-color: black;"><b>Descargas: <br><%=dtt.getCantDescarga()%></b></li>
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
              <div id="divReproductor" class="hidden">
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
        <script src="../Javascript/principal.js"></script>
    </body>
</html>
