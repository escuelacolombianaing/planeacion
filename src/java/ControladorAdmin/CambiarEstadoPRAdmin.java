/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ControladorAdmin;

import BDatos.BDServiciosAdmin;
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
public class CambiarEstadoPRAdmin extends HttpServlet {

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
            out.println("<title>Servlet CambiarEstadoPRAdmin</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CambiarEstadoPRAdmin at " + request.getContextPath() + "</h1>");
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
        
        
        String idp, obs, btnest,estado = null, estini;
        
        
        idp         = request.getParameter("idp");
        obs         = request.getParameter("observadmin");
        btnest      = request.getParameter("btnest");
        estini     = request.getParameter("estini");
        
        
        if(btnest.equals("GUARDAR")){
            estado = estini;
        }
        if(btnest.equals("APROBAR")){
            estado = "4";
        }
        if(btnest.equals("DEVOLVER A PLANEACIÓN")){
            estado = "3";
        }
        if(btnest.equals("CANCELAR")){
            estado = "7";
        }
        
        BDServiciosAdmin bda = new BDServiciosAdmin();
        
        int ret = bda.CambiaEstadoPRadmin(idp, estado, obs);
        
        
        if(btnest.equals("GUARDAR")){
                response.sendRedirect("/planeacion/detalleproyadm?idp="+idp+"#collapseEight");
        }
        else{
                response.sendRedirect("/planeacion/proyectosactadm");
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
