/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import BDatos.BDServicios;
import javax.servlet.http.HttpSession;
/**
 *
 * @author Juan Vanzina
 */
public class CreaProyecto extends HttpServlet {

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
            out.println("<title>Servlet CreaProyecto</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreaProyecto at " + request.getContextPath() + "</h1>");
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
        
        response.setContentType("text/html;charset=UTF-8");
        
        BDServicios bd = new BDServicios();
        HttpSession  sesion;
        String NombrePr,Plan,SNIES, CCUser, lastpr;
        
        sesion = request.getSession(true);
        
        NombrePr = request.getParameter("nompr");
        Plan     = request.getParameter("plan");
        SNIES    = request.getParameter("snies");
        CCUser   = sesion.getAttribute("cod_emp").toString();
        
        int resp = 0;
        resp = bd.CreacionProyecto(NombrePr, Plan, SNIES, CCUser);

        if(resp!=0){
            lastpr = bd.LastProyectUser(CCUser).elementAt(0).toString();
            response.sendRedirect("/planeacion/detalleproy?idp="+lastpr);
        }
        else{
            response.sendRedirect("/planeacion/proyectosact?m=0");
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
