/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.File;
import Clases.Configuraciones;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.util.Collections;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.namespace.QName;
import javax.xml.ws.WebServiceException;
import webservices.DataUsuarios;
import webservices.DtAlbum;
import webservices.DtArtista;
import webservices.DtCliente;
import webservices.DtGenero;
import webservices.DtLista;
import webservices.DtListaP;
import webservices.DtListaPD;
import webservices.DtTema;
import webservices.DtUsuario;
import webservices.IOException_Exception;
import webservices.WSArtistas;
import webservices.WSArtistasService;
import webservices.WSClientes;
import webservices.WSClientesService;
import webservices.WSArchivos;
import webservices.WSArchivosService;

/**
 *
 * @author stephiRM
 */
@WebServlet(name = "ServletGeneral", urlPatterns = {"/ServletGeneral"})
public class ServletGeneral extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession sesion = request.getSession();

        try {
            Configuraciones conf = new Configuraciones();
            WSArtistasService wsarts = new WSArtistasService(conf.getUrlWSArtistas(),new QName("http://WebServices/", "WSArtistasService"));
            WSArtistas wsart = wsarts.getWSArtistasPort();

            WSClientesService wsclis = new WSClientesService(conf.getUrlWSClientes(), new QName("http://WebServices/", "WSClientesService"));
            WSClientes wscli = wsclis.getWSClientesPort();

            WSArchivosService wsarchs = new WSArchivosService(conf.getUrlWSArchivos());
            WSArchivos wsarch = wsarchs.getWSArchivosPort();
            
            request.getSession().setAttribute("WSArtistas", wsart);
            request.getSession().setAttribute("WSClientes", wscli);

            if (request.getParameter("Join") != null) {
                String nickname = request.getParameter("Join");
                String contrasenia = request.getParameter("Contrasenia");
                DataUsuarios data = wsart.verificarLoginArtista(nickname, contrasenia);
                DtUsuario dt = null;

                if (!data.getUsuarios().isEmpty()) {
                    dt = data.getUsuarios().get(0);
                }

                if (dt instanceof DtCliente) {
                    if (dt != null) {
                        if (request.getParameter("recordarme") != null) {
                            Cookie c = new Cookie("Join", dt.getNickname());
                            c.setMaxAge(60 * 60 * 24);
                            response.addCookie(c);
                        }

                        sesion.setAttribute("Usuario", dt);
                        sesion.removeAttribute("error");
                        sesion.setAttribute("Mensaje", "Bienvenido/a " + dt.getNombre() + " " + dt.getApellido());

                        //Verificar y actualizar si las suscripciones del cliente que estaban vigentes se vencieron
                        wscli.actualizarVigenciaSuscripciones(dt.getNickname());

                        response.sendRedirect("ServletGeneral?Inicio=true");
                    } else {
                        if (!(wscli.verificarDatosCli(nickname, nickname) && wsart.verificarDatosArt(nickname, nickname))) {
                            sesion.setAttribute("error", "Contraseña incorrecta");
                        } else {
                            sesion.setAttribute("error", "Usuario y contraseña incorrectos");
                        }
                        response.sendRedirect("/EspotifyMovil/Vistas/IniciarSesion.jsp");
                    }
                }
                if (dt instanceof DtArtista) {
                    sesion.setAttribute("error", "No pueden ingresar artistas");
                    response.sendRedirect("/EspotifyMovil/Vistas/IniciarSesion.jsp");
                }
                if (dt == null) {
                    sesion.setAttribute("error", "Usuario y contraseña incorrectos");
                    response.sendRedirect("/EspotifyMovil/Vistas/IniciarSesion.jsp");
                }
            }
            if (request.getParameter("CerrarSesion") != null) {
                request.getSession().removeAttribute("Usuario");
                Cookie[] cookies = request.getCookies();
                cookies = request.getCookies();

                for (Cookie c : cookies) {
                    if (c.getName().equals("Join")) {
                        c.setMaxAge(0); //se elimina el cookie
                        response.addCookie(c);
                    }
                }

                response.sendRedirect("/EspotifyMovil/Vistas/IniciarSesion.jsp");
            }
            
            if (request.getParameter("descargar") != null) {
//                if (tipoArchivo.equals("audio")) {
                    try {
                        DtUsuario dt = (DtUsuario) request.getSession().getAttribute("Usuario");
                        if (dt != null && dt instanceof DtCliente && wscli.suscripcionVigente(dt.getNickname())) {
                            String ruta = request.getParameter("descargar");
                            String nomTema = request.getParameter("tema");
                            String nomAlbum = request.getParameter("album");
                            String nickArtista = request.getParameter("artista");
                            DtArtista dtArt = wsart.elegirArtista(nickArtista);
                            String nomDescarga = dtArt.getNombre()+" "+dtArt.getApellido()+" - "+nomTema+".mp3";
                            
                            response.setContentType("audio/mpeg");
                            response.addHeader("Content-Disposition", "attachment; filename=" +"\""+nomDescarga+"\""); //indica que es un archivo para descargar
                            //"\""+nomDescarga+"\"" --> "Artista - Tema.mp3"
                            
                            byte[] audio = wsarch.cargarArchivo(ruta).getByteArray();

                            response.setContentType("audio/mpeg");
                            response.setContentLength((int) audio.length);

                            try (OutputStream out = response.getOutputStream()) {
                                out.write(audio);
                                out.flush();
                            }catch(IOException ex){
                                //Si salta la excepcion el usuario cancelo la descarga
                                request.getSession().setAttribute("Mensaje", "cancelo la descarga");
                            }

                            //Poner la funcion en webservice aertistas
                            wsart.nuevaDescargaTema(nickArtista, nomAlbum, nomTema);
                        } else {
                            if (dt == null) {
                                request.getSession().setAttribute("Mensaje", "Inicie sesión");
                            } else if (dt instanceof DtArtista) {
                                request.getSession().setAttribute("Mensaje", "Los artistas no pueden descargar temas");
                            } else {
                                request.getSession().setAttribute("Mensaje", "No tiene suscripción vigente");
                            }
                            response.sendRedirect("ServletGeneral?Inicio=true");
                            //response.getWriter().write("ERROR : " + ex.getMessage());
                        }
                    } catch (IOException_Exception ex) {
                        Logger.getLogger(ServletGeneral.class.getName()).log(Level.SEVERE, null, ex);
                    }
            }
            
            if (request.getParameter("Inicio") != null) {
                List<DtGenero> generos = wsart.buscarGenero("").getGeneros();
                request.getSession().setAttribute("Generos", generos);
                List<DtUsuario> artistas = wsart.listarArtistas().getUsuarios();
                request.getSession().setAttribute("Artistas", artistas);
                List<DtUsuario> clientes = wscli.listarClientes().getUsuarios();
                request.getSession().setAttribute("Clientes", clientes);  
                List<DtLista> listas = wscli.resultadosL("").getListas();
                request.getSession().setAttribute("Listas", listas);
                
                String claveCliente = null;
                String nickCookie = null;
                Cookie[] cookies = request.getCookies();

                if (cookies != null) {
                    for (Cookie c : cookies) {
                        if (c.getName().equals("Join")) {
                            nickCookie = c.getValue();
                            claveCliente = nickCookie;
                        }
                    }
                }

                if (claveCliente != null) {
                    DtCliente dt = wscli.verPerfilCliente(claveCliente);
                    wscli.actualizarVigenciaSuscripciones(dt.getNickname());
                    request.getSession().setAttribute("Usuario", dt);
                    sesion.setAttribute("Mensaje", "Bienvenido/a " + dt.getNombre() + " " + dt.getApellido());
                    response.sendRedirect("/EspotifyMovil/Vistas/index.jsp");
                } else {
                    if (sesion.getAttribute("Usuario") != null) {
                        response.sendRedirect("/EspotifyMovil/Vistas/index.jsp");
                    } else {
                        response.sendRedirect("/EspotifyMovil/Vistas/IniciarSesion.jsp");
                    }
                }
            }
                        
            if (request.getParameter("listaalbumesg")!= null){
                String nombre= request.getParameter("listaalbumesg");
                List<DtAlbum> albumes = wsart.listarAlbumGenero(nombre).getAlbumes();
                List<DtLista> listas = wsart.getListasGenero(nombre).getListas();
                request.getSession().setAttribute("Albume", albumes);
                request.getSession().setAttribute("Listas", listas);                
            }
            if (request.getParameter("listarlistapd")!= null){
                String nLista = request.getParameter("listarlistapd");
                nLista = nLista.trim();
                DtListaPD aux = wscli.listaPD(nLista);
                request.getSession().setAttribute("Lista", (DtLista)aux);
            }

            if (request.getParameter("listarlistap") != null) {
                String nLista = request.getParameter("listarlistap");
                String nick = request.getParameter("listarlistapnick");
                nLista = nLista.trim();
                DtListaP aux = wscli.listaP(nick, nLista);
                request.getSession().setAttribute("Lista2", (DtLista)aux);
                DtCliente dtc = wscli.verPerfilCliente(nick);
                request.getSession().setAttribute("nombrecreador", dtc.getNombre()+" "+dtc.getApellido());
            }
            if (request.getParameter("listaralbumes") != null) {
                String artista = request.getParameter("listaralbumes");
                List<DtUsuario> artistas = (List<DtUsuario>) request.getSession().getAttribute("Artistas");
                DtArtista dt = null;
                for (int i = 0; i < artistas.size(); i++) {
                    if (artistas.get(i).getNickname().equals(artista)) {
                        dt = (DtArtista) artistas.get(i);
                    }
                }
                if (dt != null) {
                    List<DtAlbum> albumes = dt.getAlbumes();
                    request.getSession().setAttribute("Albumes", albumes);
                    request.getSession().setAttribute("PerfilArt", dt);
                }
            }
            if (request.getParameter("consultaalbum") != null) {
                String nomalbum = request.getParameter("consultaalbum");
                String nomart = request.getParameter("nomart");
                DtArtista dt = null;
                List<DtUsuario> artistas = (List<DtUsuario>) sesion.getAttribute("Artistas");
                for (int i=0;i<artistas.size();i++){
                    if (artistas.get(i).getNickname().equals(nomart)){
                        dt = (DtArtista) artistas.get(i);
                    }
                }
                DtAlbum dta = null;
                List<DtAlbum> listaalbumes = dt.getAlbumes();
                for (int i = 0; i < listaalbumes.size(); i++) {
                    if (listaalbumes.get(i).getNombre().equals(nomalbum)) {
                        dta = (DtAlbum) listaalbumes.get(i);
                    }
                }
                if (dta != null) {
                    sesion.setAttribute("veralbum", dta);
                    sesion.setAttribute("PerfilArt", dt);
                }
            }
            if (request.getParameter("reproducirAlbum") != null) {
                String album = request.getParameter("reproducirAlbum");
                String artista = request.getParameter("artista");
                String temaSeleccionado = request.getParameter("tema");
                //            response.getWriter().write(temaSeleccionado);
                List<DtTema> temas = wsarch.reproducirAlbum(artista, album).getTemas();
                request.getSession().setAttribute("temasAReproducir", temas);
                //Si es el rquest que se envia al seleccionar un tema
                for (DtTema tema : temas) {
                    if (tema.getNombre().equals(temaSeleccionado)) {
                        request.getSession().setAttribute("reproducirTema", tema);
                        break;
                    }
                } 
            }
            
            if (request.getParameter("nuevareproduccion") != null) {
    //            response.getWriter().write("nuevadescarga");
                String artista = request.getParameter("artista");
                String album = request.getParameter("album");
                String tema = request.getParameter("tema");
                List<DtUsuario> artistas = (List<DtUsuario>) request.getSession().getAttribute("Artistas");
                DtArtista dt = null;
                for (int i=0;i<artistas.size();i++){
                    if (artistas.get(i).getNickname().equals(artista)){
                        dt = (DtArtista) artistas.get(i);
                        for (int j=0;j<dt.getAlbumes().size();j++){
                            if (dt.getAlbumes().get(j).getNombre().equals(album)){
                                for (int h=0;h<dt.getAlbumes().get(j).getTemas().size();h++){
                                    if (dt.getAlbumes().get(j).getTemas().get(h).getNombre().equals(tema)){
                                        DtTema dtt = dt.getAlbumes().get(j).getTemas().get(h);
                                        dtt.setCantReproduccion(dtt.getCantReproduccion()+1);
                                    }
                                }
                            }
                        }
                    }
                }
                //Poner la funcion en webservice aertistas
                wsart.nuevaReproduccionTema(artista, album, tema);
                //Redirecciona a la pagina indicada 
            }
            
            if (request.getParameter("tipo")!= null) {
                String tipoArchivo = request.getParameter("tipo");
                if (tipoArchivo.equals("audio")) {
                    try {
                        String ruta = request.getParameter("ruta");
                        response.setContentType("audio/mpeg");
                        response.addHeader("Content-Disposition", "attachment; filename=" + "NombreTema.mp3"); //indica que es un archivo para descargar

                        byte[] audio = wsarch.cargarArchivo(ruta).getByteArray();
                        System.out.println(audio.length);

                        response.setContentType("audio/mpeg");
                        response.setContentLength((int) audio.length);

                        OutputStream out = response.getOutputStream();
                        out.write(audio);
                        out.close();

                    } catch (IOException_Exception ex) {
                        Logger.getLogger(ServletGeneral.class.getName()).log(Level.SEVERE, null, ex);
                    }
                } else {
                    try {
                        // tipo == "imagen"
                        String ruta = request.getParameter("ruta");

                        byte[] img = wsarch.cargarArchivo(ruta).getByteArray();
                        response.setContentType("image/jpg");
                        response.setContentLength((int) img.length);
                        OutputStream out = response.getOutputStream();
                        //ImageIO.write(img, "png", out);
                        out.write(img);
                        out.close();
                    } catch (IOException_Exception ex) {
                        Logger.getLogger(ServletGeneral.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            }

        } catch (WebServiceException ex) {
           response.sendRedirect("/EspotifyMovil/Vistas/Error.html");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
