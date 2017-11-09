<%-- 
    Document   : VerInfoLista2
    Created on : 08/11/2017, 05:24:34 PM
    Author     : ninoh
--%>

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
          List<DtTema> temas = dt.getTemas();
          Collections.reverse(temas);
        %>
    </head>
    <body>
        <h4 style="color: white; text-shadow: 0px 1px 4px white;"><%=dt.getNombre()%></h4>
        <% if(dt.getRutaImagen() == null){ %>
        <img src="../Imagenes/IconoLista.png" alt="foto del usuario" class="img-responsive img-rounded" title="Album" style="margin: auto; display: block; width: 60%;"><!--Cambiar por imagen del album-->
        <%}else{%>
        <img src="/EspotifyMovil/ServletGeneral?tipo=imagen&ruta=<%= dt.getRutaImagen() %>" alt="foto del usuario" class="img-responsive img-rounded" title="Artista" style="margin: auto; display: block; width: 60%;">
        <%}%>

        <div id="mitabla">
            <div class="container">
            <h4 style="color: white">Temas</h4>           
            <div class="table-responsive"  style="border-style: none">
            <table class="table text-left">
                <thead class="text-left" style="color: white">  
                    <tr>
                        <th><h5><b>Orden</b></h5></th>
                        <th><h5><b>Nombre</b></h5></th>
                        <th><h5><b>Duracion</b></h5></th>
                        <th><h5></h5></th>
                    </tr>
                </thead>
              <tbody class="text-left">
                <%for (DtTema dtt:temas){%>
                <tr style="color:white;">                    
                  <td><%=dtt.getOrden()%>.</td>
                  <td><%=dtt.getNombre()%></td>
                  <td><%=dtt.getDuracion()%></td>
                  <%if (dtt.getDireccion()!=null){%>
                  <td><a class="glyphicon glyphicon-new-window" href="http://<%=dtt.getDireccion()%>"></a></td>
                  <%}else{%>
                  <td><a class="glyphicon glyphicon-download"></a></td>
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
