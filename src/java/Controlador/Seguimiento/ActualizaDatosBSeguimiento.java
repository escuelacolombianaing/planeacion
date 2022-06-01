/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.Seguimiento;

import BDatos.BDServicios;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Juan Vanzina
 */
public class ActualizaDatosBSeguimiento extends HttpServlet {

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
            out.println("<title>Servlet ActualizaDatosBSeguimiento</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ActualizaDatosBSeguimiento at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        
        String estadoejec, porcejec, descavan, acciones, idp, idseg, dificultades;
        
        idp         = request.getParameter("idp");
        idseg       = request.getParameter("idseg");
        estadoejec  = request.getParameter("estadoejec");
        porcejec    = request.getParameter("porcejec");
        descavan    = request.getParameter("descavan");    
        acciones    = request.getParameter("acciones");
        dificultades= request.getParameter("dificultades");
        
        
        BDServicios bd = new BDServicios();
        
        
        int retorno = bd.ActualizarSeguimiento(idseg, porcejec, estadoejec, "1", descavan, acciones, dificultades);
        
        
       if(retorno !=0){

           response.sendRedirect("/planeacion/seguimientoPR?idp="+idp+"&seg="+idseg+"#collapseThree");
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
