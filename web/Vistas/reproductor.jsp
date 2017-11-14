<%-- 
    Document   : reproductor
    Created on : 07/10/2017, 03:43:59 PM
    Author     : Kevin
--%>

<%@page import="java.util.Collections"%>
<%@page import="webservices.DtTema"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%if (request.getSession().getAttribute("Usuario")!=null){%>
<%  //DtAlbum album = (DtAlbum) session.getAttribute("Album");
    List<DtTema> temas = (List<DtTema>) session.getAttribute("temasAReproducir");
    Collections.reverse(temas);
    DtTema repTema = (DtTema) session.getAttribute("reproducirTema");
%>

    <div id="contenedorReproductor" class="text-right">
        <button onclick="cerrarRep(this.parentElement)" class="btn btn-xs btn-danger glyphicon glyphicon-remove"></button>
        <div id="audiocontrol">
            <div id="trackImageContainer">
                <img id="trackImage" src= "/EspotifyMovil/Imagenes/albumReproductor.jpg">
            </div>
            <div id="nowPlay" class="text-center" >
                <div id="auTitle" style="padding-bottom: 5px; background: #1ED760; color: whitesmoke">---</div>
                <audio id="aurepr" preload="auto" controls controlsList="nodownload" onended="get_next(1)"></audio>
            </div>            
            <div id="auExtraControls" style="background: red">
                <div  class="col-sm-6 text-center" style="padding: 0px;">
                    <button id="btnPrev" class="ctrlbtn" onclick="get_next(-1);">
                        <i class="glyphicon glyphicon-step-backward" aria-hidden="true"></i>
                    </button>
                </div>
                <div  class="col-sm-6 text-center" style="padding: 0px;">
                    <button id="btnNext" class="ctrlbtn" onclick="get_next(1);">
                        <i class="glyphicon glyphicon-step-forward" aria-hidden="true"></i>
                    </button>
                </div>
            </div>
        </div>
        <button class="btnVerTemas" data-toggle="collapse" data-target="#mostrarTemas" onclick="mostrarOcultarTemas(this)">Ver temas</button>
        <div id="mostrarTemas" class="collapse">
            <table id="music" width="100%">  
                <thead>
                    <tr>
                        <th width="5" style="color: #e6e6e6; padding-left: 3px"><strong>#</strong></th>
                        <th width="75" style="color: #e6e6e6"><strong>Tema</strong></th>
                    </tr>
                </thead>
                <tbody style="padding-left: 5px;">
                    <%  for (DtTema tema : temas) { 
                            //String cargarImagen = "/EspotifyWeb/ServletArchivos?tipo=imagen&ruta="+album.getRutaImagen();
                            //if(album.getRutaImagen() == null){ //Si no tiene imagen se carga una por defecto
                            
                            String cargarImagen = "/EspotifyMovil/Imagenes/albumReproductor.jpg";
                            
                            if(tema.getArchivo() != null){
                                boolean controlRepTema = false;
                                if(repTema!=null && repTema.getArchivo() != null && repTema.getArchivo().equals(tema.getArchivo())){
                                    controlRepTema = true;
                                }
                    %>
                    <tr <%if(controlRepTema){%>class="reproducirTema"<%}%> id="/EspotifyMovil/ServletGeneral?tipo=audio&ruta=<%= tema.getArchivo() %>|<%= cargarImagen %>|<%=tema.getNombre()%>|<%=tema.getNomalbum()%>|<%=tema.getNomartista()%>" onclick="play(this);" style="cursor: pointer">
                    <%}else{
                        boolean controlRepTema = false;
                        if(repTema!=null && repTema.getDireccion() != null && repTema.getDireccion().equals(tema.getDireccion())){
                            controlRepTema = true;
                        }%>
                    <tr <%if(controlRepTema){%>class="reproducirTema"<%}%> id="/EspotifyMovil/ServletGeneral?tipo=audio&direccion=<%= tema.getDireccion() %>|<%= cargarImagen %>" onclick="play(this);"  style="cursor: pointer">
                    <%}%>
                    <td style="padding-left: 3px; color: #e6e6e6;"><%= tema.getOrden() %></td>
                        <td class="song"><%= tema.getNombre()+" - "+tema.getNomartista()+" - "+tema.getNomalbum() %></td>
                    </tr>
                    <%       
                        }
                    //Se elimina porque ya se cargo el album y se reproducio el tema por defecto
                    session.removeAttribute("reproducirTema"); %>
                </tbody>      
            </table>
        </div>
    </div> 
    <script>$('.reproducirTema').click(); //reproducir el tema seleccionaro, click</script>
<%}else{%>
<script>alert("Acceso Denegado");</script>
<meta http-equiv="refresh" content="0; URL=/EspotifyMovil/Vistas/IniciarSesion.jsp">
<%}%>

