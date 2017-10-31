/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.util.Properties;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.namespace.QName;
import webservices.DataUsuarios;
import webservices.DtCliente;
import webservices.DtUsuario;
import webservices.WSArtistas;
import webservices.WSArtistasService;
import webservices.WSClientes;
import webservices.WSClientesService;

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

        //try {
            Properties propiedades = new Properties();
            String rutaConfWS = this.getClass().getClassLoader().getResource("").getPath();
            rutaConfWS = rutaConfWS.replace("build/web/WEB-INF/classes/", "webservices.properties");
            rutaConfWS = rutaConfWS.replace("%20", " ");
            InputStream entrada = new FileInputStream(rutaConfWS);
            propiedades.load(entrada);// cargamos el archivo de propiedades

            URL url = new URL("http://" + propiedades.getProperty("ipServidor") + ":" + propiedades.getProperty("puertoWSArt") + "/" + propiedades.getProperty("nombreWSArt"));
            WSArtistasService wsarts = new WSArtistasService(url, new QName("http://WebServices/", "WSArtistasService"));
            WSArtistas wsart = wsarts.getWSArtistasPort();

            url = new URL("http://" + propiedades.getProperty("ipServidor") + ":" + propiedades.getProperty("puertoWSCli") + "/" + propiedades.getProperty("nombreWSCli"));
            WSClientesService wsclis = new WSClientesService(url, new QName("http://WebServices/", "WSClientesService"));
            WSClientes wscli = wsclis.getWSClientesPort();

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

                        if (dt instanceof DtCliente) {
                            //Verificar y actualizar si las suscripciones del cliente que estaban vigentes se vencieron
                            wscli.actualizarVigenciaSuscripciones(dt.getNickname());
                        }

                        response.sendRedirect("/EspotifyMovil/Vistas/index.jsp");
                    } else {
                        if (!(wscli.verificarDatosCli(nickname, nickname) && wsart.verificarDatosArt(nickname, nickname))) {
                            sesion.setAttribute("error", "Contraseña incorrecta");
                        } else {
                            sesion.setAttribute("error", "Usuario y contraseña incorrectos");
                        }

                        response.sendRedirect("/EspotifyMovil/Vistas/IniciarSesion.jsp");
                    }

                } else {
                    sesion.setAttribute("error", "No pueden ingresar artistas");
                    response.sendRedirect("/EspotifyMovil/Vistas/IniciarSesion.jsp");
                }
            }

            if (request.getParameter("CerrarSesion") != null) {
                request.getSession().removeAttribute("Usuario");
                Cookie[] cookies = request.getCookies();
                cookies = request.getCookies();
                
                for(Cookie c: cookies){
                    if(c.getName().equals("Join")){
                        c.setMaxAge(0); //se elimina el cookie
                        response.addCookie(c);
                    }
                }
                
                response.sendRedirect("/EspotifyMovil/Vistas/IniciarSesion.jsp");
            }

            if (request.getParameter("Inicio") != null) {
                String claveCliente = null;
                String nickCookie = null;
                Cookie[] cookies = request.getCookies();
                
                if(cookies!=null){
                    for (Cookie c : cookies) {
                        if (c.getName().equals("Join")) {
                            nickCookie = c.getValue();
                            claveCliente = nickCookie;
                        }
                    }
                }
                
                if(claveCliente!=null){
                    DtCliente dt=wscli.verPerfilCliente(claveCliente);
                    wscli.actualizarVigenciaSuscripciones(dt.getNickname());
                    request.getSession().setAttribute("Usuario",dt);
                    sesion.setAttribute("Mensaje", "Bienvenido/a " + dt.getNombre() + " " + dt.getApellido());
                    response.sendRedirect("/EspotifyMovil/Vistas/index.jsp");
                }else{
                    response.sendRedirect("/EspotifyMovil/Vistas/IniciarSesion.jsp"); 
                }
            }

        /*} catch (Exception ex) {
           response.sendRedirect("/EspotifyMovil/Vistas/Error.html");
        }*/
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
