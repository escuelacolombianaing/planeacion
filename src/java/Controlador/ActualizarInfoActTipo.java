/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import BDatos.BDServicios;
import BDatos.BaseDatos;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author nicolas.almanzar
 */
public class ActualizarInfoActTipo extends HttpServlet {

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
            out.println("<title>Servlet ActualizaActividad</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ActualizaActividad at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
       // processRequest(request, response);
        
        String rubrosel,TipRub,AnioRub,ValorRub,ObsRub, act,idreg,idp,vlrub, tipusr; 
        rubrosel        = request.getParameter("rubrosel");
        AnioRub         = request.getParameter("AnioRubro");
        ValorRub        = request.getParameter("ValorRubro");
        ObsRub          = request.getParameter("ObsRubro");
        idreg           = request.getParameter("idreg");
        act             = request.getParameter("act");
        idp             = request.getParameter("idp");
        tipusr             = request.getParameter("tipusr");
        BDServicios bd = new BDServicios();
        
        TipRub     = bd.ConsultaTipoRubro(rubrosel);
      
        int retorno = 0;
                retorno = bd.ActualizarRubro(rubrosel,TipRub,AnioRub,ValorRub,ObsRub,idreg);
                
        if(retorno != 0){      
                    
            if(tipusr.equals("U")){
            response.sendRedirect("DetalleActividad?idp="+idp+"&act="+act); 
            }else if(tipusr.equals("editact")){
                 response.sendRedirect("editact?idp="+idp+"&act="+act);
        }else{
             response.sendRedirect("DetalleActividadadm?idp="+idp+"&act="+act);
        }
            
        } 
           
        
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
