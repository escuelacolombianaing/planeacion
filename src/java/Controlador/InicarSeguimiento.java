/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import BDatos.BDServicios;
import BDatos.BaseDatos;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Juan Vanzina
 */
public class InicarSeguimiento extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet InicarSeguimiento</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InicarSeguimiento at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {            
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
        
        String idproyecto, idseg, usr;
        
        
        
        HttpSession    sesion;
        sesion       = request.getSession(true);
        usr = sesion.getAttribute("cod_emp").toString();
        
        idproyecto  = request.getParameter("idp");
        
        String idpAuX = idproyecto;                
        
        BaseDatos   bp  = new BaseDatos();
        BDServicios bd  = new BDServicios();
        
        
        if(!bd.ConSiPerteneceAMegaPro(idproyecto).equals("NA")){
            
            idpAuX = idproyecto;
            idproyecto = bd.ConSiPerteneceAMegaPro(idproyecto);
        
        }
        
        bp.conectarBDErpProcCrea(idproyecto);
                
        idseg = bd.consultaultseg(idproyecto);
        
        
         Vector ProyectosAsociadosMegaPro   = new Vector();
                
          ProyectosAsociadosMegaPro = bd.ConsultaProyAsociadosMegapro(idproyecto);
          
          if(ProyectosAsociadosMegaPro.size()>0){
          
              for(int iq = 0 ; iq < ProyectosAsociadosMegaPro.size(); iq++){
                  
                  Vector aux = (Vector)ProyectosAsociadosMegaPro.elementAt(iq); 
                  
                  bp.conectarBDErpProcCrea(aux.elementAt(0).toString());
                  bd.RegistroSegSubproyectosMegapro(idseg, bd.consultaultseg(aux.elementAt(0).toString()));
                                    
              }   
          }
          
         
             idproyecto = idpAuX;
         
        
        response.sendRedirect("/planeacion/seguimientoPR?idp="+idproyecto+"&seg="+bd.consultaultseg(idproyecto));
        
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
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
